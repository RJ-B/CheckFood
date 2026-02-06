package com.checkfood.checkfoodservice.security.user.repository;

import com.checkfood.checkfoodservice.security.user.entity.PermissionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;

/**
 * Repository pro správu systémových oprávnění (Privileges).
 * Zajišťuje perzistentní vrstvu pro jemnou kontrolu přístupu (Fine-grained access control).
 */
@Repository
public interface PermissionRepository extends JpaRepository<PermissionEntity, Long> {

    /**
     * Najde oprávnění podle jeho unikátního názvu (např. "READ_USER").
     */
    Optional<PermissionEntity> findByName(String name);

    /**
     * Ověří existenci oprávnění podle názvu.
     * Vhodné pro validátory nebo při inicializaci databáze.
     */
    boolean existsByName(String name);

    /**
     * Najde všechna oprávnění, jejichž názvy jsou v zadané kolekci.
     * Velmi užitečné pro hromadné přiřazování oprávnění rolím.
     */
    List<PermissionEntity> findAllByNameIn(Set<String> names);

    /**
     * Najde všechna oprávnění přiřazená konkrétní roli podle jejího názvu.
     * Pomocný dotaz pro diagnostiku nebo bezpečnostní audit.
     */
    @Query("SELECT p FROM PermissionEntity p JOIN p.roles r WHERE r.name = :roleName")
    List<PermissionEntity> findAllByRoleName(@Param("roleName") String roleName);
}