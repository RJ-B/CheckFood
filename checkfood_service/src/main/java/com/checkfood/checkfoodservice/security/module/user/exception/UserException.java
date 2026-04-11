package com.checkfood.checkfoodservice.security.module.user.exception;

import com.checkfood.checkfoodservice.security.exception.SecurityException;
import org.springframework.http.HttpStatus;

/**
 * Výjimka pro User modul poskytující tovární metody pro typické chybové scénáře správy uživatelů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class UserException extends SecurityException {

    /**
     * Vytvoří výjimku s chybovým kódem, zprávou a HTTP stavem.
     *
     * @param errorCode kód chyby User modulu
     * @param message   popis chyby pro klienta
     * @param status    HTTP stav odpovědi
     */
    public UserException(UserErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Vytvoří výjimku se všemi parametry včetně příčiny.
     *
     * @param errorCode kód chyby User modulu
     * @param message   popis chyby pro klienta
     * @param status    HTTP stav odpovědi
     * @param cause     původní výjimka
     */
    public UserException(UserErrorCode errorCode, String message, HttpStatus status, Throwable cause) {
        super(errorCode, message, status, cause);
    }

    /**
     * Vytvoří výjimku pro případ, kdy role s daným názvem nebyla nalezena.
     *
     * @param roleName název role
     * @return nová instance výjimky
     */
    public static UserException roleNotFound(String roleName) {
        return new UserException(
                UserErrorCode.ROLE_NOT_FOUND,
                "Role nenalezena: " + roleName,
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Vytvoří výjimku pro případ, kdy role s daným ID nebyla nalezena.
     *
     * @param id ID role
     * @return nová instance výjimky
     */
    public static UserException roleNotFoundById(Long id) {
        return new UserException(
                UserErrorCode.ROLE_NOT_FOUND,
                "Role s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Vytvoří výjimku pro případ, kdy uživatel s daným identifikátorem nebyl nalezen.
     *
     * @param identifier e-mail nebo jiný identifikátor uživatele
     * @return nová instance výjimky
     */
    public static UserException userNotFound(String identifier) {
        return new UserException(
                UserErrorCode.USER_NOT_FOUND,
                "Uživatel nenalezen: " + identifier,
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Vytvoří výjimku pro případ, kdy uživatel s daným ID nebyl nalezen.
     *
     * @param id ID uživatele
     * @return nová instance výjimky
     */
    public static UserException userNotFoundById(Long id) {
        return new UserException(
                UserErrorCode.USER_NOT_FOUND,
                "Uživatel s ID " + id + " nebyl nalezen.",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Vytvoří výjimku pro případ selhání načtení uživatele včetně detailů.
     *
     * @param email e-mailová adresa uživatele
     * @return nová instance výjimky
     */
    public static UserException userWithDetailsNotFound(String email) {
        return new UserException(
                UserErrorCode.USER_NOT_FOUND,
                "Uživatel '" + email + "' nebyl nalezen (nebo se nepodařilo načíst detaily).",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Vytvoří výjimku pro případ selhání načtení uživatele včetně rolí.
     *
     * @param email e-mailová adresa uživatele
     * @return nová instance výjimky
     */
    public static UserException userWithRolesNotFound(String email) {
        return new UserException(
                UserErrorCode.USER_NOT_FOUND,
                "Uživatel '" + email + "' nebyl nalezen (nebo se nepodařilo načíst role).",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Vytvoří výjimku pro zamítnutý přístup k chráněným datům.
     *
     * @return nová instance výjimky
     */
    public static UserException accessDenied() {
        return new UserException(
                UserErrorCode.USER_ACCESS_DENIED,
                "Nemáte oprávnění k přístupu k těmto datům.",
                HttpStatus.FORBIDDEN
        );
    }

    /**
     * Vytvoří výjimku pro nedostatečná oprávnění k provedení operace.
     *
     * @param operation název operace, ke které uživatel nemá oprávnění
     * @return nová instance výjimky
     */
    public static UserException insufficientPermissions(String operation) {
        return new UserException(
                UserErrorCode.USER_INSUFFICIENT_PERMISSIONS,
                "Nedostatečná oprávnění pro operaci: " + operation,
                HttpStatus.FORBIDDEN
        );
    }

    /**
     * Vytvoří výjimku pro případ, kdy je e-mail již registrován jiným uživatelem.
     *
     * @param email e-mailová adresa způsobující konflikt
     * @return nová instance výjimky
     */
    public static UserException emailExists(String email) {
        return new UserException(
                UserErrorCode.USER_EMAIL_EXISTS,
                "Email '" + email + "' je již používán jiným uživatelem.",
                HttpStatus.CONFLICT
        );
    }

    /**
     * Vytvoří výjimku pro neplatnou operaci nebo vstupní data.
     *
     * @param message popis konkrétního problému
     * @return nová instance výjimky
     */
    public static UserException invalidOperation(String message) {
        return new UserException(
                UserErrorCode.USER_INVALID_OPERATION,
                message,
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Vytvoří výjimku pro porušení business pravidla — request je validně
     * zformovaný, ale aktuální stav serveru ho odmítá (např. pokus smazat
     * právě používané zařízení). Mapuje se na HTTP 409 Conflict, což je
     * správný status pro state-machine konflikty (RFC 9110 §15.5.10).
     *
     * @param message popis konkrétního konfliktu
     * @return nová instance výjimky
     */
    public static UserException conflict(String message) {
        return new UserException(
                UserErrorCode.USER_INVALID_OPERATION,
                message,
                HttpStatus.CONFLICT
        );
    }

    /**
     * Vytvoří výjimku pro systémovou nebo databázovou chybu.
     *
     * @param message popis systémové chyby
     * @param cause   původní výjimka
     * @return nová instance výjimky
     */
    public static UserException systemError(String message, Throwable cause) {
        return new UserException(
                UserErrorCode.USER_SYSTEM_ERROR,
                "Chyba systému uživatelů: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR,
                cause
        );
    }
}