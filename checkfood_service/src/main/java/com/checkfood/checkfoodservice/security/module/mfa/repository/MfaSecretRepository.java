package com.checkfood.checkfoodservice.security.module.mfa.repository;

import com.checkfood.checkfoodservice.security.module.mfa.entity.MfaSecretEntity;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

/**
 * Repository pro MFA secret.
 */
public interface MfaSecretRepository extends JpaRepository<MfaSecretEntity, Long> {

    Optional<MfaSecretEntity> findByUserId(Long userId);

    boolean existsByUserId(Long userId);

}
