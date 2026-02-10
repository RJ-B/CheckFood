package com.checkfood.checkfoodservice.exception.model;

import java.time.Instant;
import java.util.List;

/**
 * Standardizovaná chybová odpověď REST API.
 */
public class ApiErrorResponse {

    private String message;
    private int status;
    private Instant timestamp;
    private List<ApiErrorDetail> details;

    // getters / setters
}
