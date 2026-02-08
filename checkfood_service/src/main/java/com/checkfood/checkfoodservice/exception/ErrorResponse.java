package com.checkfood.checkfoodservice.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Standardizovaný formát chybové odpovědi API.
 * Poskytuje konzistentní strukturu pro komunikaci chyb směrem ke klientovi.
 * Podporuje jak obecné ErrorCode, tak specifické error kódy jednotlivých vrstev.
 */
@Getter
@Setter
@AllArgsConstructor
public class ErrorResponse {

    private Object code;

    private String message;

    private int status;

    private LocalDateTime timestamp;
}