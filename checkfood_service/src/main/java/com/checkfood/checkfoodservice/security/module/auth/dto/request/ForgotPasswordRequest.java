package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * DTO pro žádost o obnovu zapomenutého hesla.
 *
 * Obsahuje pouze email adresu uživatele. Response je vždy 200 OK
 * bez ohledu na to, zda email existuje — prevence user enumeration.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ForgotPasswordRequest {

    @NotBlank(message = "Email nesmí být prázdný.")
    @Email(message = "Zadejte platnou emailovou adresu.")
    private String email;
}
