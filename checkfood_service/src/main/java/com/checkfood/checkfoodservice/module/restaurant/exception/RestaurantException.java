package com.checkfood.checkfoodservice.module.restaurant.exception;

import com.checkfood.checkfoodservice.module.exception.AppException;
import org.springframework.http.HttpStatus;

import java.util.UUID;

/**
 * Specializovaná výjimka pro modul restaurací s továrními metodami pro typické chybové scénáře.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class RestaurantException extends AppException {

    /**
     * Vytvoří výjimku s daným kódem chyby, zprávou a HTTP statusem.
     *
     * @param errorCode kód chyby modulu restaurací
     * @param message   popis chyby
     * @param status    HTTP status odpovědi
     */
    public RestaurantException(RestaurantErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Výjimka pro případ, kdy restaurace s daným ID nebyla nalezena.
     *
     * @param id UUID nenalezené restaurace
     * @return výjimka s HTTP 404
     */
    public static RestaurantException notFound(UUID id) {
        return new RestaurantException(
                RestaurantErrorCode.RESTAURANT_NOT_FOUND,
                "Restaurace s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    public static RestaurantException tableNotFound(UUID id) {
        return new RestaurantException(
                RestaurantErrorCode.TABLE_NOT_FOUND,
                "Stůl s ID " + id + " nebyl nalezen.",
                HttpStatus.NOT_FOUND
        );
    }

    public static RestaurantException tableOccupied(String label) {
        return new RestaurantException(
                RestaurantErrorCode.TABLE_OCCUPIED,
                "Stůl '" + label + "' je již obsazen jinou skupinou.",
                HttpStatus.CONFLICT
        );
    }

    public static RestaurantException accessDenied() {
        return new RestaurantException(
                RestaurantErrorCode.RESTAURANT_ACCESS_DENIED,
                "Nemáte oprávnění ke správě této restaurace.",
                HttpStatus.FORBIDDEN
        );
    }

    public static RestaurantException permissionDenied(String permission) {
        return new RestaurantException(
                RestaurantErrorCode.EMPLOYEE_PERMISSION_DENIED,
                "Nemáte oprávnění: " + permission,
                HttpStatus.FORBIDDEN
        );
    }

    public static RestaurantException employeeNotFound(Long id) {
        return new RestaurantException(
                RestaurantErrorCode.EMPLOYEE_NOT_FOUND,
                "Zaměstnanec s ID " + id + " nebyl nalezen.",
                HttpStatus.NOT_FOUND
        );
    }

    public static RestaurantException employeeAlreadyExists(String email) {
        return new RestaurantException(
                RestaurantErrorCode.EMPLOYEE_ALREADY_EXISTS,
                "Uživatel s emailem " + email + " je již zaměstnancem této restaurace.",
                HttpStatus.CONFLICT
        );
    }

    public static RestaurantException employeeValidationError(String message) {
        return new RestaurantException(
                RestaurantErrorCode.EMPLOYEE_VALIDATION_ERROR,
                message,
                HttpStatus.BAD_REQUEST
        );
    }

    public static RestaurantException validationError(String message) {
        return new RestaurantException(
                RestaurantErrorCode.RESTAURANT_VALIDATION_ERROR,
                message,
                HttpStatus.BAD_REQUEST
        );
    }

    public static RestaurantException noRestaurantAssigned() {
        return new RestaurantException(
                RestaurantErrorCode.NO_RESTAURANT_ASSIGNED,
                "Nemáte přiřazenou žádnou restauraci.",
                HttpStatus.NOT_FOUND
        );
    }

    public static RestaurantException systemError(String message) {
        return new RestaurantException(
                RestaurantErrorCode.RESTAURANT_SYSTEM_ERROR,
                "Interní chyba modulu restaurací: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }
}