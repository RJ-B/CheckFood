package com.checkfood.checkfoodservice.security.module.auth.service;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.*;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.*;
import com.checkfood.checkfoodservice.security.module.auth.email.EmailService;
import com.checkfood.checkfoodservice.security.module.auth.entity.PasswordResetTokenEntity;
import com.checkfood.checkfoodservice.security.module.auth.entity.VerificationTokenEntity;
import com.checkfood.checkfoodservice.security.module.auth.exception.AuthException;
import com.checkfood.checkfoodservice.security.module.auth.logging.AuthLogger;
import com.checkfood.checkfoodservice.security.module.auth.mapper.AuthMapper;
import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.auth.repository.PasswordResetTokenRepository;
import com.checkfood.checkfoodservice.security.module.auth.repository.VerificationTokenRepository;
import com.checkfood.checkfoodservice.security.module.auth.validator.PasswordValidator;
import com.checkfood.checkfoodservice.security.module.jwt.service.JwtService;
import com.checkfood.checkfoodservice.security.module.user.dto.response.UserResponse;
import com.checkfood.checkfoodservice.security.module.user.entity.DeviceEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.DeviceService;
import com.checkfood.checkfoodservice.security.module.user.service.RoleService;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

/**
 * Implementace autentizační služby.
 *
 * REFACTORING A OPTIMALIZACE:
 * - Odstraněna závislost na HttpServletRequest (řeší DeviceService).
 * - Odstraněna přímá závislost na RoleRepository (nahrazeno RoleService).
 * - Odstraněna duplicitní logika správy zařízení (delegováno na DeviceService).
 * - Zjednodušena logika logout (delegováno na DeviceService).
 * - Opraveno pořadí kontrol u refresh tokenu.
 */
@Service
@RequiredArgsConstructor
@Transactional
public class AuthServiceImpl implements AuthService {

    private final AuthenticationManager authenticationManager;
    private final UserService userService;
    private final DeviceService deviceService;
    private final RoleService roleService;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthMapper authMapper;
    private final VerificationTokenRepository verificationTokenRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final EmailService emailService;
    private final PasswordValidator passwordValidator;
    private final AuthLogger authLogger;
    private final Clock clock;
    private final RestaurantEmployeeRepository restaurantEmployeeRepository;
    private final RestaurantRepository restaurantRepository;
    private final com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository restaurantTableRepository;

    @Override
    public void register(RegisterRequest requestDto) {
        passwordValidator.validate(requestDto.getPassword());

        if (userService.existsByEmail(requestDto.getEmail())) {
            throw AuthException.emailExists();
        }

        if (requestDto.isOwnerRegistration()) {
            // Registrace majitele — OWNER role + zkušební restaurace
            registerAsOwner(requestDto);
        } else {
            // Standardní registrace zákazníka
            registerAsCustomer(requestDto);
        }
    }

    @Override
    public void registerOwner(RegisterRequest requestDto) {
        passwordValidator.validate(requestDto.getPassword());

        if (userService.existsByEmail(requestDto.getEmail())) {
            throw AuthException.emailExists();
        }

        registerAsOwner(requestDto);
    }

    /**
     * Interní metoda pro registraci běžného zákazníka (role USER).
     */
    private void registerAsCustomer(RegisterRequest requestDto) {
        // RoleService vyhodí UserException.roleNotFound, pokud role neexistuje
        var userRole = roleService.findByName("USER");

        var user = UserEntity.builder()
                .email(requestDto.getEmail())
                .firstName(requestDto.getFirstName())
                .lastName(requestDto.getLastName())
                .password(passwordEncoder.encode(requestDto.getPassword()))
                .authProvider(AuthProvider.LOCAL)
                .providerId(requestDto.getEmail())
                .enabled(false)
                .roles(new HashSet<>(Set.of(userRole)))
                .build();

        var savedUser = userService.save(user);
        generateAndSendVerificationToken(savedUser);
        authLogger.logRegistration(savedUser.getEmail());
    }

