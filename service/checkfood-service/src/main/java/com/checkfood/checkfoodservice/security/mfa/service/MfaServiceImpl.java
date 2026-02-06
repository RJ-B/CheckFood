package com.checkfood.checkfoodservice.security.mfa.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;

import com.checkfood.checkfoodservice.security.mfa.dto.response.*;
import com.checkfood.checkfoodservice.security.mfa.entity.*;

import com.checkfood.checkfoodservice.security.mfa.exception.*;

import com.checkfood.checkfoodservice.security.mfa.repository.*;

import com.checkfood.checkfoodservice.security.mfa.util.*;

import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.user.service.UserService;

import lombok.RequiredArgsConstructor;

import org.springframework.context.ApplicationEventPublisher;

import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.http.HttpServletRequest;

import java.security.SecureRandom;
import java.util.*;

/**
 * Implementace MFA logiky.
 */
@Service
@RequiredArgsConstructor
@Transactional
public class MfaServiceImpl implements MfaService {

    private static final int BACKUP_CODE_COUNT = 8;
    private static final int BACKUP_CODE_LENGTH = 10;


    private final MfaSecretRepository secretRepository;
    private final MfaBackupCodeRepository backupCodeRepository;

    private final UserService userService;

    private final Base32SecretGenerator secretGenerator;
    private final QrCodePayloadBuilder qrBuilder;
    private final TotpVerifier totpVerifier;

    private final PasswordEncoder passwordEncoder;

    private final SecureRandom secureRandom = new SecureRandom();

    // Audit
    private final ApplicationEventPublisher eventPublisher;
    private final HttpServletRequest request;


    // =====================================================
    // SETUP
    // =====================================================

    @Override
    public MfaSetupStartResponse startSetup(Long userId) {

        if (secretRepository.existsByUserId(userId)) {

            publishAudit(userId, AuditAction.MFA_SETUP_START, AuditStatus.FAILED);

            throw new MfaAlreadyEnabledException("MFA already enabled");
        }

        UserEntity user =
                userService.findById(userId);

        String secret =
                secretGenerator.generate();

        MfaSecretEntity entity =
                new MfaSecretEntity();

        entity.setUser(user);
        entity.setSecret(secret);
        entity.setEnabled(false);
        entity.setMethod(MfaMethodType.TOTP);

        secretRepository.save(entity);

        publishAudit(userId, AuditAction.MFA_SETUP_START, AuditStatus.SUCCESS);

        String qrPayload =
                qrBuilder.build(user.getEmail(), secret);

        return new MfaSetupStartResponse(
                qrPayload,
                secret
        );
    }


    @Override
    public void verifySetup(Long userId, String code) {

        MfaSecretEntity secret =
                secretRepository.findByUserId(userId)
                        .orElseThrow(() -> {

                            publishAudit(
                                    userId,
                                    AuditAction.MFA_SETUP_VERIFY,
                                    AuditStatus.FAILED
                            );

                            return new MfaNotEnabledException(
                                    "MFA setup not started"
                            );
                        });

        if (secret.isEnabled()) {

            publishAudit(
                    userId,
                    AuditAction.MFA_SETUP_VERIFY,
                    AuditStatus.FAILED
            );

            throw new MfaAlreadyEnabledException("MFA already enabled");
        }

        if (!totpVerifier.verify(secret.getSecret(), code)) {

            publishAudit(
                    userId,
                    AuditAction.MFA_SETUP_VERIFY,
                    AuditStatus.FAILED
            );

            throw new MfaInvalidCodeException("Invalid MFA code");
        }

        secret.setEnabled(true);
        secret.setEnabledAt(java.time.LocalDateTime.now());

        generateBackupCodes(secret.getUser());

        publishAudit(
                userId,
                AuditAction.MFA_SETUP_VERIFY,
                AuditStatus.SUCCESS
        );
    }


    // =====================================================
    // LOGIN CHALLENGE
    // =====================================================

