package com.checkfood.checkfoodservice.module.order.logging;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Slf4j
@Component
public class OrderLogger {

    public void logOrderCreated(UUID orderId, Long userId, UUID restaurantId, int totalPriceMinor) {
        log.info("Order created: orderId={}, userId={}, restaurantId={}, total={} minor",
                orderId, userId, restaurantId, totalPriceMinor);
    }

    public void logNoDiningContext(Long userId) {
        log.debug("Order creation failed - no dining context for userId={}", userId);
    }

    public void logItemValidationFailed(UUID menuItemId, String reason) {
        log.info("Order item validation failed: menuItemId={}, reason={}", menuItemId, reason);
    }
}
