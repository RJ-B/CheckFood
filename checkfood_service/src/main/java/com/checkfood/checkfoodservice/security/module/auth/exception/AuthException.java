package com.checkfood.checkfoodservice.security.module.auth.exception;

import com.checkfood.checkfoodservice.security.exception.SecurityException;
import org.springframework.http.HttpStatus;

/**
 * Specializovaná výjimka pro autentizační modul poskytující factory metody
 * pro vytváření specifických auth error scenarios.
 *
 * Implementuje factory pattern pro konzistentní error handling napříč
 * autentizačním modulem. Každá factory metoda kombinuje AuthErrorCode
 * s appropriate HTTP status a user-friendly message.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see SecurityException
 * @see AuthErrorCode
 */
public class AuthException extends SecurityException {

    /**
     * Vytvoří novou autentizační výjimku s typed error code.
     *
     * @param errorCode AuthErrorCode pro category a severity determination
     * @param message user-friendly chybová zpráva
     * @param status HTTP status kód pro REST response
     */
    public AuthException(AuthErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    // =========================================================================
    // CREDENTIALS & LOGIN FACTORY METHODS
    // =========================================================================

    /**
     * Invalid login credentials - generic message pro user enumeration prevention.
     */
    public static AuthException invalidCredentials() {
        return new AuthException(
                AuthErrorCode.AUTH_INVALID_CREDENTIALS,
                "Neplatný email nebo heslo.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Rate limiting exceeded - brute force protection triggered.
     */
    public static AuthException tooManyAttempts() {
        return new AuthException(
                AuthErrorCode.AUTH_TOO_MANY_ATTEMPTS,
                "Překročen limit pokusů o přihlášení. Zkuste to prosím později.",
                HttpStatus.TOO_MANY_REQUESTS
        );
    }

    /**
     * Authorization failure - user lacks required permissions.
     */
    public static AuthException insufficientPrivileges() {
        return new AuthException(
                AuthErrorCode.AUTH_INSUFFICIENT_PRIVILEGES,
                "Nemáte oprávnění k provedení této akce.",
                HttpStatus.FORBIDDEN
        );
    }

    // =========================================================================
    // ACCOUNT STATUS FACTORY METHODS
    // =========================================================================

    /**
     * Account disabled by administrator - contact support required.
     */
    public static AuthException accountDisabled() {
        return new AuthException(
                AuthErrorCode.AUTH_ACCOUNT_DISABLED,
                "Váš účet byl deaktivován. Kontaktujte prosím podporu.",
                HttpStatus.FORBIDDEN
        );
    }

    /**
     * Account locked due to security policy - too many failed attempts.
     */
    public static AuthException accountLocked() {
        return new AuthException(
                AuthErrorCode.AUTH_ACCOUNT_LOCKED,
                "Váš účet byl uzamčen z bezpečnostních důvodů (příliš mnoho pokusů).",
                HttpStatus.LOCKED
        );
    }

    /**
     * Account requires email verification before login.
     */
    public static AuthException accountNotVerified() {
        return new AuthException(
                AuthErrorCode.AUTH_ACCOUNT_NOT_VERIFIED,
                "Účet není aktivní. Zkontrolujte prosím svůj e-mail a potvrďte registraci.",
                HttpStatus.FORBIDDEN
        );
    }

    /**
     * Account activation attempted on already active account.
     */
    public static AuthException accountAlreadyActivated() {
        return new AuthException(
                AuthErrorCode.AUTH_ACCOUNT_ALREADY_ACTIVATED,
                "Účet je již aktivován. Můžete se přihlásit.",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Email address already registered - duplicate registration attempt.
     */
    public static AuthException emailExists() {
        return new AuthException(
                AuthErrorCode.AUTH_EMAIL_EXISTS,
                "Uživatel s tímto emailem již existuje.",
                HttpStatus.CONFLICT
        );
    }

    // =========================================================================
    // TOKEN MANAGEMENT FACTORY METHODS
    // =========================================================================

    /**
     * JWT nebo auth token je invalid nebo compromised.
     */
    public static AuthException invalidToken() {
        return new AuthException(
                AuthErrorCode.AUTH_INVALID_TOKEN,
                "Neplatný nebo podvržený autentizační token.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Session nebo JWT token expiroval - re-authentication required.
     */
    public static AuthException sessionExpired() {
        return new AuthException(
                AuthErrorCode.AUTH_SESSION_EXPIRED,
                "Vaše session vypršela. Přihlaste se prosím znovu.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Token-device binding mismatch - potential token theft.
     */
    public static AuthException deviceMismatch() {
        return new AuthException(
                AuthErrorCode.AUTH_DEVICE_MISMATCH,
                "Token nepatří tomuto zařízení. Z bezpečnostních důvodů se přihlaste znovu.",
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Password reset token neexistuje nebo je invalid.
     */
    public static AuthException invalidResetToken() {
        return new AuthException(
                AuthErrorCode.AUTH_RESET_TOKEN_INVALID,
                "Neplatný nebo neexistující odkaz pro obnovu hesla.",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Password reset token vypršel.
     */
    public static AuthException resetTokenExpired() {
        return new AuthException(
                AuthErrorCode.AUTH_RESET_TOKEN_EXPIRED,
                "Odkaz pro obnovu hesla vypršel. Požádejte o nový.",
                HttpStatus.GONE
        );
    }

    /**
     * Password reset token byl již použit.
     */
    public static AuthException resetTokenAlreadyUsed() {
        return new AuthException(
                AuthErrorCode.AUTH_RESET_TOKEN_USED,
                "Tento odkaz pro obnovu hesla byl již použit.",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Email verification token neexistuje nebo je invalid.
     */
    public static AuthException invalidVerificationToken() {
        return new AuthException(
                AuthErrorCode.AUTH_INVALID_TOKEN,
                "Neplatný nebo neexistující verifikační token.",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Email verification token vypršel - request new verification.
     */
    public static AuthException verificationTokenExpired() {
        return new AuthException(
                AuthErrorCode.AUTH_TOKEN_EXPIRED,
                "Verifikační token vypršel. Požádejte o nový.",
                HttpStatus.GONE
        );
    }

    // =========================================================================
    // VALIDATION FACTORY METHODS
    // =========================================================================

    /**
     * Password confirmation mismatch during registration.
     */
    public static AuthException passwordMismatch() {
        return new AuthException(
                AuthErrorCode.AUTH_PASSWORD_MISMATCH,
                "Hesla se neshodují.",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Password doesn't meet security requirements.
     */
    public static AuthException weakPassword() {
        return new AuthException(
                AuthErrorCode.AUTH_WEAK_PASSWORD,
                "Heslo nesplňuje bezpečnostní požadavky (délka, znaky).",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Email format validation failure.
     */
    public static AuthException invalidEmailFormat() {
        return new AuthException(
                AuthErrorCode.AUTH_INVALID_EMAIL_FORMAT,
                "Neplatný formát emailové adresy.",
                HttpStatus.BAD_REQUEST
        );
    }

    // =========================================================================
    // SYSTEM ERROR FACTORY METHODS
    // =========================================================================

    /**
     * Required system role missing - configuration error.
     */
    public static AuthException roleNotFound(String roleName) {
        return new AuthException(
                AuthErrorCode.AUTH_ROLE_NOT_FOUND,
                "Kritická chyba konfigurace: Role '" + roleName + "' nebyla nalezena.",
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    /**
     * Generic internal auth system error.
     */
    public static AuthException internalError(String message) {
        return new AuthException(
                AuthErrorCode.AUTH_SYSTEM_ERROR,
                "Interní chyba autentizace: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    /**
     * Registration process failed due to system error.
     */
    public static AuthException registrationFailed(String message) {
        return new AuthException(
                AuthErrorCode.AUTH_REGISTRATION_FAILED,
                "Registrace selhala: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }
}