    @Override
    public MfaChallengeResponse verifyChallenge(Long userId, String code) {

        MfaSecretEntity secret =
                secretRepository.findByUserId(userId)
                        .orElseThrow(() -> {

                            publishAudit(
                                    userId,
                                    AuditAction.MFA_CHALLENGE,
                                    AuditStatus.FAILED
                            );

                            return new MfaNotEnabledException("MFA not enabled");
                        });

        if (!secret.isEnabled()) {

            publishAudit(
                    userId,
                    AuditAction.MFA_CHALLENGE,
                    AuditStatus.FAILED
            );

            throw new MfaNotEnabledException("MFA not enabled");
        }

        // TOTP
        if (totpVerifier.verify(secret.getSecret(), code)) {

            publishAudit(
                    userId,
                    AuditAction.MFA_CHALLENGE,
                    AuditStatus.SUCCESS
            );

            return MfaChallengeResponse.success();
        }

        // Backup codes
        String hashed =
                passwordEncoder.encode(code);

        return backupCodeRepository
                .findByUserIdAndCodeHashAndUsedFalse(
                        userId,
                        hashed
                )
                .map(backup -> {

                    backup.setUsed(true);

                    publishAudit(
                            userId,
                            AuditAction.MFA_CHALLENGE,
                            AuditStatus.SUCCESS
                    );

                    return MfaChallengeResponse.success();

                })
                .orElseThrow(() -> {

                    publishAudit(
                            userId,
                            AuditAction.MFA_CHALLENGE,
                            AuditStatus.FAILED
                    );

                    return new MfaInvalidCodeException("Invalid MFA code");
                });
    }


    // =====================================================
    // DISABLE
    // =====================================================

    @Override
    public void disable(Long userId, String password) {

        UserEntity user =
                userService.findById(userId);

        if (!passwordEncoder.matches(password, user.getPassword())) {

            publishAudit(
                    userId,
                    AuditAction.MFA_DISABLED,
                    AuditStatus.FAILED
            );

            throw new MfaException("Invalid password");
        }

        secretRepository.findByUserId(userId)
                .ifPresent(secretRepository::delete);

        backupCodeRepository.deleteByUserId(userId);

        publishAudit(
                userId,
                AuditAction.MFA_DISABLED,
                AuditStatus.SUCCESS
        );
    }


    // =====================================================
    // STATUS
    // =====================================================

    @Override
    public MfaStatusResponse getStatus(Long userId) {

        boolean enabled =
                secretRepository.findByUserId(userId)
                        .map(MfaSecretEntity::isEnabled)
                        .orElse(false);

        return new MfaStatusResponse(enabled);
    }


    // =====================================================
    // BACKUP CODES
    // =====================================================

    private void generateBackupCodes(UserEntity user) {

        backupCodeRepository.deleteByUserId(user.getId());

        List<MfaBackupCodeEntity> codes =
                new ArrayList<>();

        for (int i = 0; i < BACKUP_CODE_COUNT; i++) {

            String rawCode =
                    generateRandomCode();

            MfaBackupCodeEntity entity =
                    new MfaBackupCodeEntity();

            entity.setUser(user);

            entity.setCodeHash(
                    passwordEncoder.encode(rawCode)
            );

            codes.add(entity);
        }

        backupCodeRepository.saveAll(codes);

        // TODO: doručit uživateli (UI/Email)
    }


    private String generateRandomCode() {

        String chars =
                "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

        StringBuilder sb =
                new StringBuilder();

        for (int i = 0; i < BACKUP_CODE_LENGTH; i++) {

            sb.append(
                    chars.charAt(
                            secureRandom.nextInt(chars.length())
                    )
            );
        }

        return sb.toString();
    }


    // =====================================================
    // AUDIT
    // =====================================================

    private void publishAudit(
            Long userId,
            AuditAction action,
            AuditStatus status
    ) {

        eventPublisher.publishEvent(
                new AuditEvent(
                        this,
                        userId,
                        action,
                        status,
                        request.getRemoteAddr(),
                        request.getHeader("User-Agent")
                )
        );
    }

}
