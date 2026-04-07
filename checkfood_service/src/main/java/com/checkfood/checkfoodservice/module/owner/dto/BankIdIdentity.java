package com.checkfood.checkfoodservice.module.owner.dto;

import lombok.Builder;

/**
 * Identita fyzické osoby ověřená přes BankID, obsahující jméno a příjmení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Builder
public record BankIdIdentity(
        String firstName,
        String lastName
) {}
