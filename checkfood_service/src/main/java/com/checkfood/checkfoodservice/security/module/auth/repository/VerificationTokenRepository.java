package com.checkfood.checkfoodservice.security.module.auth.repository;

import com.checkfood.checkfoodservice.security.module.auth.entity.VerificationTokenEntity;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Optional;

/**
 * JPA repository pro správu verifikačních tokenů v databázi.
 * Poskytuje operace pro vyhledávání, mazání a údržbu tokenů používaných při aktivaci účtů.
 *
 * @see VerificationTokenEntity
 */
@Repository
public interface VerificationTokenRepository extends JpaRepository<VerificationTokenEntity, Long> {

    /**
     * Vyhledá verifikační token podle jeho hodnoty.
     * Používá se při validaci tokenu z emailového odkazu.
     *
     * @param token hodnota tokenu
     * @return Optional obsahující token pokud existuje
     */
    Optional<VerificationTokenEntity> findByToken(String token);

    /**
     * Vyhledá verifikační token přiřazený konkrétnímu uživateli.
     * Používá se pro kontrolu existence před generováním nového tokenu.
     *
     * @param user entita uživatele
     * @return Optional obsahující token pokud existuje
     */
    Optional<VerificationTokenEntity> findByUser(UserEntity user);

    /**
     * Odstraní všechny verifikační tokeny přiřazené danému uživateli.
     * Používá se při rotaci tokenů - nový token zneplatní všechny předchozí.
     *
     * @param user entita uživatele
     */
    @Modifying
    @Query("DELETE FROM VerificationTokenEntity v WHERE v.user = :user")
    void deleteByUser(@Param("user") UserEntity user);

    /**
     * Hromadně odstraní všechny tokeny, které již vypršely.
     * Určeno pro pravidelný úklid databáze prostřednictvím naplánovaných úloh.
     *
     * @param now aktuální timestamp pro porovnání s expiryDate
     */
    @Modifying
    @Query("DELETE FROM VerificationTokenEntity v WHERE v.expiryDate <= :now")
    void deleteAllExpiredSince(@Param("now") LocalDateTime now);
}