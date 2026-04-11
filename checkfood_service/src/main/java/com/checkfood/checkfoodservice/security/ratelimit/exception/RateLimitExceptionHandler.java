package com.checkfood.checkfoodservice.security.ratelimit.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;

import lombok.RequiredArgsConstructor;

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Dedikovaný globální handler pro {@link RateLimitExceededException} s nejvyšší
 * prioritou (Ordered.HIGHEST_PRECEDENCE).
 *
 * <p>Proč samostatný advice místo spoléhání na dědičnost v SecurityExceptionHandler:
 * Řetěz {@code SecurityExceptionHandler → ServiceExceptionHandler} definuje
 * současně {@code @ExceptionHandler(RateLimitExceededException.class)} (429)
 * i {@code @ExceptionHandler(Exception.class)} (500). Tyto handlery jsou děděny
 * každým {@code @RestControllerAdvice} potomkem (Auth, OAuth, User, Order…),
 * takže Spring má k dispozici N registrací téhož páru. Priorita, kterou Spring
 * volí mezi advice classes je závislá na beanu-factory orderingu, takže pro
 * některé controllery se prosadil fallback handler{@code (Exception.class)} →
 * HTTP 500 místo 429. Byl to hlášený security-audit bug.
 *
 * <p>Řešení: Vytáhnout rate-limit handler do samostatné advice s
 * {@code @Order(HIGHEST_PRECEDENCE)}, čímž je garantováno že je vyřešen první.
 *
 * @author Rostislav Jirák + CheckFood team, Apr 2026
 */
@RestControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE)
@RequiredArgsConstructor
public class RateLimitExceptionHandler {

    private final ErrorResponseBuilder errorResponseBuilder;

    /**
     * Mapuje {@link RateLimitExceededException} na HTTP 429 Too Many Requests.
     * Fires před jakýmkoliv jiným {@code @ExceptionHandler}, takže eliminuje
     * fallback-to-500 race se ServiceExceptionHandler.handleGenericException.
     */
    @ExceptionHandler(RateLimitExceededException.class)
    public ResponseEntity<ErrorResponse> handleRateLimit(RateLimitExceededException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                "RATE_LIMIT_EXCEEDED",
                "Příliš mnoho pokusů. Zkuste to prosím později.",
                HttpStatus.TOO_MANY_REQUESTS
        );
        return new ResponseEntity<>(response, HttpStatus.TOO_MANY_REQUESTS);
    }
}
