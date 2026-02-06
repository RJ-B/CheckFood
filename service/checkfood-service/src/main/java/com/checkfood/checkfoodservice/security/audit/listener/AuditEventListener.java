package com.checkfood.checkfoodservice.security.audit.listener;

import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.service.AuditService;

import lombok.RequiredArgsConstructor;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;

import org.springframework.context.event.EventListener;

import org.springframework.scheduling.annotation.Async;

import org.springframework.stereotype.Component;

/**
 * Listener pro auditní události.
 */
@Component
@RequiredArgsConstructor
@ConditionalOnProperty(
        prefix = "security.audit",
        name = "enabled",
        havingValue = "true",
        matchIfMissing = true
)
public class AuditEventListener {

    private final AuditService auditService;


    /**
     * Asynchronně zpracuje audit event.
     */
    @Async
    @EventListener
    public void handleAuditEvent(AuditEvent event) {

        auditService.log(
                event.getUserId(),
                event.getAction(),
                event.getStatus(),
                event.getIpAddress(),
                event.getUserAgent()
        );
    }

}
