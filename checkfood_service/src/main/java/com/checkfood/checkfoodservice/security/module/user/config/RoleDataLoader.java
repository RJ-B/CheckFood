package com.checkfood.checkfoodservice.security.module.user.config;

import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.logging.UserLogger;
import com.checkfood.checkfoodservice.security.module.user.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * Data loader pro inicializaci systémových rolí při startu aplikace.
 * Zajišťuje, že základní role (USER, ADMIN) existují v databázi před prvním použitím.
 * Spouští se automaticky po startu aplikace díky implementaci CommandLineRunner.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see RoleEntity
 * @see RoleRepository
 */
@Component
@RequiredArgsConstructor
@Order(1)
public class RoleDataLoader implements CommandLineRunner {

    private final RoleRepository roleRepository;
    private final UserLogger userLogger;

    /**
     * Inicializuje systémové role při startu aplikace.
     * Kontroluje existenci základních rolí a vytváří je, pokud neexistují.
     * Operace probíhá v transakci pro zajištění atomicity.
     *
     * @param args argumenty příkazové řádky (nepoužívá se)
     */
    @Override
    @Transactional
    public void run(String... args) {
        userLogger.logUserCreated("Kontrola a inicializace systémových rolí");

        ensureRoleExists("USER");
        ensureRoleExists("ADMIN");
        ensureRoleExists("OWNER");
        ensureRoleExists("MANAGER");
        ensureRoleExists("STAFF");

        userLogger.logUserCreated("Inicializace rolí dokončena");
    }

    /**
     * Zajistí existenci role v databázi.
     * Pokud role neexistuje, vytvoří ji. Pokud existuje, pouze loguje debug zprávu.
     *
     * @param roleName název role k ověření/vytvoření
     */
    private void ensureRoleExists(String roleName) {
        roleRepository.findByName(roleName).ifPresentOrElse(
                role -> userLogger.debug("Role {} již existuje, přeskakuji", roleName),
                () -> {
                    userLogger.logUserCreated("Role " + roleName + " nebyla nalezena, vytvářím");
                    RoleEntity newRole = new RoleEntity();
                    newRole.setName(roleName);
                    roleRepository.save(newRole);
                }
        );
    }
}