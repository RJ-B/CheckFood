package com.checkfood.checkfoodservice.listener.application;

import com.checkfood.checkfoodservice.event.application.UserRegisteredEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Reaguje na registraci nového uživatele.
 */
@Component
public class UserRegisteredListener {

    @EventListener
    public void onUserRegistered(UserRegisteredEvent event) {

        // TODO:
        // - odeslat uvítací e-mail (MailClient)
        // - publikovat audit (UserAuditEvent)
        // - případně metriky
    }
}
