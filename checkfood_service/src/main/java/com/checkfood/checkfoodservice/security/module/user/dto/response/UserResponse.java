package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;
import java.util.Set;

/**
 * Základní identita uživatele pro potřeby autentizace.
 * Odpovídá UserResponseModel ve Flutteru.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserResponse {
    private Long id;
    private String email;

    // Stav účtu
    private Boolean isActive;

    /**
     * Hlavní role pro UI (např. "ADMIN").
     */
    private String role;

    /**
     * Technická oprávnění ze Spring Security (authorities).
     * Např. ["ROLE_USER", "READ_PRIVILEGE"]
     */
    private Set<String> authorities;

    @Builder.Default
    private Boolean needsRestaurantClaim = false;

    @Builder.Default
    private Boolean needsOnboarding = false;
}