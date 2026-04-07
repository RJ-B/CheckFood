package com.checkfood.checkfoodservice.security.module.mfa.repository;

import com.checkfood.checkfoodservice.security.module.mfa.entity.MfaBackupCodeEntity;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

/**
 * Repository pro správu záložních MFA kódů uživatelů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface MfaBackupCodeRepository
        extends JpaRepository<MfaBackupCodeEntity, Long> {

    /**
     * Vrátí všechny nevyužité záložní kódy daného uživatele.
     *
     * @param userId ID uživatele
     * @return seznam nevyužitých záložních kódů
     */
    List<MfaBackupCodeEntity> findByUserIdAndUsedFalse(Long userId);

    /**
     * Vyhledá konkrétní nevyužitý záložní kód podle hashe pro daného uživatele.
     *
     * @param userId   ID uživatele
     * @param codeHash bcrypt hash záložního kódu
     * @return Optional se záložním kódem nebo prázdný Optional
     */
    Optional<MfaBackupCodeEntity> findByUserIdAndCodeHashAndUsedFalse(
            Long userId,
            String codeHash
    );

    /**
     * Smaže všechny záložní kódy daného uživatele.
     *
     * @param userId ID uživatele
     */
    void deleteByUserId(Long userId);

}
