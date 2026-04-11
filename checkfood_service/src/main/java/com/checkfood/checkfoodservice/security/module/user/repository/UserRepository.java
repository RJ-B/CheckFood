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
     * Najde uživatele a eager načte jeho role + zařízení.
     *
     * <p>Kritické pro Spring Security autentizaci a pro UserMapper.toAuth,
     * který mapuje nejen role ale i {@code devices} (přes
     * {@code calculateGlobalLastLogin}). Pokud by se {@code devices}
     * nenačetly v rámci téže transakce, mapper volá lazy getter mimo
     * Hibernate session a login response spadne na
     * {@link org.hibernate.LazyInitializationException} → HTTP 500.</p>
     *
     * <p>Tento bug se projevoval jen u nově registrovaných uživatelů,
     * protože staří měli devices už načtené v second-level cache. Po
     * čistém restartu instance Cloud Run by spadli i staří.</p>
     */
    @EntityGraph(attributePaths = {"roles", "devices"})
    Optional<UserEntity> findWithRolesByEmail(String email);

    /**
     * Najde uživatele podle ID a eager načte jeho role + zařízení.
     *
     * <p>UserMapper.toAdmin mapuje nejen role ale i {@code devices} (na
     * {@code lastLogin} kolonku) — oba vztahy musí být načteny v rámci
     * stejné transakce, jinak mapper volá lazy getter mimo session a
     * spadne na {@code LazyInitializationException} → HTTP 500.</p>
     *
     * <p>Pojmenování si ponechává historický {@code findWithRolesById}
     * aby se nenarušila signature volajících, ale fakt fetch-joinuje
     * {@code roles} i {@code devices}.</p>
     */
    @EntityGraph(attributePaths = {"roles", "devices"})
    Optional<UserEntity> findWithRolesById(Long id);

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