package com.checkfood.checkfoodservice.security.module.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

/**
 * DTO pro aktualizaci uživatelského profilu.
 * Umožňuje změnu jména a příjmení uživatele.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateProfileRequest {

    /**
     * Křestní jméno uživatele.
     */
    @NotBlank(message = "Jméno nesmí být prázdné.")
    @Size(max = 50, message = "Jméno nesmí být delší než 50 znaků.")
    private String firstName;

    /**
     * Příjmení uživatele.
     */
    @NotBlank(message = "Příjmení nesmí být prázdné.")
    @Size(max = 50, message = "Příjmení nesmí být delší než 50 znaků.")
    private String lastName;
}