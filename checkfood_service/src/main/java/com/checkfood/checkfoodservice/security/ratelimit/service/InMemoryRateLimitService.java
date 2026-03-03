package com.checkfood.checkfoodservice.security.ratelimit.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditEvent;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * In-memory implementace rate limiting s sliding window algoritmem.
 *
 * Vhodné pro single-instance aplikace nebo development prostředí.
 * Pro production distributed systémy doporučujeme Redis-based implementaci
 * pro shared state napříč application instances.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see RateLimitService
 * @see AuditEvent
 */
@Service
@RequiredArgsConstructor
public class InMemoryRateLimitService implements RateLimitService {

    /**
     * Concurrent storage pro rate limit windows indexed by rate limit key.
     * ConcurrentHashMap poskytuje thread-safe access pro multi-threaded environment.
     */
    private final Map<String, Window> windows = new ConcurrentHashMap<>();

    /**
     * Event publisher pro security audit když rate limit je exceeded.
     */
    private final ApplicationEventPublisher eventPublisher;

    /**
     * HTTP request context pro audit metadata extraction.
     */
    private final HttpServletRequest request;

    /**
     * Pokusí se acquire rate limit token pro daný key v rámci specifikovaného limitu.
     * Implementuje sliding window algorithm s automatic window reset.
     *
     * @param key unique identifier pro rate limit bucket
     * @param limit maximální počet requests per window
     * @param windowMillis délka time window v millisekondách
     * @return true pokud request je allowed, false pokud rate limit exceeded
     */
    @Override
    public boolean tryAcquire(String key, int limit, long windowMillis) {
        long now = System.currentTimeMillis();

        // Lazy initialization nového window pro key
        Window window = windows.computeIfAbsent(key, k -> new Window(now));

        synchronized (window) {
            // Window reset logic - sliding window behavior
            if (now - window.startTime > windowMillis) {
                window.startTime = now;
                window.counter = 0;
            }

            // Rate limit check
            if (window.counter >= limit) {
                publishAudit();
                return false;
            }

            // Increment counter a allow request
            window.counter++;
            return true;
        }
    }

    @Override
    public void reset() {
        windows.clear();
    }

    /**
     * Internal time window representation pro rate limiting state.
     * Mutable pro performance - immutable objects by způsobily unnecessary allocation overhead.
     */
    private static class Window {
        /**
         * Window start timestamp v millisekondách.
         */
        long startTime;

        /**
         * Request counter pro current window.
         */
        int counter;

        /**
         * Vytvoří nový time window se start time a zero counter.
         *
         * @param startTime initial window timestamp
         */
        Window(long startTime) {
            this.startTime = startTime;
            this.counter = 0;
        }
    }

    /**
     * Publikuje audit event když rate limit je exceeded pro security monitoring.
     * Silent failure - audit errors nesmí blokovat rate limiting functionality.
     */
    private void publishAudit() {
        try {
            eventPublisher.publishEvent(new AuditEvent(
                    this,
                    null,
                    AuditAction.RATE_LIMIT_EXCEEDED,
                    AuditStatus.BLOCKED,
                    request.getRemoteAddr(),
                    request.getHeader("User-Agent")
            ));
        } catch (Exception e) {
            // Silent failure - rate limiting má priority nad audit logging
        }
    }
}