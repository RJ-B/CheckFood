package com.checkfood.checkfoodservice.module.initializer;

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
 * Drops stale Hibernate-generated enum check constraints on startup.
 * Hibernate 6 {@code ddl-auto=update} creates check constraints for
 * {@code @Enumerated(STRING)} columns but never updates them when new
 * enum values are added, causing inserts to fail.
 *
 * Only runs in the "local" profile.
 */
@Slf4j
@Component
@Profile("local")
public class EnumConstraintFixer {

    @PersistenceContext
    private EntityManager em;

    @EventListener(ApplicationReadyEvent.class)
    @Order(1) // Run before all data seeders
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
