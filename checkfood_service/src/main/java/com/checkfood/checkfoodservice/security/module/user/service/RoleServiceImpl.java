package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;
import com.checkfood.checkfoodservice.security.module.user.logging.UserLogger;
import com.checkfood.checkfoodservice.security.module.user.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

/**
 * Implementace role servisu pro správu uživatelských rolí.
 * Zajišťuje CRUD operace a vyhledávání rolí v rámci RBAC (Role-Based Access Control) systému.
 * Podporuje eager loading permissions pomocí EntityGraph pro optimalizaci výkonu.
 *
 * @see RoleService
 * @see RoleRepository
 * @see UserLogger
 */
@Service
@RequiredArgsConstructor
@Transactional
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;
    private final UserLogger userLogger;

    /**
     * Uloží nebo aktualizuje roli v systému.
     *
     * @param role role k uložení
     * @return uložená role s vygenerovaným ID
     */
    @Override
    public RoleEntity save(RoleEntity role) {
        userLogger.logUserCreated("Role: " + role.getName());
        return roleRepository.save(role);
    }

    /**
     * Najde roli podle ID.
     *
     * @param id ID role
     * @return Optional s rolí nebo prázdný Optional
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<RoleEntity> findById(Long id) {
        return roleRepository.findById(id);
    }

    /**
     * Najde roli podle názvu.
     * Načítá pouze základní data bez permissions (lazy loading).
     *
     * @param name název role (např. "ADMIN", "USER")
     * @return nalezená role
     * @throws UserException pokud role není nalezena
     */
    @Override
    @Transactional(readOnly = true)
    public RoleEntity findByName(String name) {
        return roleRepository.findByName(name)
                .orElseThrow(() -> {
                    userLogger.logUserNotFound("Role: " + name);
                    return UserException.roleNotFound(name);
                });
    }

    /**
     * Najde roli včetně jejích oprávnění v jednom dotazu.
     * Používá EntityGraph pro prevenci N+1 problému při načítání permissions.
     * Vhodné pro detailní zobrazení role s její kompletní konfigurací.
     *
     * @param name název role
     * @return nalezená role včetně permissions
     * @throws UserException pokud role není nalezena
     */
    @Override
    @Transactional(readOnly = true)
    public RoleEntity findByNameWithPermissions(String name) {
        return roleRepository.findWithPermissionsByName(name)
                .orElseThrow(() -> {
                    userLogger.logUserNotFound("Role: " + name);
                    return UserException.roleNotFound(name);
                });
    }

    /**
     * Vrátí seznam všech rolí v systému.
     * Eager načte permissions pro všechny role.
     *
     * @return seznam všech rolí včetně jejich permissions
     */
    @Override
    @Transactional(readOnly = true)
    public List<RoleEntity> findAll() {
        return roleRepository.findAll();
    }

    /**
     * Najde všechny role, jejichž názvy jsou v zadané kolekci.
     * Používá se při hromadném přiřazování rolí uživatelům.
     * Optimalizováno pomocí IN klauzule místo N dotazů.
     *
     * @param names kolekce názvů rolí k vyhledání
     * @return seznam nalezených rolí (prázdný seznam pokud names je null nebo prázdné)
     */
    @Override
    @Transactional(readOnly = true)
    public List<RoleEntity> findAllByNames(Collection<String> names) {
        if (names == null || names.isEmpty()) {
            return List.of();
        }
        return roleRepository.findAllByNameIn(names);
    }
}