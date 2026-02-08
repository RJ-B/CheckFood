package com.checkfood.checkfoodservice.security.module.auth.email;

import com.checkfood.checkfoodservice.security.module.auth.exception.AuthException;

/**
 * Service interface pro odesílání emailů.
 * Poskytuje metody pro zasílání různých typů emailů uživatelům systému.
 */
public interface EmailService {

    /**
     * Asynchronně odešle verifikační email s aktivačním odkazem.
     * Email obsahuje HTML formátovanou zprávu s tlačítkem pro aktivaci účtu.
     * Odkaz je platný 24 hodin.
     *
     * @param to emailová adresa příjemce
     * @param token verifikační token pro sestavení aktivačního odkazu
     * @throws AuthException při chybě odesílání emailu
     */
    void sendVerificationEmail(String to, String token);
}