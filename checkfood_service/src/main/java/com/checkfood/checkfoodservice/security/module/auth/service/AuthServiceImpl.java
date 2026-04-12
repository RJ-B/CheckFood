package com.checkfood.checkfoodservice.security.module.auth.service;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuCategory;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuCategoryRepository;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuItemRepository;
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
import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.audit.service.AuditService;
import com.checkfood.checkfoodservice.security.ratelimit.exception.RateLimitExceededException;
import com.checkfood.checkfoodservice.security.ratelimit.service.RateLimitService;
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
 * Implementace autentizační služby zajišťující registraci, přihlášení, token refresh,
 * odhlášení, email verifikaci a reset hesla.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuthService
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
    private final AuditService auditService;
    private final RateLimitService rateLimitService;
    private final MenuCategoryRepository menuCategoryRepository;
    private final MenuItemRepository menuItemRepository;

    @Override
    public void register(RegisterRequest requestDto) {
        passwordValidator.validate(requestDto.getPassword());

        // Reject duplicate-email registration attempts with HTTP 409.
        //
        // Note on the security trade-off: this enables HTTP-status based
        // account enumeration (an attacker can probe whether an email is
        // registered by checking 409 vs 202). The previous implementation
        // intentionally returned 202 for both cases per OWASP ASVS V3.2.3
        // to defeat enumeration, and notified the legitimate account owner
        // out-of-band that "someone tried to register with your email".
        //
        // Product feedback (April 2026): the silent-success behaviour was
        // confusing — a curious person would try to register, see "check
        // your email", and never get one. Meanwhile the real account holder
        // would receive an unexpected "registration attempt" email and
        // panic. Switched to a clear 409 with two distinct error codes:
        //
        //   - AUTH_EMAIL_EXISTS         → account is verified, redirect to login
        //   - AUTH_ACCOUNT_NOT_VERIFIED → account exists, offer "resend code"
        //
        // The client should NOT show "check your email" on either of those.
        if (userService.existsByEmail(requestDto.getEmail())) {
            var existing = userService.findByEmail(requestDto.getEmail());
            authLogger.logRegistration(requestDto.getEmail());
            if (existing.isEnabled()) {
                throw AuthException.emailExists();
            }
            throw AuthException.emailExistsNotVerified();
        }

        if (requestDto.isOwnerRegistration()) {
            registerAsOwner(requestDto);
        } else {
            registerAsCustomer(requestDto);
        }
    }

    @Override
    public void registerOwner(RegisterRequest requestDto) {
        passwordValidator.validate(requestDto.getPassword());

        // Same duplicate-email rejection as register() — see the longer
        // comment there for the security trade-off rationale.
        if (userService.existsByEmail(requestDto.getEmail())) {
            var existing = userService.findByEmail(requestDto.getEmail());
            authLogger.logRegistration(requestDto.getEmail());
            if (existing.isEnabled()) {
                throw AuthException.emailExists();
            }
            throw AuthException.emailExistsNotVerified();
        }

        registerAsOwner(requestDto);
    }

    /**
     * Registruje běžného zákazníka s rolí USER a odesílá verifikační email.
     *
     * @param requestDto registrační data zákazníka
     */
    private void registerAsCustomer(RegisterRequest requestDto) {
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
     * URL sdíleného testovacího panoramatu přiřazovaného všem trial restauracím.
     */
    private static final String TRIAL_PANORAMA_URL =
            "https://storage.googleapis.com/checkfood-uploads/trial/panoramaTest.jpg";

    /**
     * Výchozí yaw/pitch pozice pro stoly v testovacím panoramatu.
     * Tři stoly rozmístěné po 120° v horizontální rovině.
     */
    private static final double[][] DEFAULT_TABLE_POSITIONS = {
            {-60.0, -10.0},   // Stůl 1 — levá část scény
            {0.0, -5.0},      // Stůl 2 — střed scény
            {60.0, -10.0}     // Stůl 3 — pravá část scény
    };

    /**
     * Registruje majitele restaurace s rolí OWNER a vytváří dvě zkušební restaurace (TRIAL)
     * kompletně vybavené panoramatem, stoly s markery a ukázkovým menu.
     *
     * @param requestDto registrační data majitele
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

        double lat = requestDto.getLatitude() != null ? requestDto.getLatitude() : 49.7474;
        double lng = requestDto.getLongitude() != null ? requestDto.getLongitude() : 13.3776;

        var userRole = roleService.findByName("USER");
        var managerUser = UserEntity.builder()
                .email("manager." + savedUser.getId() + "@trial.checkfood.cz")
                .firstName("Karel")
                .lastName("Manažer")
                .password(passwordEncoder.encode(UUID.randomUUID().toString()))
                .authProvider(AuthProvider.LOCAL)
                .providerId("manager." + savedUser.getId() + "@trial.checkfood.cz")
                .enabled(true)
                .roles(new HashSet<>(Set.of(userRole)))
                .build();
        var savedManager = userService.save(managerUser);

        String[] restaurantNames = {"Restaurace " + savedUser.getLastName(), "Bistro " + savedUser.getLastName()};
        String[] staffFirstNames = {"Tomáš", "Lucie"};
        CuisineType[] cuisines = {CuisineType.CZECH, CuisineType.ITALIAN};

        for (int r = 0; r < 2; r++) {
            // Adresa — pouze GPS souřadnice, textová pole prázdná
            var address = new Address();
            address.setCoordinates(lat + (r * 0.002), lng + (r * 0.003));

            var restaurant = Restaurant.builder()
                    .name(restaurantNames[r])
                    .description("Zkušební restaurace — upravte údaje v nastavení.")
                    .phone("+420 000 000 00" + r)
                    .contactEmail(savedUser.getEmail())
                    .status(RestaurantStatus.ACTIVE)
                    .active(true)
                    .cuisineType(cuisines[r])
                    .defaultReservationDurationMinutes(60)
                    .onboardingCompleted(true)
                    .panoramaUrl(TRIAL_PANORAMA_URL)
                    .address(address)
                    .build();

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

            // Stoly s panorama markery (yaw/pitch)
            for (int t = 0; t < 3; t++) {
                restaurantTableRepository.save(
                    com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable.builder()
                        .restaurantId(savedRestaurant.getId())
                        .label("Stůl " + (t + 1))
                        .capacity(t == 0 ? 2 : t == 1 ? 4 : 6)
                        .active(true)
                        .yaw(DEFAULT_TABLE_POSITIONS[t][0])
                        .pitch(DEFAULT_TABLE_POSITIONS[t][1])
                        .build()
                );
            }

            // Zaměstnanci
            restaurantEmployeeRepository.save(RestaurantEmployee.builder()
                    .user(savedUser)
                    .restaurant(savedRestaurant)
                    .role(RestaurantEmployeeRole.OWNER)
                    .build());

            restaurantEmployeeRepository.save(RestaurantEmployee.builder()
                    .user(savedManager)
                    .restaurant(savedRestaurant)
                    .role(RestaurantEmployeeRole.MANAGER)
                    .build());

            var staffUser = UserEntity.builder()
                    .email("staff" + (r + 1) + "." + savedUser.getId() + "@trial.checkfood.cz")
                    .firstName(staffFirstNames[r])
                    .lastName("Číšník")
                    .password(passwordEncoder.encode(UUID.randomUUID().toString()))
                    .authProvider(AuthProvider.LOCAL)
                    .providerId("staff" + (r + 1) + "." + savedUser.getId() + "@trial.checkfood.cz")
                    .enabled(true)
                    .roles(new HashSet<>(Set.of(userRole)))
                    .build();
            var savedStaff = userService.save(staffUser);

            restaurantEmployeeRepository.save(RestaurantEmployee.builder()
                    .user(savedStaff)
                    .restaurant(savedRestaurant)
                    .role(RestaurantEmployeeRole.STAFF)
                    .build());

            // Ukázkové menu — kategorie + položky
            createTrialMenu(savedRestaurant.getId());
        }

        generateAndSendVerificationToken(savedUser);
        authLogger.logRegistration(savedUser.getEmail());
    }

    /**
     * Vytvoří ukázkové menu s kategoriemi a položkami pro trial restauraci.
     */
    private void createTrialMenu(UUID restaurantId) {
        // Předkrmy
        var starters = menuCategoryRepository.save(MenuCategory.builder()
                .restaurantId(restaurantId).name("Předkrmy").sortOrder(0).build());
        menuItemRepository.save(MenuItem.builder()
                .categoryId(starters.getId()).restaurantId(restaurantId)
                .name("Tatarský biftek").description("200g hovězí tartare, topinky, česnek")
                .priceMinor(28900).sortOrder(0).build());
        menuItemRepository.save(MenuItem.builder()
                .categoryId(starters.getId()).restaurantId(restaurantId)
                .name("Carpaccio z řepy").description("Pečená řepa, kozí sýr, vlašské ořechy")
                .priceMinor(17900).sortOrder(1).build());

        // Hlavní chody
        var mains = menuCategoryRepository.save(MenuCategory.builder()
                .restaurantId(restaurantId).name("Hlavní chody").sortOrder(1).build());
        menuItemRepository.save(MenuItem.builder()
                .categoryId(mains.getId()).restaurantId(restaurantId)
                .name("Svíčková na smetaně").description("Hovězí svíčková, houskový knedlík, brusinky")
                .priceMinor(25900).sortOrder(0).build());
        menuItemRepository.save(MenuItem.builder()
                .categoryId(mains.getId()).restaurantId(restaurantId)
                .name("Kuřecí řízek").description("Kuřecí prsní řízek, bramborový salát")
                .priceMinor(21900).sortOrder(1).build());
        menuItemRepository.save(MenuItem.builder()
                .categoryId(mains.getId()).restaurantId(restaurantId)
                .name("Grilovaný losos").description("Filet z lososa, grilovaná zelenina, bylinková omáčka")
                .priceMinor(32900).sortOrder(2).build());

        // Dezerty
        var desserts = menuCategoryRepository.save(MenuCategory.builder()
                .restaurantId(restaurantId).name("Dezerty").sortOrder(2).build());
        menuItemRepository.save(MenuItem.builder()
                .categoryId(desserts.getId()).restaurantId(restaurantId)
                .name("Palačinky s Nutellou").description("Domácí palačinky, Nutella, šlehačka, jahody")
                .priceMinor(12900).sortOrder(0).build());
        menuItemRepository.save(MenuItem.builder()
                .categoryId(desserts.getId()).restaurantId(restaurantId)
                .name("Tiramisu").description("Klasické italské tiramisu s mascarpone")
                .priceMinor(14900).sortOrder(1).build());

        // Nápoje
        var drinks = menuCategoryRepository.save(MenuCategory.builder()
                .restaurantId(restaurantId).name("Nápoje").sortOrder(3).build());
        menuItemRepository.save(MenuItem.builder()
                .categoryId(drinks.getId()).restaurantId(restaurantId)
                .name("Pilsner Urquell 0,5l").description("Čepované pivo")
                .priceMinor(5900).sortOrder(0).build());
        menuItemRepository.save(MenuItem.builder()
                .categoryId(drinks.getId()).restaurantId(restaurantId)
                .name("Domácí limonáda").description("Citron, máta, třtinový cukr")
                .priceMinor(7900).sortOrder(1).build());
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
        String deviceIdentifier = device != null ? device.getDeviceIdentifier() : null;

        authLogger.logSuccessfulLogin(user.getEmail());
        auditService.log(user.getId(), AuditAction.LOGIN, AuditStatus.SUCCESS, null, null);
        return buildAuthResponse(user, deviceIdentifier);
    }

    @Override
    public TokenResponse refreshToken(RefreshRequest requestDto) {
        String tokenDeviceIdentifier = jwtService.extractDeviceIdentifier(requestDto.getRefreshToken());

        if (tokenDeviceIdentifier != null && !tokenDeviceIdentifier.equals(requestDto.getDeviceIdentifier())) {
            throw AuthException.deviceMismatch();
        }

        if (tokenDeviceIdentifier != null) {
            var deviceOpt = deviceService.findByIdentifier(tokenDeviceIdentifier);
            if (deviceOpt.isEmpty() || !deviceOpt.get().isActive()) {
                throw AuthException.invalidToken();
            }
        }

        var authResponse = jwtService.refreshTokens(requestDto.getRefreshToken());
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
        String tokenEmail = jwtService.extractEmail(requestDto.getRefreshToken());

        if (authenticatedEmail != null && !tokenEmail.equals(authenticatedEmail)) {
            throw AuthException.invalidToken();
        }

        var user = userService.findByEmail(tokenEmail);

        if (requestDto.getDeviceIdentifier() != null
                && deviceService.existsByIdentifierAndUser(requestDto.getDeviceIdentifier(), user)) {
            deviceService.deactivateByIdentifierAndUser(requestDto.getDeviceIdentifier(), user);
            // Revoke any live refresh-token rows for this user+device pair so
            // a subsequent /refresh call cannot revive the session.
            jwtService.revokeRefreshTokensForDevice(
                    user.getId(),
                    requestDto.getDeviceIdentifier(),
                    "LOGOUT"
            );
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
        // Per-email rate limit: 3 reset requests per 15 min per lowered
        // e-mail. The controller already has a per-IP limit, but a single
        // attacker IP could still hammer a specific victim's e-mail. This
        // second bucket closes that hole.
        String normalizedEmail = email == null ? "" : email.trim().toLowerCase();
        boolean allowed = rateLimitService.tryAcquire(
                "auth:forgot-password:email=" + normalizedEmail,
                3,
                java.util.concurrent.TimeUnit.MINUTES.toMillis(15)
        );
        if (!allowed) {
            throw new RateLimitExceededException("Too many password reset requests for this email");
        }

        if (!userService.existsByEmail(email)) {
            return;
        }

        var user = userService.findByEmail(email);

        String token = UUID.randomUUID().toString();
        var resetToken = PasswordResetTokenEntity.builder()
                .token(token)
                .user(user)
                .expiryDate(PasswordResetTokenEntity.calculateExpiryDate(60))
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

        // Per-user rate limit: 5 reset-password attempts per 15 min per
        // target user (keyed on user id derived from the token). Prevents
        // an attacker who grabbed a reset link from trying many weak
        // passwords in quick succession.
        boolean allowed = rateLimitService.tryAcquire(
                "auth:reset-password:user=" + resetToken.getUser().getId(),
                5,
                java.util.concurrent.TimeUnit.MINUTES.toMillis(15)
        );
        if (!allowed) {
            throw new RateLimitExceededException("Too many password reset attempts for this account");
        }

        passwordValidator.validate(newPassword);

        var user = resetToken.getUser();
        user.setPassword(passwordEncoder.encode(newPassword));
        userService.save(user);

        resetToken.setUsed(true);
        passwordResetTokenRepository.save(resetToken);

        authLogger.logPasswordResetCompleted(user.getEmail());
    }

    /**
     * Vygeneruje UUID verifikační token, uloží jej a odešle verifikační email.
     *
     * @param user uživatel, jemuž se odesílá verifikační email
     */
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
     * Zaregistruje nebo aktualizuje záznam zařízení přes DeviceService.
     *
     * @param user uživatel přihlašující se ze zařízení
     * @param dto  login request obsahující identifikátor a metadata zařízení
     * @return uložená entita zařízení nebo {@code null} pokud deviceIdentifier chybí
     */
    private DeviceEntity registerOrUpdateDevice(UserEntity user, LoginRequest dto) {
        if (dto.getDeviceIdentifier() == null) return null;

        var deviceTemplate = DeviceEntity.builder()
                .user(user)
                .deviceIdentifier(dto.getDeviceIdentifier())
                .deviceName(dto.getDeviceName() != null ? dto.getDeviceName() : "Neznámé zařízení")
                .deviceType(dto.getDeviceType())
                .build();

        return deviceService.save(deviceTemplate);
    }

    /**
     * Sestaví AuthResponse s JWT tokeny a nastaví příznaky onboardingu pro roli OWNER.
     *
     * @param user             autentizovaný uživatel
     * @param deviceIdentifier identifikátor zařízení pro vazbu tokenu
     * @return kompletní autentizační odpověď
     */
    private AuthResponse buildAuthResponse(UserEntity user, String deviceIdentifier) {
        String accessToken = jwtService.generateAccessToken(user, deviceIdentifier);
        // Use issueFirstRefreshToken (not generateRefreshToken) so the row is
        // persisted in the rotation table — without it the first refresh
        // attempt would fail with "Unknown refresh token".
        String refreshToken = jwtService.issueFirstRefreshToken(user, deviceIdentifier);

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