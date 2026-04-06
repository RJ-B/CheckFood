package com.checkfood.checkfoodservice.security.module.auth.repository;

import com.checkfood.checkfoodservice.security.module.auth.entity.PasswordResetTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Optional;

/**
 * JPA repository pro password reset token persistence a lifecycle management.
 *
 * Poskytuje CRUD operace a specializované queries pro password reset workflow
 * včetně token lookup a bulk expiration cleanup.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see PasswordResetTokenEntity
 */
@Repository
public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetTokenEntity, Long> {

    /**
     * Vyhledá reset token podle jeho string hodnoty.
     *
     * Primární lookup metoda při zpracování reset requestu.
     * Token hodnoty jsou unique napříč systémem.
     *
     * @param token unique token string z reset emailu
     * @return Optional obsahující token entitu pokud existuje
     */
    Optional<PasswordResetTokenEntity> findByToken(String token);

    /**
     * Hromadné smazání expirovaných reset tokenů.
     *
     * Maintenance operace pro scheduled cleanup jobs odstraňující
     * staré tokeny z databáze. Zlepšuje storage efektivitu a query performance.
     *
     * @param now aktuální timestamp pro porovnání expirace
     */
    @Modifying
    @Query("DELETE FROM PasswordResetTokenEntity p WHERE p.expiryDate <= :now")
    void deleteAllExpiredSince(@Param("now") LocalDateTime now);
}
