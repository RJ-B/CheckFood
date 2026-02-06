package com.checkfood.checkfoodservice.security.user.repository;

import com.checkfood.checkfoodservice.security.user.entity.RoleEntity;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

/**
 * Repository pro správu uživatelských rolí.
 * Zajišťuje perzistenci a vyhledávání rolí pro potřeby RBAC (Role-Based Access Control).
 */
@Repository
public interface RoleRepository extends JpaRepository<RoleEntity, Long> {

    /**
     * Najde roli podle jejího unikátního názvu (např. "ADMIN").
     */
    Optional<RoleEntity> findByName(String name);

    /**
     * Ověří existenci role podle názvu.
     * Užitečné při registraci nebo přiřazování rolí v admin rozhraní.
     */
    boolean existsByName(String name);

    /**
     * Najde všechny role, jejichž názvy jsou v zadané kolekci.
     * Používá se při hromadném přiřazování rolí uživateli.
     */
    List<RoleEntity> findAllByNameIn(Collection<String> names);

    /**
     * Najde roli včetně jejích oprávnění v rámci jednoho dotazu.
     * Použití EntityGraph zabraňuje N+1 SELECT problému při načítání oprávnění.
     */
    @EntityGraph(attributePaths = {"permissions"})
    Optional<RoleEntity> findWithPermissionsByName(String name);

    /**
     * Najde všechny role včetně jejich oprávnění.
     * Vhodné pro inicializaci security kontextu nebo exporty.
     */
    @EntityGraph(attributePaths = {"permissions"})
    List<RoleEntity> findAll();
}