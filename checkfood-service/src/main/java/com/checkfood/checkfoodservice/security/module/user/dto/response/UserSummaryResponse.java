package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;

/**
 * Zjednodušené DTO pro seznamy uživatelů.
 * Optimalizováno pro vysoký výkon při zobrazení v tabulkách admin rozhraní.
 * Obsahuje pouze základní informace pro přehled.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserSummaryResponse {

    private Long id;

    private String email;

    private String firstName;

    private String lastName;

    /**
     * Indikuje, zda je účet aktivován.
     */
    private Boolean isActive;
}