package com.checkfood.checkfoodservice.security.module.mfa.repository;

import com.checkfood.checkfoodservice.security.module.mfa.entity.MfaSecretEntity;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

/**
 * Repository pro správu TOTP tajných klíčů uživatelů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface MfaSecretRepository extends JpaRepository<MfaSecretEntity, Long> {

    /**
     * Vyhledá MFA secret pro daného uživatele.
     *
     * @param userId ID uživatele
     * @return Optional s MFA secret entitou nebo prázdný Optional
     */
    Optional<MfaSecretEntity> findByUserId(Long userId);

    /**
     * Ověří, zda má uživatel uložený MFA secret (aktivní nebo čekající na potvrzení).
     *
     * @param userId ID uživatele
     * @return true pokud secret existuje
     */
    boolean existsByUserId(Long userId);

}
