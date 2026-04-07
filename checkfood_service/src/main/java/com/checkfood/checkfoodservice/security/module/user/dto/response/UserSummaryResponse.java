package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;

/**
 * Zjednodušené DTO pro přehledové seznamy uživatelů v administrátorském rozhraní.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
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
    private String profileImageUrl;
    private Boolean isActive;
}