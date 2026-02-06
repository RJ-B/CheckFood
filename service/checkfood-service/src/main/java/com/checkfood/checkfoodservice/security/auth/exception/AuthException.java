package com.checkfood.checkfoodservice.security.auth.exception;

import com.checkfood.checkfoodservice.security.handler.ErrorCode;
import lombok.Getter;
import org.springframework.http.HttpStatus;

/**
 * Sjednocená výjimka pro autentizační modul.
 * Spolupracuje s GlobalSecurityExceptionHandlerem pro vrácení standardizované ErrorResponse.
 */
@Getter
public class AuthException extends RuntimeException {

    private final ErrorCode errorCode;
    private final HttpStatus status;

    public AuthException(ErrorCode errorCode, String message, HttpStatus status) {
        super(message);
        this.errorCode = errorCode;
        this.status = status;
    }

    // --- Tovární metody pro nejčastější případy v AuthService ---

    public static AuthException invalidCredentials() {
        return new AuthException(
                ErrorCode.AUTH_INVALID_CREDENTIALS,
                "Neplatný email nebo heslo.",
                HttpStatus.UNAUTHORIZED
        );
    }

    public static AuthException emailExists() {
        return new AuthException(
                ErrorCode.VALIDATION_ERROR,
                "Uživatel s tímto emailem již existuje.",
                HttpStatus.CONFLICT
        );
    }

    public static AuthException accountDisabled() {
        return new AuthException(
                ErrorCode.AUTH_ACCOUNT_DISABLED,
                "Váš účet byl deaktivován. Kontaktujte prosím podporu.",
                HttpStatus.FORBIDDEN
        );
    }

    public static AuthException accountLocked() {
        return new AuthException(
                ErrorCode.AUTH_ACCOUNT_LOCKED,
                "Váš účet byl uzamčen z bezpečnostních důvodů.",
                HttpStatus.LOCKED
        );
    }

    public static AuthException sessionExpired() {
        return new AuthException(
                ErrorCode.REFRESH_INVALID,
                "Vaše relace vypršela nebo byla ukončena. Přihlaste se prosím znovu.",
                HttpStatus.UNAUTHORIZED
        );
    }

    // --- Nové metody pro Email Verification ---

    public static AuthException invalidVerificationToken() {
        return new AuthException(
                ErrorCode.AUTH_TOKEN_INVALID,
                "Neplatný nebo neexistující verifikační token.",
                HttpStatus.BAD_REQUEST
        );
    }

    public static AuthException verificationTokenExpired() {
        return new AuthException(
                ErrorCode.AUTH_TOKEN_EXPIRED,
                "Verifikační token vypršel. Požádejte o nový.",
                HttpStatus.GONE // 410 Gone je pro expirované zdroje ideální, nebo 400
        );
    }

    public static AuthException accountNotVerified() {
        return new AuthException(
                ErrorCode.AUTH_ACCOUNT_NOT_VERIFIED,
                "Účet není aktivní. Zkontrolujte prosím svůj e-mail a potvrďte registraci.",
                HttpStatus.FORBIDDEN
        );
    }

    public static AuthException internalError(String message) {
        return new AuthException(
                ErrorCode.INTERNAL_SERVER_ERROR, // Předpokládám, že tento kód v ErrorCode máš
                message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }
}