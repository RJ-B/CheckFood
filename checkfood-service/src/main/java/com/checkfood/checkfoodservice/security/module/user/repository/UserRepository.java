package com.checkfood.checkfoodservice.security.module.user.repository;

import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Repository pro správu uživatelských účtů v systému.
 * Poskytuje optimalizované dotazy s EntityGraph pro efektivní načítání vztahů (roles, devices).
 * Prevence N+1 problému při práci s lazy loaded associations.
 *
 * @see UserEntity
 */
@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {

    /**
     * Najde uživatele podle emailové adresy.
     * Načítá pouze základní data bez vztahů (lazy loading).
     *
     * @param email emailová adresa uživatele
     * @return Optional s uživatelem nebo prázdný Optional
     */
    Optional<UserEntity> findByEmail(String email);

    /**
     * Najde uživatele a eager načte jeho role v jednom SQL dotazu.
     * Kritické pro Spring Security autentizaci a autorizaci (prevence N+1 problému).
     * Používá se v JwtAuthenticationFilter a při kontrole oprávnění.
     *
     * @param email emailová adresa uživatele
     * @return Optional s uživatelem včetně rolí nebo prázdný Optional
     */
    @EntityGraph(attributePaths = {"roles"})
    Optional<UserEntity> findWithRolesByEmail(String email);

    /**
     * Najde uživatele a eager načte role i registrovaná zařízení.
     * Optimalizace pro endpointy vyžadující kompletní uživatelský profil (např. /api/auth/me).
     * Vhodné pro zobrazení přehledu aktivních relací uživatele.
     *
     * @param email emailová adresa uživatele
     * @return Optional s uživatelem včetně rolí a zařízení nebo prázdný Optional
     */
    @EntityGraph(attributePaths = {"roles", "devices"})
    Optional<UserEntity> findWithAllDetailsByEmail(String email);

    /**
     * Ověří existenci uživatele s danou emailovou adresou.
     * Efektivnější než findByEmail pro pouhé ověření existence (COUNT dotaz místo SELECT *).
     *
     * @param email emailová adresa k ověření
     * @return true pokud uživatel s emailem existuje, jinak false
     */
    boolean existsByEmail(String email);
}