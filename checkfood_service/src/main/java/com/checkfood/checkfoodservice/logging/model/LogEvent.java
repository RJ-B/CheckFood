package com.checkfood.checkfoodservice.logging.model;

import java.time.Instant;

/**
 * Strukturovaný logovací záznam.
 *
 * Používá se pro:
 * - JSON logy
 * - centralizované logování (ELK, GCP)
 */
public class LogEvent {

    private Instant timestamp;
    private LogLevel level;
    private String message;
    private LogContext context;

    // getters / setters
}
