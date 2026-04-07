package com.checkfood.checkfoodservice.security.module.user.service;

import com.checkfood.checkfoodservice.security.module.user.exception.UserException;
import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

/**
 * Rozhraní servisní vrstvy pro správu uživatelských rolí v rámci RBAC systému.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface RoleService {

    /**
     * Uloží nebo aktualizuje roli v systému.
     *
     * @param role role k uložení
     * @return uložená role s vygenerovaným ID
     */
    RoleEntity save(RoleEntity role);

    /**
     * Najde roli podle ID.
     *
     * @param id ID role
     * @return Optional s rolí nebo prázdný Optional
     */
    Optional<RoleEntity> findById(Long id);

    /**
     * Najde roli podle názvu.
     * Načítá pouze základní data bez permissions (lazy loading).
     *
     * @param name název role (např. "ADMIN", "USER")
     * @return nalezená role
     * @throws UserException pokud role není nalezena
     */
    RoleEntity findByName(String name);

    /**
     * Najde roli včetně jejích oprávnění v jednom dotazu.
     * Používá EntityGraph pro prevenci N+1 problému při načítání permissions.
     * Vhodné pro detailní zobrazení role s její kompletní konfigurací.
     *
     * @param name název role
     * @return nalezená role včetně permissions
     * @throws UserException pokud role není nalezena
     */
    RoleEntity findByNameWithPermissions(String name);

    /**
     * Vrátí seznam všech rolí v systému.
     * Eager načte permissions pro všechny role.
     *
     * @return seznam všech rolí včetně jejich permissions
     */
    List<RoleEntity> findAll();

    /**
     * Najde všechny role, jejichž názvy jsou v zadané kolekci.
     * Používá se při hromadném přiřazování rolí uživatelům v admin rozhraní.
     * Optimalizováno pomocí IN klauzule místo N dotazů.
     *
     * @param names kolekce názvů rolí k vyhledání
     * @return seznam nalezených rolí (prázdný seznam pokud names je null nebo prázdné)
     */
    List<RoleEntity> findAllByNames(Collection<String> names);
}