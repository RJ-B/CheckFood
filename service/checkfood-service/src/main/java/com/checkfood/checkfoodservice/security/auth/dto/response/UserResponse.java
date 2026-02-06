package com.checkfood.checkfoodservice.security.auth.dto.response;

import lombok.*;

/**
 * Bezpečná projekce uživatelských dat pro potřeby autentizačních odpovědí.
 * Sjednoceno s UserProfileResponse pro konzistentní chování frontendu.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserResponse {

    private Long id;

    private String email;

    private String firstName;

    private String lastName;

    private String role;

    private Boolean isActive;
}