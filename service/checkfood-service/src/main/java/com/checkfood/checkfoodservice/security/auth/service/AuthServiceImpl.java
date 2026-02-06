package com.checkfood.checkfoodservice.security.auth.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.auth.dto.request.*;
import com.checkfood.checkfoodservice.security.auth.dto.response.*;
import com.checkfood.checkfoodservice.security.auth.email.EmailService;
import com.checkfood.checkfoodservice.security.auth.entity.VerificationTokenEntity;
import com.checkfood.checkfoodservice.security.auth.exception.AuthException;
import com.checkfood.checkfoodservice.security.auth.mapper.AuthMapper;
import com.checkfood.checkfoodservice.security.auth.repository.VerificationTokenRepository;
import com.checkfood.checkfoodservice.security.auth.validator.RegisterRequestValidator;
import com.checkfood.checkfoodservice.security.jwt.JwtService;
import com.checkfood.checkfoodservice.security.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.user.repository.RoleRepository;
import com.checkfood.checkfoodservice.security.user.service.DeviceService;
import com.checkfood.checkfoodservice.security.user.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.authentication.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional // Celá třída je transakční pro zajištění konzistence DB
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

        // Generování prvotního tokenu
        generateAndSendVerificationToken(savedUser);

        publishAudit(savedUser.getId(), AuditAction.REGISTER, AuditStatus.SUCCESS);
    }

    @Override
    public void resendVerificationCode(String email) {
        log.info("Žádost o znovuzaslání verifikačního kódu pro: {}", email);
        UserEntity user = userService.findByEmail(email);

        if (user.isEnabled()) {
            throw AuthException.internalError("Účet je již aktivován.");
        }

        // ✅ ROTACE TOKENU: Smažeme starý token (i expirovaný) a vytvoříme nový
        verificationTokenRepository.deleteByUser(user);

        generateAndSendVerificationToken(user);

        // Poznámka: Pokud nemáš v AuditAction RESEND_VERIFICATION, použij VERIFY_EMAIL nebo REGISTER
        publishAudit(user.getId(), AuditAction.VERIFY_EMAIL, AuditStatus.SUCCESS);
    }

    private void generateAndSendVerificationToken(UserEntity user) {
        String token = UUID.randomUUID().toString();
        VerificationTokenEntity verificationToken = VerificationTokenEntity.builder()
                .token(token)
                .user(user)
                //.expiryDate(VerificationTokenEntity.calculateExpiryDate(24 * 60)) // 24 hodin
                .expiryDate(LocalDateTime.now().plusSeconds(10)) //simulace expirovaného tokenu
                .build();

        verificationTokenRepository.save(verificationToken);

        log.info("Odesílám verifikační email s tokenem na: {}", user.getEmail());
        emailService.sendVerificationEmail(user.getEmail(), token);
    }

    @Override
    public void verifyAccount(String token) {
        VerificationTokenEntity verificationToken = verificationTokenRepository.findByToken(token)
                .orElseThrow(AuthException::invalidVerificationToken);

        // Kontrola expirace (pokud vyprší, vyhodíme 410 Gone přes AuthException)
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

        // Po úspěšné aktivaci token smažeme
        verificationTokenRepository.delete(verificationToken);

        log.info("Účet {} byl úspěšně aktivován.", user.getEmail());
        publishAudit(user.getId(), AuditAction.VERIFY_EMAIL, AuditStatus.SUCCESS);
    }

    @Override
    public AuthResponse login(LoginRequest requestDto) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(requestDto.getEmail(), requestDto.getPassword())
            );
        } catch (BadCredentialsException ex) {
            publishAudit(null, AuditAction.LOGIN, AuditStatus.FAILED);
            throw AuthException.invalidCredentials();
        } catch (DisabledException ex) {
            publishAudit(null, AuditAction.LOGIN, AuditStatus.BLOCKED);
            // Vyhodí 403 s textem, který Flutter pozná a nabídne OVĚŘIT
            throw AuthException.accountNotVerified();
        } catch (LockedException ex) {
            publishAudit(null, AuditAction.LOGIN, AuditStatus.BLOCKED);
            throw AuthException.accountLocked();
        }

        UserEntity user = userService.findWithRolesByEmail(requestDto.getEmail());
        registerOrUpdateDevice(user, requestDto);

        publishAudit(user.getId(), AuditAction.LOGIN, AuditStatus.SUCCESS);
        return buildAuthResponse(user);
    }

    private void registerOrUpdateDevice(UserEntity user, LoginRequest dto) {
        if (dto.getDeviceIdentifier() == null) return;

        DeviceEntity device = deviceService.findByIdentifier(dto.getDeviceIdentifier())
                .orElse(new DeviceEntity());

        device.setUser(user);
        device.setDeviceIdentifier(dto.getDeviceIdentifier());
        device.setDeviceName(dto.getDeviceName() != null ? dto.getDeviceName() : "Neznámé zařízení");
        device.setDeviceType(dto.getDeviceType());
        device.setLastIpAddress(request.getRemoteAddr());
        device.setUserAgent(request.getHeader("User-Agent"));
        device.setLastActiveAt(LocalDateTime.now());

        deviceService.save(device);
    }

    @Override
    public TokenResponse refreshToken(RefreshRequest requestDto) {
        String email = jwtService.extractEmail(requestDto.getRefreshToken());
        UserEntity user = userService.findByEmail(email);

        if (!jwtService.isTokenValid(requestDto.getRefreshToken(), user) ||
                !deviceService.existsByIdentifierAndUser(requestDto.getDeviceIdentifier(), user)) {
            throw AuthException.sessionExpired();
        }

        String newAccessToken = jwtService.generateAccessToken(user);
        String newRefreshToken = jwtService.generateRefreshToken(user);

        deviceService.updateLastActive(requestDto.getDeviceIdentifier());
        publishAudit(user.getId(), AuditAction.REFRESH_TOKEN, AuditStatus.SUCCESS);

        return authMapper.toTokenResponse(newAccessToken, newRefreshToken, jwtService.getAccessTokenExpirationSeconds());
    }

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
        publishAudit(user.getId(), AuditAction.LOGOUT, AuditStatus.SUCCESS);
    }

    @Override
    @Transactional(readOnly = true)
    public UserResponse getCurrentUser(org.springframework.security.core.userdetails.UserDetails userDetails) {
        UserEntity user = userService.findWithRolesByEmail(userDetails.getUsername());
        return authMapper.toUserResponse(user);
    }

    private AuthResponse buildAuthResponse(UserEntity user) {
        String accessToken = jwtService.generateAccessToken(user);
        String refreshToken = jwtService.generateRefreshToken(user);
        return authMapper.toAuthResponse(user, accessToken, refreshToken, jwtService.getAccessTokenExpirationSeconds());
    }

    private void publishAudit(Long userId, AuditAction action, AuditStatus status) {
        eventPublisher.publishEvent(new AuditEvent(this, userId, action, status, request.getRemoteAddr(), request.getHeader("User-Agent")));
    }
}