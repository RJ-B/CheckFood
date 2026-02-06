package com.checkfood.checkfoodservice.security.user.dto.response;

import lombok.*;

import java.time.LocalDateTime;
import java.util.Set;

/**
 * DTO poskytující detailní administrativní pohled na uživatele.
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

    /**
     * Křestní jméno a příjmení rozdělené pro potřeby administrace.
     */
    private String firstName;
    private String lastName;

    /**
     * Sjednoceno na isActive pro konzistenci s frontendem a mobilní aplikací.
     */
    private Boolean isActive;

    /**
     * Auditní data pro sledování stáří a aktivity účtu.
     */
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /**
     * Seznam názvů rolí přiřazených uživateli.
     */
    private Set<String> roles;
}