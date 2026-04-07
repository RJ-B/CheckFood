package com.checkfood.checkfoodservice.client.mail.model;

/**
 * Datový objekt reprezentující požadavek na odeslání e-mailu.
 * Určen výhradně pro client vrstvu, není to aplikační DTO.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class MailRequest {

    private String to;
    private String subject;
    private String body;

    // getters / setters
}
