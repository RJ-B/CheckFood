package com.checkfood.checkfoodservice.module.owner.dto;

import lombok.Builder;

@Builder
public record BankIdIdentity(
        String firstName,
        String lastName
) {}
