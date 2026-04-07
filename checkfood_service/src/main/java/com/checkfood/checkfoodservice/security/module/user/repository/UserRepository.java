package com.checkfood.checkfoodservice.security.module.user.repository;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Repository pro správu uživatelských účtů s optimalizovanými dotazy pro prevenci N+1 problému.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {

    /**
     * Najde uživatele podle emailové adresy.
     */
    Optional<UserEntity> findByEmail(String email);

    /**
     * Najde uživatele a eager načte jeho role.
     * Kritické pro Spring Security autentizaci.
     */
    @EntityGraph(attributePaths = {"roles"})
    Optional<UserEntity> findWithRolesByEmail(String email);

    /**
     * Najde uživatele a eager načte role i registrovaná zařízení.
     */
    @EntityGraph(attributePaths = {"roles", "devices"})
    Optional<UserEntity> findWithAllDetailsByEmail(String email);

    /**
     * Vyhledá uživatele podle externí identity (provider + ID uživatele).
     * Tato metoda je klíčová pro proces OAuth přihlášení.
     *
     * @param authProvider Provider identity (např. GOOGLE, APPLE)
     * @param providerId Unikátní identifikátor z externího systému
     * @return Optional s uživatelem
     */
    Optional<UserEntity> findByAuthProviderAndProviderId(AuthProvider authProvider, String providerId);

    /**
     * Vyhledá uživatele podle externí identity a okamžitě načte jeho role.
     * Optimalizace pro OAuth proces: po nalezení/vytvoření uživatele následuje generování JWT.
     *
     * @param authProvider Provider identity
     * @param providerId Unikátní identifikátor z externího systému
     * @return Optional s uživatelem včetně rolí
     */
    @EntityGraph(attributePaths = {"roles"})
    Optional<UserEntity> findWithRolesByAuthProviderAndProviderId(AuthProvider authProvider, String providerId);

    /**
     * Ověří existenci uživatele s danou emailovou adresou.
     */
    boolean existsByEmail(String email);
}