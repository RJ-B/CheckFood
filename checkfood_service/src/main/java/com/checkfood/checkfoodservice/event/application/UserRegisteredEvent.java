package com.checkfood.checkfoodservice.event.application;

import com.checkfood.checkfoodservice.event.base.UserAwareEvent;

/**
 * Doménová událost vyvolaná po úspěšné registraci nového uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class UserRegisteredEvent extends UserAwareEvent {

    private final String email;

    /**
     * Vytvoří událost registrace uživatele.
     *
     * @param userId identifikátor nově registrovaného uživatele
     * @param email  e-mailová adresa uživatele
     */
    public UserRegisteredEvent(Long userId, String email) {
        super(userId);
        this.email = email;
    }

    /**
     * Vrátí e-mailovou adresu registrovaného uživatele.
     *
     * @return e-mail uživatele
     */
    public String getEmail() {
        return email;
    }
}
