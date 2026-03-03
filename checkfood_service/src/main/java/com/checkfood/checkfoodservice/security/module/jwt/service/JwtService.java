package com.checkfood.checkfoodservice.security.module.jwt.service;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.jwt.exception.JwtException;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;

/**
 * Service interface pro správu JWT tokenů.
 * Poskytuje metody pro generování, validaci, extrakci dat a rotaci tokenů (refresh).
 *
 * Design Note:
 * Implementace by měla vyhazovat runtime výjimku {@link JwtException} v případě
 * neplatných tokenů nebo chyb při zpracování, nikoliv vracet null.
 */
public interface JwtService {

    /**
     * Vygeneruje nový access token pro uživatele a konkrétní zařízení.
     *
     * @param user               uživatel, pro kterého se generuje token
     * @param deviceIdentifier   unikátní řetězec identifikující zařízení (např. UUID)
     * @return zakódovaný JWT access token
     * @throws JwtException při chybě generování (např. kryptografická chyba)
     */
    String generateAccessToken(UserEntity user, String deviceIdentifier);

    /**
     * Vygeneruje nový refresh token pro uživatele a konkrétní zařízení.
     *
     * @param user               uživatel, pro kterého se generuje token
     * @param deviceIdentifier   unikátní řetězec identifikující zařízení
     * @return zakódovaný JWT refresh token
     * @throws JwtException při chybě generování
     */
    String generateRefreshToken(UserEntity user, String deviceIdentifier);

    /**
     * Extrahuje email (subject) z JWT tokenu.
     *
     * @param token JWT token
     * @return email uživatele
     * @throws JwtException pokud je token neplatný nebo nelze email přečíst
     */
    String extractEmail(String token);

    /**
     * Extrahuje unikátní identifikátor zařízení (deviceIdentifier claim) z JWT tokenu.
     *
     * @param token JWT token
     * @return identifikátor zařízení (String) nebo null, pokud claim v tokenu chybí (u starších tokenů)
     * @throws JwtException pokud je formát tokenu neplatný
     */
    String extractDeviceIdentifier(String token);

    /**
     * Validuje strukturu a podpis JWT tokenu (bez kontextu uživatele).
     *
     * @param token JWT token k validaci
     * @return true pokud je token technicky platný (podpis, expirace), jinak false
     */
    boolean validateToken(String token);

    /**
     * Kompletní validace tokenu vůči konkrétnímu uživateli.
     * Kontroluje podpis, expiraci, shodu emailu a typ tokenu (musí být ACCESS).
     *
     * @param token JWT token k validaci
     * @param user  uživatel, vůči kterému se token validuje
     * @return true pokud je token validní a patří uživateli, jinak false
     */
    boolean isTokenValid(String token, UserEntity user);

    /**
     * Vrací nakonfigurovanou dobu platnosti access tokenu v sekundách.
     * Slouží pro informování klienta (expires_in).
     *
     * @return doba platnosti v sekundách
     */
    Long getAccessTokenExpirationSeconds();

    /**
     * Obnoví access a refresh tokeny pomocí platného refresh tokenu.
     * Provádí validaci typu tokenu, expirace, existence uživatele a stavu účtu.
     *
     * @param refreshToken platný refresh token
     * @return nová autentizační odpověď s novou sadou tokenů (rotace)
     * @throws JwtException pokud je token neplatný, expirovaný, nebo uživatel neexistuje
     */
    AuthResponse refreshTokens(String refreshToken);

    /**
     * Ověří, zda je daný token typu REFRESH token.
     * Kontroluje claim "type".
     *
     * @param token JWT token k ověření
     * @return true pokud se jedná o refresh token, jinak false
     */
    boolean isRefreshToken(String token);
}