package com.checkfood.checkfoodservice.security.module.jwt.service;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.jwt.exception.JwtException;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;

/**
 * Service interface pro správu JWT tokenů.
 * Poskytuje metody pro generování, validaci a refresh access i refresh tokenů.
 */
public interface JwtService {

    /**
     * Vygeneruje nový access token pro uživatele.
     *
     * @param user uživatel, pro kterého se generuje token
     * @return zakódovaný JWT access token
     */
    String generateAccessToken(UserEntity user);

    /**
     * Vygeneruje nový refresh token pro uživatele.
     *
     * @param user uživatel, pro kterého se generuje token
     * @return zakódovaný JWT refresh token
     */
    String generateRefreshToken(UserEntity user);

    /**
     * Extrahuje email (subject) z JWT tokenu.
     *
     * @param token JWT token
     * @return email uživatele nebo null při chybě
     */
    String extractEmail(String token);

    /**
     * Validuje JWT token bez kontextu uživatele.
     *
     * @param token JWT token k validaci
     * @return true pokud je token technicky platný, jinak false
     */
    boolean validateToken(String token);

    /**
     * Validuje JWT token vůči konkrétnímu uživateli.
     *
     * @param token JWT token k validaci
     * @param user uživatel, vůči kterému se token validuje
     * @return true pokud je token platný pro daného uživatele, jinak false
     */
    boolean isTokenValid(String token, UserEntity user);

    /**
     * Vrací nakonfigurovanou dobu platnosti access tokenu v sekundách.
     *
     * @return doba platnosti v sekundách
     */
    Long getAccessTokenExpirationSeconds();

    /**
     * Obnoví access a refresh tokeny pomocí platného refresh tokenu.
     * Implementuje rotaci tokenů pro zvýšení bezpečnosti.
     * Validuje typ tokenu a stav uživatelského účtu.
     *
     * @param refreshToken platný refresh token
     * @return nová autentizační odpověď s novými tokeny
     * @throws JwtException pokud je refresh token neplatný
     */
    AuthResponse refreshTokens(String refreshToken);

    /**
     * Ověří, zda je daný token refresh token.
     * Kontroluje type claim v tokenu.
     *
     * @param token JWT token k ověření
     * @return true pokud je to refresh token, jinak false
     */
    boolean isRefreshToken(String token);
}