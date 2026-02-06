package com.checkfood.checkfoodservice.security.user.dto.response;

import lombok.*;

/**
 * Odlehčené DTO pro seznamy uživatelů.
 * Optimalizováno pro vysoký výkon při zobrazení v tabulkách.
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

    private Boolean isActive;
}