    /**
     * Interní metoda pro registraci majitele restaurace (role OWNER).
     * Vytvoří uživatele a automaticky mu přiřadí zkušební restauraci (TRIAL).
     */
    private void registerAsOwner(RegisterRequest requestDto) {
        var ownerRole = roleService.findByName("OWNER");

        var user = UserEntity.builder()
                .email(requestDto.getEmail())
                .firstName(requestDto.getFirstName())
                .lastName(requestDto.getLastName())
                .password(passwordEncoder.encode(requestDto.getPassword()))
                .authProvider(AuthProvider.LOCAL)
                .providerId(requestDto.getEmail())
                .enabled(false)
                .ownerTier(com.checkfood.checkfoodservice.security.module.user.entity.OwnerTier.TRIAL)
                .roles(new HashSet<>(Set.of(ownerRole)))
                .build();

        var savedUser = userService.save(user);

        // Vytvoření 2 zkušebních restaurací (TRIAL) — nejsou viditelné pro hosty
        double lat = requestDto.getLatitude() != null ? requestDto.getLatitude() : 49.7474;
        double lng = requestDto.getLongitude() != null ? requestDto.getLongitude() : 13.3776;

        // Sdílený manažer (fiktivní uživatel)
        var managerRole = roleService.findByName("USER");
        var managerUser = UserEntity.builder()
                .email("manager." + savedUser.getId() + "@trial.checkfood.cz")
                .firstName("Karel")
                .lastName("Manažer")
                .password(passwordEncoder.encode(UUID.randomUUID().toString()))
                .authProvider(AuthProvider.LOCAL)
                .providerId("manager." + savedUser.getId() + "@trial.checkfood.cz")
                .enabled(true)
                .roles(new HashSet<>(Set.of(managerRole)))
                .build();
        var savedManager = userService.save(managerUser);

        String[] restaurantNames = {"Restaurace " + savedUser.getLastName(), "Bistro " + savedUser.getLastName()};
        String[] staffFirstNames = {"Tomáš", "Lucie"};
        CuisineType[] cuisines = {CuisineType.CZECH, CuisineType.ITALIAN};

        for (int r = 0; r < 2; r++) {
            var address = new Address();
            address.setStreet(r == 0 ? "Hlavní 1" : "Vedlejší 5");
            address.setCity("Plzeň");
            address.setPostalCode("301 00");
            address.setCountry("CZ");
            address.setCoordinates(lat + (r * 0.002), lng + (r * 0.003));

            var restaurant = Restaurant.builder()
                    .name(restaurantNames[r])
                    .description("Zkušební restaurace — upravte údaje v nastavení.")
                    .phone("+420 000 000 00" + r)
                    .contactEmail(savedUser.getEmail())
                    .ownerId(UUID.randomUUID())
                    .status(RestaurantStatus.ACTIVE)
                    .active(true)
                    .cuisineType(cuisines[r])
                    .defaultReservationDurationMinutes(60)
                    .onboardingCompleted(true)
                    .address(address)
                    .build();

            // Otevírací doba Po-Ne 10:00-22:00
            var hours = new java.util.ArrayList<com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours>();
            for (var day : java.time.DayOfWeek.values()) {
                hours.add(com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours.builder()
                        .dayOfWeek(day)
                        .openAt(java.time.LocalTime.of(10, 0))
                        .closeAt(java.time.LocalTime.of(22, 0))
                        .closed(false)
                        .build());
            }
            restaurant.setOpeningHours(hours);

            var savedRestaurant = restaurantRepository.save(restaurant);

            // 3 stoly
            for (int t = 1; t <= 3; t++) {
                restaurantTableRepository.save(
                    com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable.builder()
                        .restaurantId(savedRestaurant.getId())
                        .label("Stůl " + t)
                        .capacity(t == 1 ? 2 : t == 2 ? 4 : 6)
                        .active(true)
                        .build()
                );
            }

            // Owner propojení
            restaurantEmployeeRepository.save(RestaurantEmployee.builder()
                    .user(savedUser)
                    .restaurant(savedRestaurant)
                    .role(RestaurantEmployeeRole.OWNER)
                    .build());

            // Sdílený manažer
            restaurantEmployeeRepository.save(RestaurantEmployee.builder()
                    .user(savedManager)
                    .restaurant(savedRestaurant)
                    .role(RestaurantEmployeeRole.MANAGER)
                    .build());

            // Unikátní staff pro každou restauraci
            var staffUser = UserEntity.builder()
                    .email("staff" + (r + 1) + "." + savedUser.getId() + "@trial.checkfood.cz")
                    .firstName(staffFirstNames[r])
                    .lastName("Číšník")
                    .password(passwordEncoder.encode(UUID.randomUUID().toString()))
                    .authProvider(AuthProvider.LOCAL)
                    .providerId("staff" + (r + 1) + "." + savedUser.getId() + "@trial.checkfood.cz")
                    .enabled(true)
                    .roles(new HashSet<>(Set.of(managerRole)))
                    .build();
            var savedStaff = userService.save(staffUser);

            restaurantEmployeeRepository.save(RestaurantEmployee.builder()
                    .user(savedStaff)
                    .restaurant(savedRestaurant)
                    .role(RestaurantEmployeeRole.STAFF)
                    .build());
        }

        generateAndSendVerificationToken(savedUser);
        authLogger.logRegistration(savedUser.getEmail());
    }

