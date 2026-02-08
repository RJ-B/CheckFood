package com.checkfood.checkfoodservice.security.module.jwt.exception;

/**
 * Enumrace chybových kódů pro JWT modul.
 * Poskytuje standardizované identifikátory chyb pro JWT tokeny a jejich validaci.
 */
public enum JwtErrorCode {

    /**
     * JWT token je neplatný (špatný formát, podpis nebo claims).
     */
    JWT_INVALID,

    /**
     * JWT token vypršel.
     */
    JWT_EXPIRED,

    /**
     * JWT token chybí v požadavku.
     */
    JWT_MISSING,

    /**
     * JWT token má neplatný podpis.
     */
    JWT_INVALID_SIGNATURE,

    /**
     * JWT token má neplatné claims.
     */
    JWT_INVALID_CLAIMS,

    /**
     * Chyba při generování JWT tokenu.
     */
    JWT_GENERATION_ERROR,

    /**
     * Chyba při parsování JWT tokenu.
     */
    JWT_PARSE_ERROR
}