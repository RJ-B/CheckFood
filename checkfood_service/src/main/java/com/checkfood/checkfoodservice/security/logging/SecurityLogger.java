package com.checkfood.checkfoodservice.security.logging;

import com.checkfood.checkfoodservice.logging.ServiceLogger;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro security vrstvu aplikace.
 * Poskytuje centralizované metody pro logování bezpečnostních událostí.
 * Slouží jako rodičovská třída pro specifické loggery jednotlivých security modulů.
 *
 * @see ServiceLogger
 */
@Component
@RequiredArgsConstructor
public class SecurityLogger {

    private final ServiceLogger serviceLogger;

    public void info(String message, Object... args) {
        serviceLogger.info(message, args);
    }

    public void warn(String message, Object... args) {
        serviceLogger.warn(message, args);
    }

    public void error(String message, Object... args) {
        serviceLogger.error(message, args);
    }

    public void error(String message, Throwable throwable) {
        serviceLogger.error(message, throwable);
    }

    public void debug(String message, Object... args) {
        serviceLogger.debug(message, args);
    }
}