    @Override
    public AuthResponse login(LoginRequest requestDto) {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(requestDto.getEmail(), requestDto.getPassword())
            );
        } catch (BadCredentialsException ex) {
            throw AuthException.invalidCredentials();
        } catch (DisabledException ex) {
            throw AuthException.accountNotVerified();
        } catch (LockedException ex) {
            throw AuthException.accountLocked();
        } catch (AccountExpiredException ex) {
            throw AuthException.accountDisabled();
        }

        var user = userService.findWithRolesByEmail(requestDto.getEmail());

        // ✅ Delegace na DeviceService (žádné ruční IP/UA)
        var device = registerOrUpdateDevice(user, requestDto);
        String deviceIdentifier = (device != null) ? device.getDeviceIdentifier() : null;

        authLogger.logSuccessfulLogin(user.getEmail());

        return buildAuthResponse(user, deviceIdentifier);
    }

    @Override
    public TokenResponse refreshToken(RefreshRequest requestDto) {
        // 1. Nejprve extrahujeme data ze starého tokenu a zkontrolujeme shodu zařízení
        String tokenDeviceIdentifier = jwtService.extractDeviceIdentifier(requestDto.getRefreshToken());

        // Bezpečnostní kontrola: Token byl vydán pro jiné zařízení, než které žádá o refresh
        if (tokenDeviceIdentifier != null && !tokenDeviceIdentifier.equals(requestDto.getDeviceIdentifier())) {
            throw AuthException.deviceMismatch();
        }

        // 2. Kontrola, že zařízení existuje a je aktivní (smazané/deaktivované = odmítnutí)
        if (tokenDeviceIdentifier != null) {
            var deviceOpt = deviceService.findByIdentifier(tokenDeviceIdentifier);
            if (deviceOpt.isEmpty() || !deviceOpt.get().isActive()) {
                throw AuthException.invalidToken();
            }
        }

        // 3. Teprve nyní provedeme rotaci tokenů (validace expirace proběhne uvnitř)
        var authResponse = jwtService.refreshTokens(requestDto.getRefreshToken());

        // 4. Aktualizace aktivity zařízení
        deviceService.updateLastLogin(tokenDeviceIdentifier);

        String email = jwtService.extractEmail(authResponse.getAccessToken());
        authLogger.logTokenRefresh(email);

        return authMapper.toTokenResponse(
                authResponse.getAccessToken(),
                authResponse.getRefreshToken(),
                authResponse.getExpiresIn()
        );
    }

    @Override
    public void verifyAccount(String token) {
        var verificationToken = verificationTokenRepository.findByToken(token)
                .orElseThrow(AuthException::invalidVerificationToken);

        if (verificationToken.getExpiryDate().isBefore(LocalDateTime.now(clock))) {
            throw AuthException.verificationTokenExpired();
        }

        var user = verificationToken.getUser();
        if (user.isEnabled()) {
            verificationTokenRepository.delete(verificationToken);
            return;
        }

        user.setEnabled(true);
        userService.save(user);
        verificationTokenRepository.delete(verificationToken);

        authLogger.logAccountActivated(user.getEmail());
    }

    @Override
    public void resendVerificationCode(String email) {
        var user = userService.findByEmail(email);

        if (user.isEnabled()) {
            throw AuthException.accountAlreadyActivated();
        }

        verificationTokenRepository.deleteByUser(user);
        generateAndSendVerificationToken(user);

        authLogger.logResendVerificationCode(user.getEmail());
    }

    @Override
    public void logout(LogoutRequest requestDto, String authenticatedEmail) {
        // Extrahujeme email z refresh tokenu
        String tokenEmail = jwtService.extractEmail(requestDto.getRefreshToken());

        // Bezpečnostní kontrola: pokud je uživatel přihlášen, ověříme shodu
        if (authenticatedEmail != null && !tokenEmail.equals(authenticatedEmail)) {
            throw AuthException.invalidToken();
        }

        var user = userService.findByEmail(tokenEmail);

        if (requestDto.getDeviceIdentifier() != null
                && deviceService.existsByIdentifierAndUser(requestDto.getDeviceIdentifier(), user)) {
            // Soft-logout: deaktivovat zařízení (zachovat v DB), nemazat
            deviceService.deactivateByIdentifierAndUser(requestDto.getDeviceIdentifier(), user);
        }

        authLogger.logLogout(user.getEmail());
    }

    @Override
    @Transactional(readOnly = true)
    public UserResponse getCurrentUser(org.springframework.security.core.userdetails.UserDetails userDetails) {
        var user = userService.findWithRolesByEmail(userDetails.getUsername());
        return authMapper.toUserResponse(user);
    }

    @Override
    public void requestPasswordReset(String email) {
        // Tichý návrat pokud email neexistuje (prevence user enumeration)
        if (!userService.existsByEmail(email)) {
            return;
        }

        var user = userService.findByEmail(email);

        String token = UUID.randomUUID().toString();
        var resetToken = PasswordResetTokenEntity.builder()
                .token(token)
                .user(user)
                .expiryDate(PasswordResetTokenEntity.calculateExpiryDate(60)) // 60 minut
                .build();

        passwordResetTokenRepository.save(resetToken);
        emailService.sendPasswordResetEmail(user.getEmail(), token);
        authLogger.logPasswordResetRequested(user.getEmail());
    }

    @Override
    public void resetPassword(String token, String newPassword) {
        var resetToken = passwordResetTokenRepository.findByToken(token)
                .orElseThrow(AuthException::invalidResetToken);

        if (resetToken.isUsed()) {
            throw AuthException.resetTokenAlreadyUsed();
        }

        if (resetToken.getExpiryDate().isBefore(LocalDateTime.now(clock))) {
            throw AuthException.resetTokenExpired();
        }

        passwordValidator.validate(newPassword);

        var user = resetToken.getUser();
        user.setPassword(passwordEncoder.encode(newPassword));
        userService.save(user);

        resetToken.setUsed(true);
        passwordResetTokenRepository.save(resetToken);

        authLogger.logPasswordResetCompleted(user.getEmail());
    }

    // --- Private Helpers ---

    private void generateAndSendVerificationToken(UserEntity user) {
        String token = UUID.randomUUID().toString();
        var verificationToken = VerificationTokenEntity.builder()
                .token(token)
                .user(user)
                .expiryDate(VerificationTokenEntity.calculateExpiryDate(24 * 60))
                .build();

        verificationTokenRepository.save(verificationToken);
        emailService.sendVerificationEmail(user.getEmail(), token);
        authLogger.logVerificationEmailSent(user.getEmail());
    }

    /**
     * Vytvoří minimalistickou entitu zařízení a nechá DeviceService doplnit metadata.
     */
    private DeviceEntity registerOrUpdateDevice(UserEntity user, LoginRequest dto) {
        if (dto.getDeviceIdentifier() == null) return null;

        // Vytvoříme jen přenosku dat, DeviceService.save() doplní IP, UA a timestampy
        var deviceTemplate = DeviceEntity.builder()
                .user(user)
                .deviceIdentifier(dto.getDeviceIdentifier())
                .deviceName(dto.getDeviceName() != null ? dto.getDeviceName() : "Neznámé zařízení")
                .deviceType(dto.getDeviceType())
                .build();

        return deviceService.save(deviceTemplate);
    }

    private AuthResponse buildAuthResponse(UserEntity user, String deviceIdentifier) {
        String accessToken = jwtService.generateAccessToken(user, deviceIdentifier);
        String refreshToken = jwtService.generateRefreshToken(user, deviceIdentifier);

        var response = authMapper.toAuthResponse(
                user,
                accessToken,
                refreshToken,
                jwtService.getAccessTokenExpirationSeconds()
        );

        boolean isOwner = user.getRoles().stream()
                .anyMatch(r -> "OWNER".equals(r.getName()));
        if (isOwner) {
            var memberships = restaurantEmployeeRepository
                    .findAllByUserId(user.getId()).stream()
                    .filter(m -> m.getRole() == RestaurantEmployeeRole.OWNER)
                    .toList();
            if (memberships.isEmpty()) {
                response.getUser().setNeedsRestaurantClaim(true);
            } else {
                response.getUser().setNeedsRestaurantClaim(false);
                var restaurant = restaurantRepository.findById(memberships.getFirst().getRestaurant().getId());
                if (restaurant.isPresent() && !restaurant.get().isOnboardingCompleted()) {
                    response.getUser().setNeedsOnboarding(true);
                }
            }
        }

        return response;
    }
}