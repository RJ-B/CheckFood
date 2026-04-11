package com.checkfood.checkfoodservice.security.module.auth.email;

import com.checkfood.checkfoodservice.security.module.auth.exception.AuthException;

/**
 * Service interface pro email operations v autentizačním modulu.
 *
 * Poskytuje abstraction nad email provider pro pluggable implementations
 * (SMTP, cloud email services, testing mocks). Všechny operace jsou
 * designed jako asynchronní pro performance optimization.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuthException
 */
public interface EmailService {

    /**
     * Asynchronně odešle verifikační email s aktivačním odkazem.
     *
     * Email obsahuje HTML template s branded design a security features
     * (24-hour expiration, single-use link). Deep link integration
     * pro mobile app redirect po successful verification.
     *
     * @param to recipient email address
     * @param token verification token pro activation URL construction
     * @throws AuthException při email delivery failures
     */
    void sendVerificationEmail(String to, String token);

    /**
     * Asynchronně odešle email s odkazem pro obnovu hesla.
     *
     * @param to email adresa příjemce
     * @param token reset token pro URL construction
     * @throws AuthException při email delivery failures
     */
    void sendPasswordResetEmail(String to, String token);

    /**
     * Asynchronně odešle upozornění na opakovaný pokus o registraci s již
     * existujícím emailem. Používá se v OWASP-compliant registration flow
     * kde server vrací 202 bez ohledu na to, zda email existuje nebo ne,
     * aby nebylo možné enumerovat uživatele přes HTTP status code.
     *
     * <p>Obsah emailu sděluje uživateli, že někdo použil jeho e-mail
     * v registraci, a pokud to nebyl on, může tuto zprávu ignorovat. Pokud
     * zapomněl, že má účet, dostane odkaz na password reset.
     *
     * @param to email adresa existujícího účtu
     */
    void sendAccountExistsNotification(String to);
}