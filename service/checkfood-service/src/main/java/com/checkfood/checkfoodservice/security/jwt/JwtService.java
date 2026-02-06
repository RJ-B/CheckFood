package com.checkfood.checkfoodservice.security.jwt;

import com.checkfood.checkfoodservice.security.user.entity.UserEntity;

/**
 * Rozhraní pro správu JSON Web Tokenů (JWT).
 * Zajišťuje generování, parsování a validaci přístupových a obnovovacích tokenů.
 */
public interface JwtService {

    /**
     * Vygeneruje krátkodobý Access Token pro autorizaci API požadavků.
     */
    String generateAccessToken(UserEntity user);

    /**
     * Vygeneruje dlouhodobý Refresh Token pro obnovu Access Tokenu.
     */
    String generateRefreshToken(UserEntity user);

    /**
     * Extrahuje email (subject) z JWT tokenu.
     */
    String extractEmail(String token);

    /**
     * Provádí základní syntaktickou a kryptografickou validaci tokenu.
     */
    boolean validateToken(String token);

    /**
     * Provádí komplexní validaci tokenu vůči konkrétnímu uživateli.
     * Kontroluje shodu identity, expiraci a správný typ tokenu (ACCESS/REFRESH).
     */
    boolean isTokenValid(String token, UserEntity user);

    /**
     * Vrátí nakonfigurovanou dobu platnosti Access Tokenu v sekundách.
     */
    Long getAccessTokenExpirationSeconds();
}