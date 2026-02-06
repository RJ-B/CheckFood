package com.checkfood.checkfoodservice.application.service.user;

import com.checkfood.checkfoodservice.application.entity.user.User;

/**
 * Service pro práci s uživateli.
 *
 * Zodpovědnosti:
 * - registrace uživatele
 * - změna stavu účtu
 * - změna přihlašovacích údajů
 *
 * Používá:
 * - UserRepository
 * - security (password encoder, current user)
 *
 * Cross-cutting:
 * - audit (změna stavu, změna hesla)
 * - event (UserRegisteredEvent)
 */
public interface UserService {

    // TODO:
    // - registerUser(...)
    // - activateUser(...)
    // - blockUser(...)
    // - changePassword(...)
}
