package com.checkfood.checkfoodservice.security.user.repository;

import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Repository pro správu uživatelských účtů.
 * Zajišťuje klíčové operace pro autentizaci a správu profilů s optimalizovaným načítáním.
 */
@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {

    /**
     * Standardní vyhledávání podle emailu.
     */
    Optional<UserEntity> findByEmail(String email);

    /**
     * Najde uživatele a okamžitě načte i jeho role v jednom dotazu.
     * Kritické pro výkon Spring Security při ověřování oprávnění (prevence N+1).
     */
    @EntityGraph(attributePaths = {"roles"})
    Optional<UserEntity> findWithRolesByEmail(String email);

    /**
     * Najde uživatele a načte role i registrovaná zařízení.
     * Ideální pro endpoint /me, kde potřebujeme kompletní profil uživatele.
     */
    @EntityGraph(attributePaths = {"roles", "devices"})
    Optional<UserEntity> findWithAllDetailsByEmail(String email);

    /**
     * Ověří existenci uživatele podle emailu.
     */
    boolean existsByEmail(String email);

}