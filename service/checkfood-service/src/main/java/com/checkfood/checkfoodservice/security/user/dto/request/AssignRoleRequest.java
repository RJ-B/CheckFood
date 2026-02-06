package com.checkfood.checkfoodservice.security.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

/**
 * DTO pro přiřazení role uživateli.
 * Používá se v administrativním rozhraní pro správu přístupových práv.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AssignRoleRequest {

    /**
     * Identifikátor uživatele, kterému má být role přiřazena.
     */
    @NotNull(message = "ID uživatele je povinné.")
    private Long userId;

    /**
     * Unikátní název role (např. "ADMIN", "MANAGER").
     */
    @NotBlank(message = "Název role nesmí být prázdný.")
    private String roleName;

}