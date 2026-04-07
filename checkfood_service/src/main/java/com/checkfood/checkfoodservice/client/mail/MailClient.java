package com.checkfood.checkfoodservice.client.mail;

import com.checkfood.checkfoodservice.client.mail.model.MailRequest;
import com.checkfood.checkfoodservice.client.mail.model.MailResponse;

/**
 * Abstraktní kontrakt pro odesílání e-mailů.
 * Application service pracuje výhradně s tímto rozhraním a nezná konkrétního poskytovatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface MailClient {

    /**
     * Odešle e-mail podle zadaného požadavku.
     *
     * @param request požadavek na odeslání e-mailu
     * @return výsledek operace odeslání
     */
    MailResponse send(MailRequest request);
}
