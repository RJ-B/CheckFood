package com.checkfood.checkfoodservice.security.audit.dto;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;

import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

/**
 * DTO pro auditní záznam.
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
