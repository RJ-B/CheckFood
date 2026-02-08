package com.checkfood.checkfoodservice.client.mail;

import com.checkfood.checkfoodservice.client.mail.model.MailRequest;
import com.checkfood.checkfoodservice.client.mail.model.MailResponse;

/**
 * Implementace MailClient pro externí e-mailovou službu
 * (např. SendGrid, Mailgun).
 */
public class MailServiceClient implements MailClient {

    @Override
    public MailResponse send(MailRequest request) {
        // TODO:
        // - volání externí API
        return null;
    }
}
