package com.checkfood.checkfoodservice.security.audit.listener;

import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.service.AuditService;

import lombok.RequiredArgsConstructor;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;

import org.springframework.context.event.EventListener;

import org.springframework.scheduling.annotation.Async;

import org.springframework.stereotype.Component;

/**
 * Spring event listener pro zpracování auditních událostí.
 * Asynchronně přijímá AuditEvent události a persistuje je prostřednictvím AuditService.
 * Aktivní pouze pokud je audit modul povolen v konfiguraci.
 *
 * @see AuditEvent
 * @see AuditService
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
     * Asynchronně zpracuje auditní událost a uloží ji do databáze.
     * Zpracování probíhá v samostatném vlákně pro minimalizaci dopadu na hlavní flow.
     *
     * @param event auditní událost k zpracování
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