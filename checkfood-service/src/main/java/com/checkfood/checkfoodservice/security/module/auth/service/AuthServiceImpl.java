package com.checkfood.checkfoodservice.security.module.auth.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.*;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.*;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.LogoutRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.RefreshRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.RegisterRequest;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.TokenResponse;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.UserResponse;
import com.checkfood.checkfoodservice.security.module.auth.email.EmailService;
import com.checkfood.checkfoodservice.security.module.auth.entity.VerificationTokenEntity;
import com.checkfood.checkfoodservice.security.module.auth.exception.AuthException;
import com.checkfood.checkfoodservice.security.module.auth.logging.AuthLogger;
import com.checkfood.checkfoodservice.security.module.auth.mapper.AuthMapper;
import com.checkfood.checkfoodservice.security.module.auth.repository.VerificationTokenRepository;
import com.checkfood.checkfoodservice.security.module.auth.validator.RegisterRequestValidator;
import com.checkfood.checkfoodservice.security.module.jwt.service.JwtService;
import com.checkfood.checkfoodservice.security.module.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.repository.RoleRepository;
import com.checkfood.checkfoodservice.security.module.user.service.DeviceService;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.authentication.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.UUID;

/**
 * Implementace autentizační služby pro správu uživatelských účtů a relací.
 * Zajišťuje registraci s email verifikací, přihlašování, správu tokenů a auditování bezpečnostních událostí.
 * Všechny operace jsou transakční pro zajištění konzistence dat.
 *
 * @see AuthService
 * @see JwtService
 * @see DeviceService
 * @see EmailService
 */
@Service
@RequiredArgsConstructor
@Transactional
public class AuthServiceImpl implements AuthService {

    private final AuthenticationManager authenticationManager;
    private final UserService userService;
    private final DeviceService deviceService;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final RegisterRequestValidator registerValidator;
    private final AuthMapper authMapper;
    private final ApplicationEventPublisher eventPublisher;
    private final HttpServletRequest request;
    private final VerificationTokenRepository verificationTokenRepository;
    private final EmailService emailService;
    private final AuthLogger authLogger;

    /**
     * Zaregistruje nového uživatele s neaktivním stavem a zahájí email verifikaci.
     * Validuje registrační data, kontroluje duplicitu emailu, vytvoří účet s výchozí rolí USER
     * a odešle verifikační email.
     *
     * @param requestDto registrační data uživatele
     * @throws AuthException pokud email již existuje nebo systémová role USER není nalezena
     */
    @Override
    public void register(RegisterRequest requestDto) {
        registerValidator.validate(requestDto);

        if (userService.existsByEmail(requestDto.getEmail())) {
            publishAudit(null, AuditAction.REGISTER, AuditStatus.FAILED);
            throw AuthException.emailExists();
        }

        RoleEntity userRole = roleRepository.findByName("USER")
                .orElseThrow(() -> AuthException.internalError("Systémová chyba: Výchozí role USER nebyla nalezena."));

        UserEntity user = UserEntity.builder()
                .email(requestDto.getEmail())
                .firstName(requestDto.getFirstName())
                .lastName(requestDto.getLastName())
                .password(passwordEncoder.encode(requestDto.getPassword()))
                .enabled(false)
                .roles(Collections.singleton(userRole))
                .build();

        UserEntity savedUser = userService.save(user);

        generateAndSendVerificationToken(savedUser);

        authLogger.logRegistration(savedUser.getEmail());
        publishAudit(savedUser.getId(), AuditAction.REGISTER, AuditStatus.SUCCESS);
    }

    /**
     * Znovuodešle verifikační email s novým tokenem.
     * Invaliduje všechny předchozí tokeny uživatele a vygeneruje nový.
     * Kontroluje, zda účet již není aktivován.
     *
     * @param email emailová adresa uživatele
     * @throws AuthException pokud je účet již aktivován
     */
    @Override
    public void resendVerificationCode(String email) {
        UserEntity user = userService.findByEmail(email);

        if (user.isEnabled()) {
            throw AuthException.internalError("Účet je již aktivován.");
        }

        verificationTokenRepository.deleteByUser(user);
        generateAndSendVerificationToken(user);

        authLogger.logResendVerificationCode(user.getEmail());
        publishAudit(user.getId(), AuditAction.VERIFY_EMAIL, AuditStatus.SUCCESS);
    }

