package com.checkfood.checkfoodservice.security.mfa.repository;

import com.checkfood.checkfoodservice.security.mfa.entity.MfaBackupCodeEntity;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

/**
 * Repository pro MFA záložní kódy.
 */
public interface MfaBackupCodeRepository
        extends JpaRepository<MfaBackupCodeEntity, Long> {

    List<MfaBackupCodeEntity> findByUserIdAndUsedFalse(Long userId);

    Optional<MfaBackupCodeEntity> findByUserIdAndCodeHashAndUsedFalse(
            Long userId,
            String codeHash
    );

    void deleteByUserId(Long userId);

}
