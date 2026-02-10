package com.checkfood.checkfoodservice.security.module.auth.dto.response;

import lombok.*;
import java.time.LocalDateTime;
import java.util.Set;

/**
 * DTO pro přenos základních informací o uživateli v autentizačních odpovědích.
 * Rozšířeno o auditní data a granulární autority pro potřeby frontendové navigace.
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

    private LocalDateTime lastLogin;

    private Set<String> authorities;
}