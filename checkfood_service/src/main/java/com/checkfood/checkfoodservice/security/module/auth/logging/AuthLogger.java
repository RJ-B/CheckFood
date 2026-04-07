package com.checkfood.checkfoodservice.security.module.auth.logging;

import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import org.springframework.stereotype.Component;

/**
 * Specializovaný logger pro autentizační operace (happy path).
 * Chybové stavy a bezpečnostní incidenty jsou logovány v {@code AuthExceptionHandler}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see SecurityLogger
 * @see com.checkfood.checkfoodservice.security.module.auth.exception.AuthExceptionHandler
 */
@Component
public class AuthLogger extends SecurityLogger {

    /**
     * Zaloguje úspěšné přihlášení uživatele.
     *
     * @param email email přihlášeného uživatele
     */
    public void logSuccessfulLogin(String email) {
        this.info("Uživatel '{}' se úspěšně přihlásil.", email);
    }

    /**
     * Zaloguje registraci nového uživatele.
     *
     * @param email email registrovaného uživatele
     */
    public void logRegistration(String email) {
        this.info("Registrace nového uživatele '{}' proběhla úspěšně.", email);
    }

    /**
     * Zaloguje odeslání verifikačního emailu.
     *
     * @param email cílová emailová adresa
     */
    public void logVerificationEmailSent(String email) {
        this.info("Odesílám verifikační email na adresu '{}'.", email);
    }

    /**
     * Zaloguje úspěšnou aktivaci účtu.
     *
     * @param email email aktivovaného uživatele
     */
    public void logAccountActivated(String email) {
        this.info("Účet '{}' byl úspěšně aktivován a je připraven k použití.", email);
    }

    /**
     * Zaloguje žádost o opětovné zaslání verifikačního kódu.
     *
     * @param email email uživatele, jemuž se zasílá nový kód
     */
    public void logResendVerificationCode(String email) {
        this.info("Zasílám nový verifikační kód pro uživatele '{}'.", email);
    }

    /**
     * Zaloguje odhlášení uživatele.
     *
     * @param email email odhlášeného uživatele
     */
    public void logLogout(String email) {
        this.info("Uživatel '{}' se úspěšně odhlásil.", email);
    }

    /**
     * Zaloguje obnovení přístupového tokenu.
     *
     * @param email email uživatele, jehož token byl obnoven
     */
    public void logTokenRefresh(String email) {
        this.info("Obnovení přístupového tokenu (Refresh) pro uživatele '{}'.", email);
    }

    /**
     * Zaloguje žádost o obnovu hesla.
     *
     * @param email email uživatele, který žádá o reset hesla
     */
    public void logPasswordResetRequested(String email) {
        this.info("Žádost o obnovu hesla pro uživatele '{}'.", email);
    }

    /**
     * Zaloguje úspěšný reset hesla.
     *
     * @param email email uživatele, jehož heslo bylo resetováno
     */
    public void logPasswordResetCompleted(String email) {
        this.info("Heslo uživatele '{}' bylo úspěšně změněno přes reset odkaz.", email);
    }
}