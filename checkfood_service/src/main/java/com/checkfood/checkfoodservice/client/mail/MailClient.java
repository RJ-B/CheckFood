package com.checkfood.checkfoodservice.client.mail;

import com.checkfood.checkfoodservice.client.mail.model.MailRequest;
import com.checkfood.checkfoodservice.client.mail.model.MailResponse;

/**
 * Abstraktní kontrakt pro odesílání e-mailů.
 *
 * Application service:
 * - zná pouze toto rozhraní
 * - neřeší implementaci ani poskytovatele
 */
public interface MailClient {

    MailResponse send(MailRequest request);
}
