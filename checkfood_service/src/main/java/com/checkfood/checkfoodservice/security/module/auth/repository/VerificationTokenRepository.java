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
 * JPA repository pro verification token persistence a lifecycle management.
 *
 * Provides CRUD operations a specialized queries pro email verification
 * token workflow including token rotation, expiration cleanup a user
 * association management.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see VerificationTokenEntity
 * @see UserEntity
 */
@Repository
public interface VerificationTokenRepository extends JpaRepository<VerificationTokenEntity, Long> {

    /**
     * Finds verification token by its string value.
     *
     * Primary lookup method pro email verification workflow when processing
     * verification links. Token values jsou unique across system.
     *
     * @param token unique token string from verification email
     * @return Optional containing token entity pokud exists
     */
    Optional<VerificationTokenEntity> findByToken(String token);

    /**
     * Finds verification token associated s specific user.
     *
     * Used pro checking existing token před generating new one during
     * token rotation nebo resend operations. Supports one-token-per-user policy.
     *
     * @param user UserEntity pro token lookup
     * @return Optional containing user's current token pokud exists
     */
    Optional<VerificationTokenEntity> findByUser(UserEntity user);

    /**
     * Removes all verification tokens associated s specific user.
     *
     * Token rotation operation ensuring pouze jeden token per user
     * is active at any time. Called před generating new verification token.
     *
     * @param user UserEntity whose tokens should be removed
     */
    @Modifying
    @Query("DELETE FROM VerificationTokenEntity v WHERE v.user = :user")
    void deleteByUser(@Param("user") UserEntity user);

    /**
     * Bulk removal of expired verification tokens.
     *
     * Maintenance operation designed pro scheduled cleanup jobs removing
     * stale tokens z database. Improves storage efficiency a query performance.
     *
     * @param now current timestamp pro expiration comparison
     */
    @Modifying
    @Query("DELETE FROM VerificationTokenEntity v WHERE v.expiryDate <= :now")
    void deleteAllExpiredSince(@Param("now") LocalDateTime now);
}