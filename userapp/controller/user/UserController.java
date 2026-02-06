package com.checkfood.checkfoodservice.application.controller.user;

/**
 * REST controller pro práci s uživateli.
 *
 * Zodpovědnosti:
 * - registrace uživatele
 * - správa vlastního profilu
 * - administrativní operace (blokace, aktivace)
 *
 * Používá:
 * - UserService
 *
 * Cross-cutting:
 * - security (autorizace endpointů)
 * - validation (request DTO)
 * - audit (změny stavu)
 * - rate-limit (registrace, login)
 */
public class UserController {

    // TODO: inject UserService

    // TODO: POST /users/register
    // - registrace uživatele

    // TODO: GET /users/me
    // - vrácení aktuálního uživatele

    // TODO: PUT /users/me/password
    // - změna hesla

    // TODO: PUT /users/{id}/block
    // - blokace uživatele (ADMIN)
}
