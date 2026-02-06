package com.checkfood.checkfoodservice.security.auth.service;

import com.checkfood.checkfoodservice.security.auth.dto.request.LoginRequest;
import com.checkfood.checkfoodservice.security.auth.dto.request.LogoutRequest;
import com.checkfood.checkfoodservice.security.auth.dto.request.RefreshRequest;
import com.checkfood.checkfoodservice.security.auth.dto.request.RegisterRequest;
import com.checkfood.checkfoodservice.security.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.auth.dto.response.TokenResponse;
import com.checkfood.checkfoodservice.security.auth.dto.response.UserResponse;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * Rozhraní pro autentizační službu.
 * Zajišťuje orchestraci mezi zabezpečením, správou uživatelů a evidencí zařízení.
 */
public interface AuthService {

    /**
     * Zaregistruje nového uživatele, přiřadí výchozí roli a inicializuje verifikační proces.
     * V této fázi se nevrací tokeny; uživatel musí nejprve aktivovat účet přes e-mail.
     */
    void register(RegisterRequest requestDto);

    /**
     * Aktivuje uživatelský účet na základě unikátního verifikačního tokenu.
     * Pokud je token platný, nastaví stav uživatele na 'enabled'.
     */
    void verifyAccount(String token);

    /**
     * Zneplatní stávající verifikační kód a vygeneruje nový.
     * Slouží pro případy expirace původního odkazu nebo ztráty e-mailu.
     */
    void resendVerificationCode(String email);

    /**
     * Ověří přihlašovací údaje, zaeviduje zařízení a vygeneruje přístupové tokeny (Access & Refresh).
     * Vyžaduje, aby byl účet již aktivován.
     */
    AuthResponse login(LoginRequest request);

    /**
     * Obnoví Access Token na základě platného Refresh Tokenu.
     * Implementuje strategii rotace tokenů pro eliminaci rizik spojených s odcizením JWT.
     */
    TokenResponse refreshToken(RefreshRequest request);

    /**
     * Provede bezpečné ukončení relace a odstraní záznam o zařízení z databáze.
     */
    void logout(LogoutRequest request);

    /**
     * Mapuje UserDetails ze Security kontextu na UserResponse pro potřeby frontendu.
     */
    UserResponse getCurrentUser(UserDetails userDetails);
}