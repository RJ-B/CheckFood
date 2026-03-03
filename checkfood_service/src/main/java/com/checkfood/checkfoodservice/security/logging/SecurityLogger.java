package com.checkfood.checkfoodservice.security.logging;

import com.checkfood.checkfoodservice.logging.ServiceLogger;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro security vrstvu aplikace.
 * Dědí z ServiceLogger a poskytuje základ pro všechny loggery v rámci security modulů.
 */
@Component
public class SecurityLogger extends ServiceLogger {
    // Využívá metody info(), warn(), error() atd. definované v ServiceLogger
}