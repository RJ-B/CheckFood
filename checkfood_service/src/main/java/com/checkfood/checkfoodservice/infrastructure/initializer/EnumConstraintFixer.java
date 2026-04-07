package com.checkfood.checkfoodservice.infrastructure.initializer;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.annotation.Profile;
import org.springframework.context.event.EventListener;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * Odstraňuje zastaralé check constraints generované Hibernate při startu aplikace.
 * Hibernate 6 s {@code ddl-auto=update} vytváří check constraints pro sloupce anotované
 * {@code @Enumerated(STRING)}, ale neaktualizuje je při přidání nových enum hodnot, což způsobuje selhání insertů.
 * Spouští se pouze v profilu {@code local}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Component
@Profile("local")
public class EnumConstraintFixer {

    @PersistenceContext
    private EntityManager em;

    /**
     * Odstraní zastaralé enum check constraints po startu aplikace, před spuštěním datových seederů.
     */
    @EventListener(ApplicationReadyEvent.class)
    @Order(1)
    @Transactional
    public void dropStaleEnumConstraints() {
        dropConstraintIfExists("reservation", "reservation_status_check");
        log.info("[EnumConstraintFixer] Dropped stale enum check constraints (if they existed).");
    }

    private void dropConstraintIfExists(String table, String constraint) {
        try {
            em.createNativeQuery(
                    "ALTER TABLE " + table + " DROP CONSTRAINT IF EXISTS " + constraint
            ).executeUpdate();
        } catch (Exception e) {
            log.warn("[EnumConstraintFixer] Could not drop constraint {}.{}: {}",
                    table, constraint, e.getMessage());
        }
    }
}