    /**
     * Vygeneruje nový verifikační token a odešle ho emailem.
     * Token je platný 24 hodin.
     *
     * @param user uživatel, pro kterého se generuje token
     */
    private void generateAndSendVerificationToken(UserEntity user) {
        String token = UUID.randomUUID().toString();
        VerificationTokenEntity verificationToken = VerificationTokenEntity.builder()
                .token(token)
                .user(user)
                .expiryDate(VerificationTokenEntity.calculateExpiryDate(24 * 60))
                .build();

        verificationTokenRepository.save(verificationToken);
        emailService.sendVerificationEmail(user.getEmail(), token);
        authLogger.logVerificationEmailSent(user.getEmail());
    }

    /**
     * Aktivuje uživatelský účet na základě verifikačního tokenu.
     * Kontroluje platnost tokenu a jeho expiraci. Po úspěšné aktivaci token maže.
     *
     * @param token verifikační token z emailu
     * @throws AuthException pokud je token neplatný nebo expirovaný
     */
    @Override
    public void verifyAccount(String token) {
        VerificationTokenEntity verificationToken = verificationTokenRepository.findByToken(token)
                .orElseThrow(AuthException::invalidVerificationToken);

        if (verificationToken.getExpiryDate().isBefore(LocalDateTime.now())) {
            throw AuthException.verificationTokenExpired();
        }

        UserEntity user = verificationToken.getUser();
        if (user.isEnabled()) {
            verificationTokenRepository.delete(verificationToken);
            return;
        }

        user.setEnabled(true);
        userService.save(user);

        verificationTokenRepository.delete(verificationToken);

        authLogger.logAccountActivated(user.getEmail());
        publishAudit(user.getId(), AuditAction.VERIFY_EMAIL, AuditStatus.SUCCESS);
    }

