package com.checkfood.checkfoodservice.security.audit.service;

import com.checkfood.checkfoodservice.security.audit.entity.AuditLogEntity;
import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.audit.properties.AuditProperties;
import com.checkfood.checkfoodservice.security.audit.repository.AuditLogRepository;

import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import org.springframework.scheduling.annotation.Scheduled;

import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.Instant;

/**
 * Implementace auditního servisu.
 */
@Service
@RequiredArgsConstructor
@Transactional
public class AuditServiceImpl implements AuditService {

    private final AuditLogRepository auditLogRepository;
    private final AuditProperties auditProperties;


    @Override
    public void log(
            Long userId,
            AuditAction action,
            AuditStatus status,
            String ipAddress,
            String userAgent
    ) {

        if (!auditProperties.isEnabled()) {
            return;
        }

        AuditLogEntity log = new AuditLogEntity();

        log.setUserId(userId);
        log.setAction(action);
        log.setStatus(status);
        log.setIpAddress(ipAddress);
        log.setUserAgent(userAgent);

        auditLogRepository.save(log);
    }


    @Override
    @Transactional(readOnly = true)
    public Page<AuditLogEntity> findByUser(
            Long userId,
            Pageable pageable
    ) {

        return auditLogRepository
                .findByUserId(userId, pageable);
    }


    @Override
    @Transactional(readOnly = true)
    public Page<AuditLogEntity> findAll(Pageable pageable) {

        return auditLogRepository.findAll(pageable);
    }


    /**
     * Automatické mazání starých záznamů.
     */
    @Override
    @Scheduled(cron = "0 0 3 * * ?")
    public long cleanupOldLogs() {

        if (!auditProperties.isEnabled()) {
            return 0;
        }

        int retentionDays =
                auditProperties.getRetentionDays();

        Instant threshold =
                Instant.now()
                        .minus(Duration.ofDays(retentionDays));

        return auditLogRepository
                .deleteByCreatedAtBefore(threshold);
    }

}
