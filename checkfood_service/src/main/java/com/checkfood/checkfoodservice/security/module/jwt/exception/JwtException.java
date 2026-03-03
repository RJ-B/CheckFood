package com.checkfood.checkfoodservice.security.module.jwt.exception;

import com.checkfood.checkfoodservice.security.exception.SecurityException;
import org.springframework.http.HttpStatus;

/**
 * Výjimka pro JWT modul.
 * Poskytuje tovární metody pro JWT chyby.
 */
public class JwtException extends SecurityException {

    public JwtException(JwtErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    public JwtException(JwtErrorCode errorCode, String message, HttpStatus status, Throwable cause) {
        super(errorCode, message, status, cause);
    }

    // --- SECURITY & VALIDATION ---

    public static JwtException invalidToken(String details) {
        return new JwtException(
                JwtErrorCode.JWT_INVALID,
                "Neplatný JWT token: " + details,
                HttpStatus.UNAUTHORIZED
        );
    }

    public static JwtException expiredToken() {
        return new JwtException(
                JwtErrorCode.JWT_EXPIRED,
                "JWT token vypršel. Obnovte přihlášení.",
                HttpStatus.UNAUTHORIZED
        );
    }

    public static JwtException missingToken() {
        return new JwtException(
                JwtErrorCode.JWT_MISSING,
                "Autentizační token chybí.",
                HttpStatus.UNAUTHORIZED
        );
    }

    public static JwtException invalidSignature() {
        return new JwtException(
                JwtErrorCode.JWT_INVALID_SIGNATURE,
                "Neplatný podpis tokenu (Integrity Check Failed).",
                HttpStatus.UNAUTHORIZED
        );
    }

    public static JwtException blacklistedToken() {
        return new JwtException(
                JwtErrorCode.JWT_BLACKLISTED,
                "Token byl zneplatněn (odhlášen).",
                HttpStatus.UNAUTHORIZED
        );
    }

    public static JwtException invalidClaims(String details) {
        return new JwtException(
                JwtErrorCode.JWT_INVALID_CLAIMS,
                "Token obsahuje neplatná data: " + details,
                HttpStatus.UNAUTHORIZED
        );
    }

    public static JwtException unsupportedToken(String details) {
        return new JwtException(
                JwtErrorCode.JWT_UNSUPPORTED,
                "Nepodporovaný formát tokenu: " + details,
                HttpStatus.BAD_REQUEST
        );
    }

    // --- SYSTEM ERRORS (S podporou 'cause') ---

    public static JwtException generationError(String message, Throwable cause) {
        return new JwtException(
                JwtErrorCode.JWT_GENERATION_ERROR,
                "Chyba generování tokenu: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR,
                cause
        );
    }

    public static JwtException parseError(String message, Throwable cause) {
        return new JwtException(
                JwtErrorCode.JWT_PARSE_ERROR,
                "Interní chyba zpracování tokenu: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR,
                cause
        );
    }

    // --- USER CONTEXT ---

    public static JwtException userNotFound(String username) {
        return new JwtException(
                JwtErrorCode.JWT_USER_NOT_FOUND,
                "Uživatel z tokenu nenalezen: " + username,
                HttpStatus.UNAUTHORIZED
        );
    }

    public static JwtException accountDisabled() {
        return new JwtException(
                JwtErrorCode.JWT_ACCOUNT_DISABLED,
                "Účet je deaktivován.",
                HttpStatus.UNAUTHORIZED
        );
    }
}