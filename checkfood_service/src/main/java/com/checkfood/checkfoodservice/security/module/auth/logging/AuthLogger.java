package com.checkfood.checkfoodservice.security.module.auth.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro autentizační operace.
 * Dědí ze SecurityLogger a poskytuje sémantické metody pro logování
 * POUZE ÚSPĚŠNÝCH událostí (Happy Path).
 *
 * Chybové stavy a bezpečnostní incidenty jsou logovány v AuthExceptionHandler.
 *
 * @see SecurityLogger
 * @see com.checkfood.checkfoodservice.security.module.auth.exception.AuthExceptionHandler
 */
@Component
public class AuthLogger extends SecurityLogger {

    /**
     * Zaloguje úspěšné přihlášení uživatele.
     * Voláno po úspěšném ověření hesla a vygenerování tokenů.
     */
    public void logSuccessfulLogin(String email) {
        this.info("Uživatel '{}' se úspěšně přihlásil.", email);
    }

    /**
     * Zaloguje registraci nového uživatele.
     * Voláno po uložení entity do databáze.
     */
    public void logRegistration(String email) {
        this.info("Registrace nového uživatele '{}' proběhla úspěšně.", email);
    }

    /**
     * Zaloguje odeslání verifikačního emailu.
     */
    public void logVerificationEmailSent(String email) {
        this.info("Odesílám verifikační email na adresu '{}'.", email);
    }

    /**
     * Zaloguje úspěšnou aktivaci účtu.
     */
    public void logAccountActivated(String email) {
        this.info("Účet '{}' byl úspěšně aktivován a je připraven k použití.", email);
    }

    /**
     * Zaloguje žádost o opětovné zaslání verifikačního kódu.
     */
    public void logResendVerificationCode(String email) {
        this.info("Zasílám nový verifikační kód pro uživatele '{}'.", email);
    }

    /**
     * Zaloguje odhlášení uživatele.
     */
    public void logLogout(String email) {
        this.info("Uživatel '{}' se úspěšně odhlásil.", email);
    }

    /**
     * Zaloguje obnovení přístupového tokenu (Refresh).
     * Logujeme jako INFO, protože jde o významnou bezpečnostní událost (prodloužení session).
     */
    public void logTokenRefresh(String email) {
        this.info("Obnovení přístupového tokenu (Refresh) pro uživatele '{}'.", email);
    }
}