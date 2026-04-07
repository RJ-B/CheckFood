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
 * Implementace auditního servisu pro správu auditních záznamů.
 * Poskytuje persistenci logů, vyhledávání a automatický úklid starých záznamů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuditService
 * @see AuditLogRepository
 * @see AuditProperties
 */
@Service
@RequiredArgsConstructor
@Transactional
public class AuditServiceImpl implements AuditService {

    private final AuditLogRepository auditLogRepository;
    private final AuditProperties auditProperties;


    /**
     * Vytvoří a uloží nový auditní záznam do databáze.
     * Pokud je audit modul vypnutý, operace se přeskočí.
     *
     * @param userId ID uživatele (null pro anonymní akce)
     * @param action typ provedené akce
     * @param status výsledek akce
     * @param ipAddress IP adresa klienta
     * @param userAgent user agent klienta
     */
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


    /**
     * Vyhledá auditní záznamy konkrétního uživatele.
     *
     * @param userId ID uživatele
     * @param pageable parametry stránkování a řazení
     * @return stránkovaný seznam auditních záznamů daného uživatele
     */
    @Override
    @Transactional(readOnly = true)
    public Page<AuditLogEntity> findByUser(
            Long userId,
            Pageable pageable
    ) {

        return auditLogRepository
                .findByUserId(userId, pageable);
    }


    /**
     * Vyhledá všechny auditní záznamy v systému.
     *
     * @param pageable parametry stránkování a řazení
     * @return stránkovaný seznam všech auditních záznamů
     */
    @Override
    @Transactional(readOnly = true)
    public Page<AuditLogEntity> findAll(Pageable pageable) {

        return auditLogRepository.findAll(pageable);
    }


    /**
     * Automaticky maže auditní záznamy starší než limit definovaný retenční politikou.
     * Spouští se denně ve 3:00 ráno podle cron výrazu.
     * Pokud je audit modul vypnutý, operace se přeskočí.
     *
     * @return počet smazaných záznamů
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