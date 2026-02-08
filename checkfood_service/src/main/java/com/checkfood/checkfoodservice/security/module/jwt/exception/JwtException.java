package com.checkfood.checkfoodservice.security.module.jwt.exception;

import com.checkfood.checkfoodservice.security.exception.SecurityException;
import org.springframework.http.HttpStatus;

/**
 * Výjimka pro JWT modul.
 * Poskytuje tovární metody pro nejčastější JWT chyby s přednastavenými HTTP stavy a error kódy.
 *
 * @see SecurityException
 * @see JwtErrorCode
 */
public class JwtException extends SecurityException {

    /**
     * Vytvoří novou JWT výjimku.
     *
     * @param errorCode JWT error kód
     * @param message lidsky čitelná chybová zpráva
     * @param status HTTP status kód odpovědi
     */
    public JwtException(JwtErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * JWT token je neplatný.
     *
     * @return výjimka s HTTP 401 Unauthorized
     */
    public static JwtException invalidToken() {
        return new JwtException(
                JwtErrorCode.JWT_INVALID,
                "Neplatný JWT token.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * JWT token vypršel.
     *
     * @return výjimka s HTTP 401 Unauthorized
     */
    public static JwtException expiredToken() {
        return new JwtException(
                JwtErrorCode.JWT_EXPIRED,
                "JWT token vypršel.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * JWT token chybí v požadavku.
     *
     * @return výjimka s HTTP 401 Unauthorized
     */
    public static JwtException missingToken() {
        return new JwtException(
                JwtErrorCode.JWT_MISSING,
                "JWT token chybí v požadavku.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * JWT token má neplatný podpis.
     *
     * @return výjimka s HTTP 401 Unauthorized
     */
    public static JwtException invalidSignature() {
        return new JwtException(
                JwtErrorCode.JWT_INVALID_SIGNATURE,
                "JWT token má neplatný podpis.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * JWT token má neplatné claims.
     *
     * @return výjimka s HTTP 401 Unauthorized
     */
    public static JwtException invalidClaims() {
        return new JwtException(
                JwtErrorCode.JWT_INVALID_CLAIMS,
                "JWT token má neplatné claims.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Chyba při generování JWT tokenu.
     *
     * @param message detailní popis chyby
     * @return výjimka s HTTP 500 Internal Server Error
     */
    public static JwtException generationError(String message) {
        return new JwtException(
                JwtErrorCode.JWT_GENERATION_ERROR,
                "Chyba při generování JWT tokenu: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    /**
     * Chyba při parsování JWT tokenu.
     *
     * @param message detailní popis chyby
     * @return výjimka s HTTP 401 Unauthorized
     */
    public static JwtException parseError(String message) {
        return new JwtException(
                JwtErrorCode.JWT_PARSE_ERROR,
                "Chyba při parsování JWT tokenu: " + message,
                HttpStatus.UNAUTHORIZED
        );
    }
}