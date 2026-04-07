package com.checkfood.checkfoodservice.module.order.dining.logging;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.UUID;

/**
 * Pomocná logovací komponenta pro modul dining context.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Component
public class DiningContextLogger {

    /**
     * Zaznamená úspěšné nalezení aktivního dining kontextu pro uživatele.
     *
     * @param userId        ID uživatele
     * @param reservationId UUID nalezené rezervace
     */
    public void logContextResolved(Long userId, UUID reservationId) {
        log.info("Dining context resolved for userId={}, reservationId={}", userId, reservationId);
    }

    /**
     * Zaznamená situaci, kdy pro uživatele nebyl nalezen žádný aktivní dining kontext.
     *
     * @param userId ID uživatele bez aktivního kontextu
     */
    public void logNoContextFound(Long userId) {
        log.debug("No active dining context found for userId={}", userId);
    }
}
