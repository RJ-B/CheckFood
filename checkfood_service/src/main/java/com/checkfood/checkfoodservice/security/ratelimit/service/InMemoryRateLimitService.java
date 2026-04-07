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

    private final Map<String, Window> windows = new ConcurrentHashMap<>();
    private final ApplicationEventPublisher eventPublisher;
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
        Window window = windows.computeIfAbsent(key, k -> new Window(now));

        synchronized (window) {
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

    @Override
    public void reset() {
        windows.clear();
    }

    /**
     * Interní reprezentace sliding window pro rate limiting.
     * Udržuje počáteční timestamp a počitadlo požadavků pro aktuální okno.
     */
    private static class Window {
        long startTime;
        int counter;

        Window(long startTime) {
            this.startTime = startTime;
            this.counter = 0;
        }
    }

    /**
     * Publikuje audit event při překročení rate limitu.
     * Chyby při publikování jsou potlačeny, aby neblokoval rate limiting.
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
        } catch (Exception ignored) {
        }
    }
}