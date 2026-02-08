package com.checkfood.checkfoodservice.client.mail;

import com.checkfood.checkfoodservice.client.mail.model.MailRequest;
import com.checkfood.checkfoodservice.client.mail.model.MailResponse;

/**
 * Implementace MailClient pomocí SMTP.
 *
 * Používá se typicky:
 * - v local / test prostředí
 * - jako fallback
 */
public class SmtpMailClient implements MailClient {

    @Override
    public MailResponse send(MailRequest request) {
        // TODO:
        // - SMTP implementace
        return null;
    }
}
