package com.checkfood.checkfoodservice.security.audit.dto;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;

import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

/**
 * DTO pro přenos auditního záznamu v API odpovědích.
 * Obsahuje základní informace o auditované akci a jejím kontextu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuditAction
 * @see AuditStatus
 */
@Getter
@Setter
public class AuditLogResponse {

    private Long id;

    private Long userId;

    private AuditAction action;

    private AuditStatus status;

    private String ipAddress;

    private String userAgent;

    private Instant createdAt;

}