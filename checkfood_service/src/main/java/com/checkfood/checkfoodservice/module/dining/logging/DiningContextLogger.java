package com.checkfood.checkfoodservice.module.dining.logging;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Slf4j
@Component
public class DiningContextLogger {

    public void logContextResolved(Long userId, UUID reservationId) {
        log.info("Dining context resolved for userId={}, reservationId={}", userId, reservationId);
    }

    public void logNoContextFound(Long userId) {
        log.debug("No active dining context found for userId={}", userId);
    }
}
