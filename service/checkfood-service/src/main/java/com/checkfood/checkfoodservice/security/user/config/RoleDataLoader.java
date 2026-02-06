package com.checkfood.checkfoodservice.security.user.config;

import com.checkfood.checkfoodservice.security.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.user.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Component
@RequiredArgsConstructor
public class RoleDataLoader implements CommandLineRunner {

    private final RoleRepository roleRepository;

    @Override
    @Transactional // Zajišťuje atomicitu operací v rámci startu
    public void run(String... args) {
        log.info("Kontrola a inicializace systémových rolí...");

        ensureRoleExists("USER");
        ensureRoleExists("ADMIN");

        log.info("Inicializace rolí dokončena.");
    }

    private void ensureRoleExists(String roleName) {
        roleRepository.findByName(roleName).ifPresentOrElse(
                role -> log.debug("Role {} již existuje, přeskakuji.", roleName),
                () -> {
                    log.info("Role {} nebyla nalezena, vytvářím...", roleName);
                    RoleEntity newRole = new RoleEntity();
                    newRole.setName(roleName);
                    roleRepository.save(newRole);
                }
        );
    }
}