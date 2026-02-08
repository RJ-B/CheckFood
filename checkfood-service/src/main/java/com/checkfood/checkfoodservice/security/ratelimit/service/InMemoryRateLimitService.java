package com.checkfood.checkfoodservice.security.ratelimit.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;

import lombok.RequiredArgsConstructor;

import org.springframework.context.ApplicationEventPublisher;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * In-memory implementace rate limitu (sliding window).
 *
 * Vhodné pro single-instance aplikace.
 */
@Service
@RequiredArgsConstructor
public class InMemoryRateLimitService implements RateLimitService {

    /**
     * key -> window
     */
    private final Map<String, Window> windows =
            new ConcurrentHashMap<>();

    // Audit
    private final ApplicationEventPublisher eventPublisher;
    private final HttpServletRequest request;


    @Override
    public boolean tryAcquire(
            String key,
            int limit,
            long windowMillis
    ) {

        long now =
                System.currentTimeMillis();

        Window window =
                windows.computeIfAbsent(
                        key,
                        k -> new Window(now)
                );

        synchronized (window) {

            // Nové okno
            if (now - window.startTime > windowMillis) {

                window.startTime = now;
                window.counter = 0;
            }

            if (window.counter >= limit) {

                publishAudit();

                return false;
            }

            window.counter++;

            return true;
        }
    }


    // =========================================

    private static class Window {

        long startTime;

        int counter;


        Window(long startTime) {
            this.startTime = startTime;
            this.counter = 0;
        }
    }


    // =========================================
    // AUDIT
    // =========================================

    private void publishAudit() {

        eventPublisher.publishEvent(
                new AuditEvent(
                        this,
                        null,
                        AuditAction.RATE_LIMIT_EXCEEDED,
                        AuditStatus.BLOCKED,
                        request.getRemoteAddr(),
                        request.getHeader("User-Agent")
                )
        );
    }

}
