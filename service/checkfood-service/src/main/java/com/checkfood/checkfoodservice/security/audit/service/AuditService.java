package com.checkfood.checkfoodservice.security.audit.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.audit.entity.AuditLogEntity;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service pro práci s auditními záznamy.
 */
public interface AuditService {

    /**
     * Uloží nový auditní záznam.
     */
    void log(
            Long userId,
            AuditAction action,
            AuditStatus status,
            String ipAddress,
            String userAgent
    );


    /**
     * Najde záznamy podle uživatele.
     */
    Page<AuditLogEntity> findByUser(
            Long userId,
            Pageable pageable
    );


    /**
     * Najde všechny záznamy.
     */
    Page<AuditLogEntity> findAll(Pageable pageable);


    /**
     * Smaže staré záznamy podle retence.
     */
    long cleanupOldLogs();

}
