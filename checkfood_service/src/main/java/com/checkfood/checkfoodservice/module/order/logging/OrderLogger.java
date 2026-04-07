package com.checkfood.checkfoodservice.module.order.logging;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.UUID;

/**
 * Pomocná logovací komponenta pro modul objednávek.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Component
public class OrderLogger {

    /**
     * Zaznamená úspěšné vytvoření objednávky.
     *
     * @param orderId         UUID nové objednávky
     * @param userId          ID uživatele, který objednávku vytvořil
     * @param restaurantId    UUID restaurace
     * @param totalPriceMinor celková cena v nejmenší měnové jednotce
     */
    public void logOrderCreated(UUID orderId, Long userId, UUID restaurantId, int totalPriceMinor) {
        log.info("Order created: orderId={}, userId={}, restaurantId={}, total={} minor",
                orderId, userId, restaurantId, totalPriceMinor);
    }

    /**
     * Zaznamená neúspěšné vytvoření objednávky z důvodu chybějícího sezení u stolu.
     *
     * @param userId ID uživatele bez aktivního sezení
     */
    public void logNoDiningContext(Long userId) {
        log.debug("Order creation failed - no dining context for userId={}", userId);
    }

    /**
     * Zaznamená selhání validace položky objednávky.
     *
     * @param menuItemId UUID položky menu, která neprošla validací
     * @param reason     důvod selhání validace
     */
    public void logItemValidationFailed(UUID menuItemId, String reason) {
        log.info("Order item validation failed: menuItemId={}, reason={}", menuItemId, reason);
    }
}
