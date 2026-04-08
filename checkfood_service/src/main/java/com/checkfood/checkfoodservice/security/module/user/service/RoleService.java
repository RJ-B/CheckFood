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
     *
     * @param name název role (např. "ADMIN", "USER")
     * @return nalezená role
     * @throws UserException pokud role není nalezena
     */
    RoleEntity findByName(String name);

    /**
     * Najde roli podle názvu.
     * Zachováno pro zpětnou kompatibilitu — deleguje na {@link #findByName(String)}.
     *
     * @param name název role
     * @return nalezená role
     * @throws UserException pokud role není nalezena
     */
    RoleEntity findByNameWithPermissions(String name);

    /**
     * Vrátí seznam všech rolí v systému.
     *
     * @return seznam všech rolí
     */
    List<RoleEntity> findAll();

    /**
     * Najde všechny role, jejichž názvy jsou v zadané kolekci.
     * Optimalizováno pomocí IN klauzule místo N dotazů.
     *
     * @param names kolekce názvů rolí k vyhledání
     * @return seznam nalezených rolí (prázdný seznam pokud names je null nebo prázdné)
     */
    List<RoleEntity> findAllByNames(Collection<String> names);
}