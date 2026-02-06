package com.checkfood.checkfoodservice.security.audit.repository;

import com.checkfood.checkfoodservice.security.audit.entity.AuditLogEntity;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;

import java.time.Instant;

/**
 * Repository pro auditní záznamy.
 */
@Repository
public interface AuditLogRepository
        extends JpaRepository<AuditLogEntity, Long> {

    /**
     * Najde záznamy podle uživatele.
     */
    Page<AuditLogEntity> findByUserId(
            Long userId,
            Pageable pageable
    );


    /**
     * Najde záznamy po určitém datu.
     */
    Page<AuditLogEntity> findByCreatedAtAfter(
            Instant from,
            Pageable pageable
    );


    /**
     * Smaže staré záznamy (retence).
     */
    long deleteByCreatedAtBefore(Instant before);

}
