package com.checkfood.checkfoodservice.security.module.user.exception;

import com.checkfood.checkfoodservice.security.exception.SecurityException;
import org.springframework.http.HttpStatus;

/**
 * Výjimka pro modul User.
 * Poskytuje tovární metody pro chyby správy uživatelů.
 */
public class UserException extends SecurityException {

    public UserException(UserErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    public UserException(UserErrorCode errorCode, String message, HttpStatus status, Throwable cause) {
        super(errorCode, message, status, cause);
    }

// --- ROLE NOT FOUND ---

    public static UserException roleNotFound(String roleName) {
        return new UserException(
                UserErrorCode.ROLE_NOT_FOUND,
                "Role nenalezena: " + roleName,
                HttpStatus.NOT_FOUND
        );
    }

    public static UserException roleNotFoundById(Long id) {
        return new UserException(
                UserErrorCode.ROLE_NOT_FOUND,
                "Role s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    // --- NOT FOUND ---

    public static UserException userNotFound(String identifier) {
        return new UserException(
                UserErrorCode.USER_NOT_FOUND,
                "Uživatel nenalezen: " + identifier,
                HttpStatus.NOT_FOUND
        );
    }

    public static UserException userNotFoundById(Long id) {
        return new UserException(
                UserErrorCode.USER_NOT_FOUND,
                "Uživatel s ID " + id + " nebyl nalezen.",
                HttpStatus.NOT_FOUND
        );
    }

    public static UserException userWithDetailsNotFound(String email) {
        return new UserException(
                UserErrorCode.USER_NOT_FOUND,
                "Uživatel '" + email + "' nebyl nalezen (nebo se nepodařilo načíst detaily).",
                HttpStatus.NOT_FOUND
        );
    }

    public static UserException userWithRolesNotFound(String email) {
        return new UserException(
                UserErrorCode.USER_NOT_FOUND,
                "Uživatel '" + email + "' nebyl nalezen (nebo se nepodařilo načíst role).",
                HttpStatus.NOT_FOUND
        );
    }

    // --- SECURITY ---

    public static UserException accessDenied() {
        return new UserException(
                UserErrorCode.USER_ACCESS_DENIED,
                "Nemáte oprávnění k přístupu k těmto datům.",
                HttpStatus.FORBIDDEN
        );
    }

    public static UserException insufficientPermissions(String operation) {
        return new UserException(
                UserErrorCode.USER_INSUFFICIENT_PERMISSIONS,
                "Nedostatečná oprávnění pro operaci: " + operation,
                HttpStatus.FORBIDDEN
        );
    }

    // --- CONFLICTS & VALIDATION ---

    public static UserException emailExists(String email) {
        return new UserException(
                UserErrorCode.USER_EMAIL_EXISTS,
                "Email '" + email + "' je již používán jiným uživatelem.",
                HttpStatus.CONFLICT
        );
    }

    public static UserException invalidOperation(String message) {
        return new UserException(
                UserErrorCode.USER_INVALID_OPERATION,
                message,
                HttpStatus.BAD_REQUEST
        );
    }

    // --- SYSTEM ---

    public static UserException systemError(String message, Throwable cause) {
        return new UserException(
                UserErrorCode.USER_SYSTEM_ERROR,
                "Chyba systému uživatelů: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR,
                cause
        );
    }
}