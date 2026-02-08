package com.checkfood.checkfoodservice.security.module.user.dto.response;

import lombok.*;

import java.time.LocalDateTime;
import java.util.Set;

/**
 * DTO poskytující detailní administrativní pohled na uživatele.
 * Používá se pro endpoint GET /api/admin/users/{id}.
 * Obsahuje auditní data a kompletní přehled oprávnění.
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

    private LocalDateTime lastLogin; // Pro MapStruct: calculateGlobalLastLogin
    private Set<String> authorities; // Pro MapStruct: mapAuthoritiesToSet

    /**
     * Indikuje, zda je účet aktivován.
     */
    private Boolean isActive;

    /**
     * Datum a čas vytvoření účtu.
     */
    private LocalDateTime createdAt;

    /**
     * Datum a čas poslední aktualizace účtu.
     */
    private LocalDateTime updatedAt;

    /**
     * Množina názvů rolí přiřazených uživateli.
     */
    private Set<String> roles;
}