package com.checkfood.checkfoodservice.client.mail.model;

/**
 * Datový objekt reprezentující požadavek
 * na odeslání e-mailu.
 *
 * Nejde o aplikační DTO – je určen výhradně
 * pro client vrstvu.
 */
public class MailRequest {

    private String to;
    private String subject;
    private String body;

    // getters / setters
}
