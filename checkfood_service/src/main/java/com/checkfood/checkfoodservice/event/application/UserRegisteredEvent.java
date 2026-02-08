package com.checkfood.checkfoodservice.event.application;

import com.checkfood.checkfoodservice.event.base.UserAwareEvent;

/**
 * Událost vyvolaná po úspěšné registraci uživatele.
 */
public class UserRegisteredEvent extends UserAwareEvent {

    private final String email;

    public UserRegisteredEvent(Long userId, String email) {
        super(userId);
        this.email = email;
    }

    public String getEmail() {
        return email;
    }
}
