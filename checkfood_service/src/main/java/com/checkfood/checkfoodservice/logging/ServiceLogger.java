package com.checkfood.checkfoodservice.logging;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * Základní logger pro celou aplikaci.
 * Poskytuje centralizované metody pro logování na různých úrovních.
 * Slouží jako rodičovská třída pro specifické loggery jednotlivých vrstev.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Component
public class ServiceLogger {

    /**
     * Loguje informační zprávu.
     *
     * @param message zpráva k zalogování
     * @param args argumenty pro formátování zprávy
     */
    public void info(String message, Object... args) {
        log.info(message, args);
    }

    /**
     * Loguje varovnou zprávu.
     *
     * @param message zpráva k zalogování
     * @param args argumenty pro formátování zprávy
     */
    public void warn(String message, Object... args) {
        log.warn(message, args);
    }

    /**
     * Loguje chybovou zprávu.
     *
     * @param message zpráva k zalogování
     * @param args argumenty pro formátování zprávy
     */
    public void error(String message, Object... args) {
        log.error(message, args);
    }

    /**
     * Loguje chybovou zprávu včetně exception.
     *
     * @param message zpráva k zalogování
     * @param throwable výjimka k zalogování
     */
    public void error(String message, Throwable throwable) {
        log.error(message, throwable);
    }

    /**
     * Loguje debug zprávu.
     *
     * @param message zpráva k zalogování
     * @param args argumenty pro formátování zprávy
     */
    public void debug(String message, Object... args) {
        log.debug(message, args);
    }

    /**
     * Loguje trace zprávu.
     *
     * @param message zpráva k zalogování
     * @param args argumenty pro formátování zprávy
     */
    public void trace(String message, Object... args) {
        log.trace(message, args);
    }
}