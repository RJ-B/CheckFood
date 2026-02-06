package com.checkfood.checkfoodservice.security.handler;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Standardní formát chybové odpovědi API.
 */
@Getter
@Setter
@AllArgsConstructor
public class ErrorResponse {

    // Interní kód chyby
    private ErrorCode code;

    // Uživatelsky čitelná zpráva
    private String message;

    // HTTP status
    private int status;

    // Čas chyby
    private LocalDateTime timestamp;

}
