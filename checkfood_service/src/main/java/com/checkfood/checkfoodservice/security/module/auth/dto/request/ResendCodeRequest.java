package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * DTO pro požadavek na znovuzaslání verifikačního emailu.
 *
 * Minimalistické DTO obsahující pouze email pro identification účtu
 * vyžadujícího resend verification token. Rate limiting je aplikován
 * na controller level pro abuse prevention.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ResendCodeRequest {

    /**
     * Email adresa uživatele pro account lookup a token resend.
     */
    @NotBlank(message = "Email nesmí být prázdný.")
    @Email(message = "Zadejte platnou emailovou adresu.")
    private String email;
}