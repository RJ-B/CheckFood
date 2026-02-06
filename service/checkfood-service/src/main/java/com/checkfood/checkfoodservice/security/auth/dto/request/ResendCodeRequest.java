package com.checkfood.checkfoodservice.security.auth.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * DTO pro požadavek na znovuzaslání verifikačního kódu.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ResendCodeRequest {

    @NotBlank(message = "Email nesmí být prázdný.")
    @Email(message = "Zadejte platnou emailovou adresu.")
    private String email;
}