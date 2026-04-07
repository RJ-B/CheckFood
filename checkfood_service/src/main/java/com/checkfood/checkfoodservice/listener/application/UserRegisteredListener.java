package com.checkfood.checkfoodservice.listener.application;

import com.checkfood.checkfoodservice.event.application.UserRegisteredEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Listener doménové události registrace nového uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class UserRegisteredListener {

    /**
     * Zpracuje událost registrace nového uživatele.
     *
     * @param event událost s daty registrovaného uživatele
     */
    @EventListener
    public void onUserRegistered(UserRegisteredEvent event) {
        // TODO: odeslat uvítací e-mail (MailClient), publikovat audit, metriky
    }
}
