package com.checkfood.checkfoodservice.security.module.user.exception;

import com.checkfood.checkfoodservice.security.exception.SecurityException;
import org.springframework.http.HttpStatus;

/**
 * Výjimka pro user modul.
 * Poskytuje tovární metody pro nejčastější user chyby s přednastavenými HTTP stavy a error kódy.
 *
 * @see SecurityException
 * @see UserErrorCode
 */
public class UserException extends SecurityException {

    /**
     * Vytvoří novou user výjimku.
     *
     * @param errorCode user error kód
     * @param message lidsky čitelná chybová zpráva
     * @param status HTTP status kód odpovědi
     */
    public UserException(UserErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Uživatel nebyl nalezen v systému.
     *
     * @param email email nenalezeného uživatele
     * @return výjimka s HTTP 404 Not Found
     */
    public static UserException userNotFound(String email) {
        return new UserException(
                UserErrorCode.USER_NOT_FOUND,
                "Uživatel s emailem " + email + " nebyl nalezen.",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Uživatel s daným ID nebyl nalezen.
     *
     * @param userId ID nenalezeného uživatele
     * @return výjimka s HTTP 404 Not Found
     */
    public static UserException userNotFoundById(Long userId) {
        return new UserException(
                UserErrorCode.USER_NOT_FOUND,
                "Uživatel s ID " + userId + " nebyl nalezen.",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Role nebyla nalezena v systému.
     *
     * @param roleName název nenalezené role
     * @return výjimka s HTTP 404 Not Found
     */
    public static UserException roleNotFound(String roleName) {
        return new UserException(
                UserErrorCode.ROLE_NOT_FOUND,
                "Role " + roleName + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Pokus o přístup k datům jiného uživatele.
     *
     * @return výjimka s HTTP 403 Forbidden
     */
    public static UserException accessDenied() {
        return new UserException(
                UserErrorCode.USER_ACCESS_DENIED,
                "Nemáte oprávnění k přístupu k datům tohoto uživatele.",
                HttpStatus.FORBIDDEN
        );
    }

    /**
     * Email je již používán jiným uživatelem.
     *
     * @param email duplicitní email
     * @return výjimka s HTTP 409 Conflict
     */
    public static UserException emailExists(String email) {
        return new UserException(
                UserErrorCode.USER_EMAIL_EXISTS,
                "Email " + email + " je již používán.",
                HttpStatus.CONFLICT
        );
    }

    /**
     * Neplatná operace nad uživatelským účtem.
     *
     * @param message popis neplatné operace
     * @return výjimka s HTTP 400 Bad Request
     */
    public static UserException invalidOperation(String message) {
        return new UserException(
                UserErrorCode.USER_INVALID_OPERATION,
                message,
                HttpStatus.BAD_REQUEST
        );
    }
}