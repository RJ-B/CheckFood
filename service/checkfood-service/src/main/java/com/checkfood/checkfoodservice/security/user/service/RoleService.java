package com.checkfood.checkfoodservice.security.user.service;

import com.checkfood.checkfoodservice.security.user.entity.RoleEntity;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

/**
 * Rozhraní pro správu uživatelských rolí v rámci RBAC systému.
 */
public interface RoleService {

    /**
     * Uloží nebo aktualizuje roli v databázi.
     */
    RoleEntity save(RoleEntity role);

    /**
     * Najde roli podle jejího unikátního identifikátoru.
     */
    Optional<RoleEntity> findById(Long id);

    /**
     * Najde roli podle názvu (např. "ADMIN").
     * Vyhazuje RoleNotFoundException, pokud role neexistuje.
     */
    RoleEntity findByName(String name);

    /**
     * Najde roli včetně všech jejích oprávnění pomocí optimalizovaného dotazu.
     */
    RoleEntity findByNameWithPermissions(String name);

    /**
     * Vrátí seznam všech dostupných rolí v systému.
     */
    List<RoleEntity> findAll();

    /**
     * Hromadné vyhledání rolí podle sady názvů.
     * Nezbytné pro efektivní přiřazování více rolí uživateli najednou.
     */
    List<RoleEntity> findAllByNames(Collection<String> names);
}