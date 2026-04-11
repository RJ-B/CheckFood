package com.checkfood.checkfoodservice.security.module.jwt.repository;

import com.checkfood.checkfoodservice.security.module.jwt.entity.RefreshTokenEntity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

/**
 * Repository for the refresh-token rotation table. Every write is guarded
 * by a transactional boundary in {@code JwtServiceImpl.refreshTokens}.
 *
 * @author CheckFood team, Apr 2026
 */
@Repository
public interface RefreshTokenRepository extends JpaRepository<RefreshTokenEntity, Long> {

    /**
     * Look up a previously-issued refresh token by its SHA-256 hex hash.
     * Used on the rotation exchange to decide whether the presented token
     * is valid / used / revoked.
     */
    Optional<RefreshTokenEntity> findByTokenHash(String tokenHash);

    /**
     * Revoke every token in a family in a single UPDATE. Used on reuse
     * detection — once a stolen token is replayed, all siblings and
     * descendants must die so the attacker loses access simultaneously
     * with the legitimate user.
     */
    @Modifying
    @Query("""
            UPDATE RefreshTokenEntity rt
               SET rt.revokedAt = :now,
                   rt.revocationReason = :reason
             WHERE rt.familyId = :familyId
               AND rt.revokedAt IS NULL
            """)
    int revokeFamily(
            @Param("familyId") UUID familyId,
            @Param("reason") String reason,
            @Param("now") Instant now
    );

    /**
     * Revoke all unrevoked tokens for a user/device pair. Used by logout
     * so the session on that device cannot be refreshed further.
     */
    @Modifying
    @Query("""
            UPDATE RefreshTokenEntity rt
               SET rt.revokedAt = :now,
                   rt.revocationReason = :reason
             WHERE rt.user.id = :userId
               AND rt.deviceIdentifier = :deviceIdentifier
               AND rt.revokedAt IS NULL
               AND rt.usedAt IS NULL
            """)
    int revokeByUserAndDevice(
            @Param("userId") Long userId,
            @Param("deviceIdentifier") String deviceIdentifier,
            @Param("reason") String reason,
            @Param("now") Instant now
    );

    /**
     * Housekeeping: delete rows that have been expired for more than the
     * retention window. Called by a daily scheduled job so the table
     * doesn't grow unbounded.
     */
    @Modifying
    @Query("DELETE FROM RefreshTokenEntity rt WHERE rt.expiresAt < :threshold")
    int deleteAllExpiredBefore(@Param("threshold") Instant threshold);
}
