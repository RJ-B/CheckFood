package com.checkfood.checkfoodservice.security.auth.repository;

import com.checkfood.checkfoodservice.security.auth.entity.VerificationTokenEntity;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Optional;

@Repository
public interface VerificationTokenRepository extends JpaRepository<VerificationTokenEntity, Long> {

    /**
     * Vyhledání tokenu pro validaci při kliknutí uživatele na odkaz v e-mailu.
     */
    Optional<VerificationTokenEntity> findByToken(String token);

    /**
     * Vyhledání tokenu podle entity uživatele.
     * Užitečné pro kontrolu existence před generováním nového požadavku.
     */
    Optional<VerificationTokenEntity> findByUser(UserEntity user);

    /**
     * Odstraní všechny tokeny přidružené k danému uživateli.
     * Používá se při rotaci tokenů (vytvoření nového zneplatní všechny staré).
     */
    @Modifying
    @Query("DELETE FROM VerificationTokenEntity v WHERE v.user = :user")
    void deleteByUser(@Param("user") UserEntity user);

    /**
     * Metoda pro hromadné promazání expirovaných tokenů.
     * Vhodné pro využití v rámci naplánovaných úloh (Scheduled Tasks).
     */
    @Modifying
    @Query("DELETE FROM VerificationTokenEntity v WHERE v.expiryDate <= :now")
    void deleteAllExpiredSince(@Param("now") LocalDateTime now);
}