package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;

import java.time.LocalDateTime;
import java.util.Set;

/**
 * DTO poskytující detailní administrativní pohled na uživatele.
 * Rozšířeno o profilový obrázek pro vizuální identifikaci v admin rozhraní.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserAdminResponse {

    private Long id;

    private String email;

    private String firstName;

    private String lastName;

    /**
     * URL adresa profilového obrázku.
     */
    private String profileImageUrl; // ✅ Přidáno pro opravu chyby v UserMapper

    private LocalDateTime lastLogin;
    private Set<String> authorities;

    private Boolean isActive;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private Set<String> roles;
}