    /**
     * Autentizuje uživatele a vytvoří novou relaci.
     * Ověří přihlašovací údaje, kontroluje stav účtu, registruje zařízení a generuje tokeny.
     *
     * @param requestDto přihlašovací údaje a informace o zařízení
     * @return autentizační odpověď s tokeny a informacemi o uživateli
     * @throws AuthException při neplatných údajích, neaktivním nebo uzamčeném účtu
     */
    @Override
    public AuthResponse login(LoginRequest requestDto) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(requestDto.getEmail(), requestDto.getPassword())
            );
        } catch (BadCredentialsException ex) {
            authLogger.logFailedLogin(requestDto.getEmail(), "Neplatné přihlašovací údaje");
            publishAudit(null, AuditAction.LOGIN, AuditStatus.FAILED);
            throw AuthException.invalidCredentials();
        } catch (DisabledException ex) {
            authLogger.logFailedLogin(requestDto.getEmail(), "Účet není aktivní");
            publishAudit(null, AuditAction.LOGIN, AuditStatus.BLOCKED);
            throw AuthException.accountNotVerified();
        } catch (LockedException ex) {
            authLogger.logFailedLogin(requestDto.getEmail(), "Účet je uzamčen");
            publishAudit(null, AuditAction.LOGIN, AuditStatus.BLOCKED);
            throw AuthException.accountLocked();
        }

        UserEntity user = userService.findWithRolesByEmail(requestDto.getEmail());
        registerOrUpdateDevice(user, requestDto);

        authLogger.logSuccessfulLogin(user.getEmail());
        publishAudit(user.getId(), AuditAction.LOGIN, AuditStatus.SUCCESS);
        return buildAuthResponse(user);
    }



    /**
     * Synchronizuje stav klientského terminálu a aktualizuje auditní metadata.
     * Zajišťuje, že pro daný identifikátor existuje v systému právě jedna aktivní relace.
     *
     * @param user subjekt, kterému je zařízení asociováno
     * @param dto klientský požadavek s identifikátory a metadaty terminálu
     */
    private void registerOrUpdateDevice(UserEntity user, LoginRequest dto) {
        if (dto.getDeviceIdentifier() == null) return;

        // Pokud zařízení existuje, načteme jej, jinak inicializujeme novou instanci
        DeviceEntity device = deviceService.findByIdentifier(dto.getDeviceIdentifier())
                .orElse(new DeviceEntity());

        device.setUser(user);
        device.setDeviceIdentifier(dto.getDeviceIdentifier());
        device.setDeviceName(dto.getDeviceName() != null ? dto.getDeviceName() : "Neznámé zařízení");
        device.setDeviceType(dto.getDeviceType());
        device.setLastIpAddress(request.getRemoteAddr());
        device.setUserAgent(request.getHeader("User-Agent"));
        device.setLastLogin(LocalDateTime.now());

        deviceService.save(device);
    }

    /**
     * Realizuje rotaci autentizačních artefaktů na základě platného Refresh Tokenu.
     * Provádí striktní validaci vazby tokenu na konkrétní klientský terminál.
     *
     * @param requestDto transportní objekt s refresh tokenem a identifikátorem zařízení
     * @return nový pár bezpečnostních tokenů (Access & Refresh)
     * @throws AuthException v případě exspirace relace nebo neautorizovaného pokusu o refresh
     */
    @Override
    public TokenResponse refreshToken(RefreshRequest requestDto) {
        String email = jwtService.extractEmail(requestDto.getRefreshToken());
        UserEntity user = userService.findByEmail(email);

        // Validace integrity tokenu a existence registrované relace pro daný subjekt
        if (!jwtService.isTokenValid(requestDto.getRefreshToken(), user) ||
                !deviceService.existsByIdentifierAndUser(requestDto.getDeviceIdentifier(), user)) {

            authLogger.logTokenRefresh(email);
            publishAudit(user.getId(), AuditAction.REFRESH_TOKEN, AuditStatus.FAILED);
            throw AuthException.sessionExpired();
        }

        String newAccessToken = jwtService.generateAccessToken(user);
        String newRefreshToken = jwtService.generateRefreshToken(user);

        deviceService.updateLastLogin(requestDto.getDeviceIdentifier());

        authLogger.logTokenRefresh(user.getEmail());
        publishAudit(user.getId(), AuditAction.REFRESH_TOKEN, AuditStatus.SUCCESS);

        return authMapper.toTokenResponse(
                newAccessToken,
                newRefreshToken,
                jwtService.getAccessTokenExpirationSeconds()
        );
    }

    /**
     * Odhlásí uživatele a ukončí relaci na daném zařízení.
     * Odstraní záznam o zařízení z databáze, čímž invaliduje všechny tokeny vydané pro toto zařízení.
     *
     * @param requestDto obsahuje refresh token a identifikátor zařízení
     */
    @Override
    public void logout(LogoutRequest requestDto) {
        String email = jwtService.extractEmail(requestDto.getRefreshToken());
        UserEntity user = userService.findByEmail(email);

        deviceService.findByIdentifier(requestDto.getDeviceIdentifier())
                .ifPresent(device -> {
                    if (device.getUser().getId().equals(user.getId())) {
                        deviceService.removeByIdAndUser(device.getId(), user);
                    }
                });

        authLogger.logLogout(user.getEmail());
        publishAudit(user.getId(), AuditAction.LOGOUT, AuditStatus.SUCCESS);
    }

    /**
     * Vrátí informace o aktuálně přihlášeném uživateli ze Security kontextu.
     *
     * @param userDetails autentizační detaily z Security Contextu
     * @return DTO s informacemi o uživateli včetně rolí
     */
    @Override
    @Transactional(readOnly = true)
    public UserResponse getCurrentUser(org.springframework.security.core.userdetails.UserDetails userDetails) {
        UserEntity user = userService.findWithRolesByEmail(userDetails.getUsername());
        return authMapper.toUserResponse(user);
    }

    /**
     * Sestaví kompletní autentizační odpověď s tokeny a informacemi o uživateli.
     *
     * @param user entita uživatele
     * @return autentizační odpověď
     */
    private AuthResponse buildAuthResponse(UserEntity user) {
        String accessToken = jwtService.generateAccessToken(user);
        String refreshToken = jwtService.generateRefreshToken(user);
        return authMapper.toAuthResponse(user, accessToken, refreshToken, jwtService.getAccessTokenExpirationSeconds());
    }

    /**
     * Publikuje auditní událost do event systému.
     * Událost obsahuje informace o akci, statusu, uživateli a kontextu požadavku.
     *
     * @param userId ID uživatele (null pro anonymní akce)
     * @param action typ provedené akce
     * @param status výsledek akce
     */
    private void publishAudit(Long userId, AuditAction action, AuditStatus status) {
        eventPublisher.publishEvent(new AuditEvent(
                this,
                userId,
                action,
                status,
                request.getRemoteAddr(),
                request.getHeader("User-Agent")
        ));
    }
}