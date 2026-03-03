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
}