package com.checkfood.checkfoodservice.security.module.user.repository;

import com.checkfood.checkfoodservice.security.module.user.entity.PermissionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;

/**
 * Repository pro správu systémových oprávnění (fine-grained access control).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see PermissionEntity
 */
@Repository
public interface PermissionRepository extends JpaRepository<PermissionEntity, Long> {

    /**
     * Najde oprávnění podle jeho unikátního názvu.
     * Používá se při přiřazování oprávnění rolím nebo při kontrole existence.
     *
     * @param name název oprávnění (např. "READ_USER", "DELETE_ORDER")
     * @return Optional s oprávněním nebo prázdný Optional
     */
    Optional<PermissionEntity> findByName(String name);

    /**
     * Ověří existenci oprávnění podle názvu.
     * Efektivnější než findByName pro pouhé ověření existence (COUNT dotaz).
     * Vhodné pro validaci v admin rozhraní nebo při inicializaci databáze.
     *
     * @param name název oprávnění k ověření
     * @return true pokud oprávnění existuje, jinak false
     */
    boolean existsByName(String name);

    /**
     * Najde všechna oprávnění, jejichž názvy jsou v zadané kolekci.
     * Velmi užitečné pro hromadné přiřazování oprávnění rolím v admin rozhraní.
     * Optimalizováno pomocí IN klauzule místo N dotazů.
     *
     * @param names množina názvů oprávnění k vyhledání
     * @return seznam nalezených oprávnění
     */
    List<PermissionEntity> findAllByNameIn(Set<String> names);

    /**
     * Najde všechna oprávnění přiřazená konkrétní roli.
     * Pomocný dotaz pro bezpečnostní audit, diagnostiku nebo admin přehledy.
     * Vyhodnocuje vztah přes join table role_permissions.
     *
     * @param roleName název role (např. "ADMIN", "USER")
     * @return seznam oprávnění přiřazených dané roli
     */
    @Query("SELECT p FROM PermissionEntity p JOIN p.roles r WHERE r.name = :roleName")
    List<PermissionEntity> findAllByRoleName(@Param("roleName") String roleName);
}