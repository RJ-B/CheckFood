package com.checkfood.checkfoodservice.security.module.user.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro user operace.
 * Poskytuje metody pro logování událostí specifických pro správu uživatelů a jejich dat.
 *
 * @see SecurityLogger
 */
@Component
@RequiredArgsConstructor
public class UserLogger {

    private final SecurityLogger securityLogger;

    /**
     * Loguje načtení uživatele z databáze.
     *
     * @param email email načteného uživatele
     */
    public void logUserLoaded(String email) {
        securityLogger.debug("Načten uživatel: {}", email);
    }

    /**
     * Loguje vytvoření nového uživatele.
     *
     * @param email email vytvořeného uživatele
     */
    public void logUserCreated(String email) {
        securityLogger.info("Vytvořen nový uživatel: {}", email);
    }

    /**
     * Loguje aktualizaci uživatelských dat.
     *
     * @param email email aktualizovaného uživatele
     */
    public void logUserUpdated(String email) {
        securityLogger.info("Aktualizován uživatel: {}", email);
    }

    /**
     * Loguje smazání uživatele.
     *
     * @param email email smazaného uživatele
     */
    public void logUserDeleted(String email) {
        securityLogger.info("Smazán uživatel: {}", email);
    }

    /**
     * Loguje nenalezení uživatele.
     *
     * @param email email hledaného uživatele
     */
    public void logUserNotFound(String email) {
        securityLogger.warn("Uživatel {} nebyl nalezen", email);
    }

    /**
     * Loguje pokus o přístup k datům jiného uživatele.
     *
     * @param attemptingUser email uživatele, který se pokouší o přístup
     * @param targetUser email cílového uživatele
     */
    public void logUnauthorizedAccess(String attemptingUser, String targetUser) {
        securityLogger.warn("Uživatel {} se pokusil o přístup k datům uživatele {}", attemptingUser, targetUser);
    }

    /**
     * Loguje chybu při práci s uživateli.
     *
     * @param message popis chyby
     */
    public void logUserError(String message) {
        securityLogger.error("Chyba při práci s uživatelem: {}", message);
    }

    /**
     * Loguje změnu hesla uživatele.
     *
     * @param email email uživatele
     */
    public void logPasswordChanged(String email) {
        securityLogger.info("Změněno heslo pro uživatele: {}", email);
    }

    /**
     * Loguje změnu emailu uživatele.
     *
     * @param oldEmail původní email
     * @param newEmail nový email
     */
    public void logEmailChanged(String oldEmail, String newEmail) {
        securityLogger.info("Změněn email z {} na {}", oldEmail, newEmail);
    }

    /**
     * Loguje debug zprávu o user operaci.
     *
     * @param message debug zpráva
     * @param args argumenty pro formátování zprávy
     */
    public void debug(String message, Object... args) {
        securityLogger.debug(message, args);
    }
}