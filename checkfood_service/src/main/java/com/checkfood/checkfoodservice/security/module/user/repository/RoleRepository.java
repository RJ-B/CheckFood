package com.checkfood.checkfoodservice.security.module.user.repository;

import com.checkfood.checkfoodservice.security.module.user.entity.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

/**
 * Repository pro správu uživatelských rolí.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see RoleEntity
 */
@Repository
public interface RoleRepository extends JpaRepository<RoleEntity, Long> {

    /**
     * Najde roli podle jejího unikátního názvu.
     * Používá se při přiřazování výchozích rolí (např. "USER" při registraci).
     *
     * @param name název role (např. "ADMIN", "USER", "OWNER", "STAFF", "MANAGER")
     * @return Optional s rolí nebo prázdný Optional
     */
    Optional<RoleEntity> findByName(String name);

    /**
     * Ověří existenci role podle názvu.
     * Efektivnější než findByName pro pouhé ověření existence (COUNT dotaz).
     * Užitečné při validaci v admin rozhraní před vytvořením nové role.
     *
     * @param name název role k ověření
     * @return true pokud role existuje, jinak false
     */
    boolean existsByName(String name);

    /**
     * Najde všechny role, jejichž názvy jsou v zadané kolekci.
     * Používá se při hromadném přiřazování rolí uživateli v admin rozhraní.
     * Optimalizováno pomocí IN klauzule místo N dotazů.
     *
     * @param names kolekce názvů rolí k vyhledání
     * @return seznam nalezených rolí
     */
    List<RoleEntity> findAllByNameIn(Collection<String> names);

    /**
     * Najde roli podle názvu.
     * Alias pro {@link #findByName(String)} — zachován pro zpětnou kompatibilitu.
     *
     * @param name název role
     * @return Optional s rolí nebo prázdný Optional
     */
    Optional<RoleEntity> findWithPermissionsByName(String name);

    /**
     * Najde všechny role v systému.
     *
     * @return seznam všech rolí
     */
    List<RoleEntity> findAll();
}