package com.checkfood.checkfoodservice.security.module.auth.exception;

import com.checkfood.checkfoodservice.security.exception.SecurityException;
import org.springframework.http.HttpStatus;

/**
 * Výjimka pro autentizační modul.
 * Poskytuje tovární metody pro nejčastější autentizační chyby s přednastavenými HTTP stavy a error kódy.
 *
 * @see SecurityException
 * @see AuthErrorCode
 */
public class AuthException extends SecurityException {

    /**
     * Vytvoří novou autentizační výjimku.
     *
     * @param errorCode aplikační error kód pro identifikaci typu chyby
     * @param message lidsky čitelná chybová zpráva
     * @param status HTTP status kód odpovědi
     */
    public AuthException(AuthErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Neplatné přihlašovací údaje.
     * Používá se při nesprávném emailu nebo heslu.
     *
     * @return výjimka s HTTP 401 Unauthorized
     */
    public static AuthException invalidCredentials() {
        return new AuthException(
                AuthErrorCode.AUTH_INVALID_CREDENTIALS,
                "Neplatný email nebo heslo.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Email je již registrován v systému.
     * Používá se při pokusu o registraci s existujícím emailem.
     *
     * @return výjimka s HTTP 409 Conflict
     */
    public static AuthException emailExists() {
        return new AuthException(
                AuthErrorCode.AUTH_EMAIL_EXISTS,
                "Uživatel s tímto emailem již existuje.",
                HttpStatus.CONFLICT
        );
    }

    /**
     * Uživatelský účet byl deaktivován administrátorem.
     *
     * @return výjimka s HTTP 403 Forbidden
     */
    public static AuthException accountDisabled() {
        return new AuthException(
                AuthErrorCode.AUTH_ACCOUNT_DISABLED,
                "Váš účet byl deaktivován. Kontaktujte prosím podporu.",
                HttpStatus.FORBIDDEN
        );
    }

    /**
     * Uživatelský účet byl uzamčen z bezpečnostních důvodů.
     * Typicky po několika neúspěšných pokusech o přihlášení.
     *
     * @return výjimka s HTTP 423 Locked
     */
    public static AuthException accountLocked() {
        return new AuthException(
                AuthErrorCode.AUTH_ACCOUNT_LOCKED,
                "Váš účet byl uzamčen z bezpečnostních důvodů.",
                HttpStatus.LOCKED
        );
    }

    /**
     * Refresh token je neplatný nebo vypršel.
     * Uživatel musí provést nové přihlášení.
     *
     * @return výjimka s HTTP 401 Unauthorized
     */
    public static AuthException sessionExpired() {
        return new AuthException(
                AuthErrorCode.AUTH_SESSION_EXPIRED,
                "Vaše relace vypršela nebo byla ukončena. Přihlaste se prosím znovu.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Verifikační token neexistuje nebo není platný.
     *
     * @return výjimka s HTTP 400 Bad Request
     */
    public static AuthException invalidVerificationToken() {
        return new AuthException(
                AuthErrorCode.AUTH_TOKEN_INVALID,
                "Neplatný nebo neexistující verifikační token.",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Verifikační token vypršel a již nemůže být použit.
     * Uživatel musí požádat o nový verifikační email.
     *
     * @return výjimka s HTTP 410 Gone
     */
    public static AuthException verificationTokenExpired() {
        return new AuthException(
                AuthErrorCode.AUTH_TOKEN_EXPIRED,
                "Verifikační token vypršel. Požádejte o nový.",
                HttpStatus.GONE
        );
    }

    /**
     * Uživatelský účet nebyl aktivován prostřednictvím verifikačního emailu.
     *
     * @return výjimka s HTTP 403 Forbidden
     */
    public static AuthException accountNotVerified() {
        return new AuthException(
                AuthErrorCode.AUTH_ACCOUNT_NOT_VERIFIED,
                "Účet není aktivní. Zkontrolujte prosím svůj e-mail a potvrďte registraci.",
                HttpStatus.FORBIDDEN
        );
    }

    /**
     * Obecná interní chyba serveru při zpracování autentizační operace.
     *
     * @param message popis chyby
     * @return výjimka s HTTP 500 Internal Server Error
     */
    public static AuthException internalError(String message) {
        return new AuthException(
                AuthErrorCode.AUTH_ACCOUNT_DISABLED,
                message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    /**
     * Hesla v registračním formuláři se neshodují.
     *
     * @return výjimka s HTTP 400 Bad Request
     */
    public static AuthException passwordMismatch() {
        return new AuthException(
                AuthErrorCode.AUTH_PASSWORD_MISMATCH,
                "Hesla se neshodují.",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Heslo nesplňuje bezpečnostní požadavky.
     *
     * @return výjimka s HTTP 400 Bad Request
     */
    public static AuthException weakPassword() {
        return new AuthException(
                AuthErrorCode.AUTH_WEAK_PASSWORD,
                "Heslo nesplňuje bezpečnostní požadavky.",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Neplatný formát emailové adresy.
     *
     * @return výjimka s HTTP 400 Bad Request
     */
    public static AuthException invalidEmailFormat() {
        return new AuthException(
                AuthErrorCode.AUTH_INVALID_EMAIL_FORMAT,
                "Neplatný formát emailové adresy.",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Refresh token nepatří zadanému zařízení.
     * Možný pokus o zneužití tokenu.
     *
     * @return výjimka s HTTP 401 Unauthorized
     */
    public static AuthException deviceMismatch() {
        return new AuthException(
                AuthErrorCode.AUTH_DEVICE_MISMATCH,
                "Token nepatří tomuto zařízení.",
                HttpStatus.UNAUTHORIZED
        );
    }
}