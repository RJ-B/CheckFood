package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * DTO pro provedení resetu hesla pomocí platného tokenu.
 *
 * Token pochází z emailového odkazu (přes GET redirect) a nové heslo
 * je validováno přes PasswordValidator v service vrstvě.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ResetPasswordRequest {

    @NotBlank(message = "Token nesmí být prázdný.")
    private String token;

    @NotBlank(message = "Nové heslo nesmí být prázdné.")
    private String newPassword;
}
