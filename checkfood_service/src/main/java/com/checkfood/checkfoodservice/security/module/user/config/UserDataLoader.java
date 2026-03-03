package com.checkfood.checkfoodservice.security.module.user.config;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.logging.UserLogger;
import com.checkfood.checkfoodservice.security.module.user.repository.RoleRepository;
import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

/**
 * Data loader pro inicializaci testovacích uživatelů při startu aplikace.
 * Vytváří uživatele s rolemi ADMIN, OWNER a MANAGER pro vývojové/testovací účely.
 * Spouští se po {@link RoleDataLoader} díky {@code @Order(2)}.
 */
@Component
@RequiredArgsConstructor
@Order(2)
public class UserDataLoader implements CommandLineRunner {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final UserLogger userLogger;

    private static final String DEFAULT_PASSWORD = "Test1234!";

    @Override
    @Transactional
    public void run(String... args) {
        userLogger.logUserCreated("Kontrola a inicializace testovacích uživatelů");

        ensureUserExists("admin@checkfood.cz", "Admin", "CheckFood", Set.of("USER", "ADMIN"));
        ensureUserExists("owner@checkfood.cz", "Owner", "CheckFood", Set.of("USER", "OWNER"));
        ensureUserExists("manager@checkfood.cz", "Manager", "CheckFood", Set.of("USER", "MANAGER"));

        userLogger.logUserCreated("Inicializace testovacích uživatelů dokončena");
    }

    private void ensureUserExists(String email, String firstName, String lastName, Set<String> roleNames) {
        if (userRepository.existsByEmail(email)) {
            userLogger.debug("Uživatel {} již existuje, přeskakuji", email);
            return;
        }

        Set<RoleEntity> roles = new HashSet<>();
        for (String roleName : roleNames) {
            roleRepository.findByName(roleName).ifPresent(roles::add);
        }

        UserEntity user = UserEntity.builder()
                .email(email)
                .firstName(firstName)
                .lastName(lastName)
                .password(passwordEncoder.encode(DEFAULT_PASSWORD))
                .authProvider(AuthProvider.LOCAL)
                .providerId(email)
                .enabled(true)
                .roles(roles)
                .build();

        userRepository.save(user);
        userLogger.logUserCreated("Vytvořen uživatel " + email + " s rolemi " + roleNames);
    }
}
