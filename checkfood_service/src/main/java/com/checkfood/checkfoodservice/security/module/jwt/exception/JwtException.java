package com.checkfood.checkfoodservice.security.module.jwt.exception;

import com.checkfood.checkfoodservice.security.exception.SecurityException;
import org.springframework.http.HttpStatus;

/**
 * Specializovaná výjimka pro JWT modul poskytující tovární metody pro typované JWT chybové scénáře.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see JwtErrorCode
 */
public class JwtException extends SecurityException {

    /**
     * Vytvoří JWT výjimku s typovaným error kódem.
     *
     * @param errorCode JWT error kód
     * @param message   uživatelsky čitelná chybová zpráva
     * @param status    HTTP status pro REST odpověď
     */
    public JwtException(JwtErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Vytvoří JWT výjimku s příčinou pro system error scénáře.
     *
     * @param errorCode JWT error kód
     * @param message   uživatelsky čitelná chybová zpráva
     * @param status    HTTP status pro REST odpověď
     * @param cause     původní výjimka
     */
    public JwtException(JwtErrorCode errorCode, String message, HttpStatus status, Throwable cause) {
        super(errorCode, message, status, cause);
    }

    /**
     * Neplatný nebo poškozený JWT token.
     *
     * @param details podrobnosti o důvodu neplatnosti
     * @return JwtException s HTTP 401
     */
    public static JwtException invalidToken(String details) {
        return new JwtException(
                JwtErrorCode.JWT_INVALID,
                "Neplatný JWT token: " + details,
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * JWT token vypršel a vyžaduje refresh.
     *
     * @return JwtException s HTTP 401
     */
    public static JwtException expiredToken() {
        return new JwtException(
                JwtErrorCode.JWT_EXPIRED,
                "JWT token vypršel. Obnovte přihlášení.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * JWT token chybí v Authorization headeru.
     *
     * @return JwtException s HTTP 401
     */
    public static JwtException missingToken() {
        return new JwtException(
                JwtErrorCode.JWT_MISSING,
                "Autentizační token chybí.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Podpis JWT tokenu je neplatný — možná manipulace s tokenem.
     *
     * @return JwtException s HTTP 401
     */
    public static JwtException invalidSignature() {
        return new JwtException(
                JwtErrorCode.JWT_INVALID_SIGNATURE,
                "Neplatný podpis tokenu (Integrity Check Failed).",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Token byl zneplatněn — pokus o použití po odhlášení.
     *
     * @return JwtException s HTTP 401
     */
    public static JwtException blacklistedToken() {
        return new JwtException(
                JwtErrorCode.JWT_BLACKLISTED,
                "Token byl zneplatněn (odhlášen).",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Token obsahuje neplatná nebo neočekávaná data (claims).
     *
     * @param details popis neplatných claims
     * @return JwtException s HTTP 401
     */
    public static JwtException invalidClaims(String details) {
        return new JwtException(
                JwtErrorCode.JWT_INVALID_CLAIMS,
                "Token obsahuje neplatná data: " + details,
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Token má nepodporovaný formát nebo algoritmus.
     *
     * @param details popis nepodporovaného formátu
     * @return JwtException s HTTP 400
     */
    public static JwtException unsupportedToken(String details) {
        return new JwtException(
                JwtErrorCode.JWT_UNSUPPORTED,
                "Nepodporovaný formát tokenu: " + details,
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Chyba při generování tokenu, typicky kryptografická.
     *
     * @param message popis chyby
     * @param cause   původní výjimka
     * @return JwtException s HTTP 500
     */
    public static JwtException generationError(String message, Throwable cause) {
        return new JwtException(
                JwtErrorCode.JWT_GENERATION_ERROR,
                "Chyba generování tokenu: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR,
                cause
        );
    }

    /**
     * Interní chyba parseru při zpracování tokenu.
     *
     * @param message popis chyby
     * @param cause   původní výjimka
     * @return JwtException s HTTP 500
     */
    public static JwtException parseError(String message, Throwable cause) {
        return new JwtException(
                JwtErrorCode.JWT_PARSE_ERROR,
                "Interní chyba zpracování tokenu: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR,
                cause
        );
    }

    /**
     * Uživatel z tokenu nebyl nalezen v systému.
     *
     * @param username email nebo username z tokenu
     * @return JwtException s HTTP 401
     */
    public static JwtException userNotFound(String username) {
        return new JwtException(
                JwtErrorCode.JWT_USER_NOT_FOUND,
                "Uživatel z tokenu nenalezen: " + username,
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Uživatelský účet z tokenu je deaktivován.
     *
     * @return JwtException s HTTP 401
     */
    public static JwtException accountDisabled() {
        return new JwtException(
                JwtErrorCode.JWT_ACCOUNT_DISABLED,
                "Účet je deaktivován.",
                HttpStatus.UNAUTHORIZED
        );
    }
}