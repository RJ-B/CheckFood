package com.checkfood.checkfoodservice.logging.model;

import java.time.Instant;

/**
 * Strukturovaný logovací záznam pro JSON logy a centralizované logování (ELK, GCP).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class LogEvent {

    private Instant timestamp;
    private LogLevel level;
    private String message;
    private LogContext context;

    // getters / setters
}
