package com.checkfood.checkfoodservice.exception;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

/**
 * Základní builder pro vytváření standardizovaných chybových odpovědí.
 * Poskytuje jednotné rozhraní pro sestavení ErrorResponse objektů napříč celou aplikací.
 * Slouží jako rodičovská třída pro specifické buildery jednotlivých vrstev.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see ErrorResponse
 */
@Component
@RequiredArgsConstructor
public class ErrorResponseBuilder {

    /**
     * Vytvoří standardizovanou chybovou odpověď s obecným error kódem.
     *
     * @param code aplikační error kód (ErrorCode nebo jakýkoliv enum)
     * @param message lidsky čitelná chybová zpráva
     * @param status HTTP status kód
     * @return vytvořená chybová odpověď
     */
    public ErrorResponse build(Object code, String message, HttpStatus status) {
        return new ErrorResponse(
                code,
                message,
                status.value(),
                LocalDateTime.now()
        );
    }

    /**
     * Vytvoří standardizovanou chybovou odpověď s celočíselným status kódem.
     *
     * @param code aplikační error kód (ErrorCode nebo jakýkoliv enum)
     * @param message lidsky čitelná chybová zpráva
     * @param statusCode HTTP status kód jako int
     * @return vytvořená chybová odpověď
     */
    public ErrorResponse build(Object code, String message, int statusCode) {
        return new ErrorResponse(
                code,
                message,
                statusCode,
                LocalDateTime.now()
        );
    }
}