package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import com.checkfood.checkfoodservice.security.module.auth.service.AuthService;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

/**
 * DTO pro přihlášení uživatele do systému.
 * Obsahuje přihlašovací údaje a informace o zařízení pro správu sessions a refresh tokenů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuthService#login(LoginRequest)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LoginRequest {

    @NotBlank(message = "Email nesmí být prázdný.")
    @Email(message = "Zadejte platnou emailovou adresu.")
    private String email;

    @NotBlank(message = "Heslo nesmí být prázdné.")
    @Size(min = 8, max = 64, message = "Heslo musí mít 8 až 64 znaků.")
    private String password;

    /**
     * Jedinečný identifikátor zařízení.
     * Používá se pro vazbu refresh tokenu na konkrétní zařízení.
     */
    @NotBlank(message = "Identifikátor zařízení je povinný pro správu relací.")
    private String deviceIdentifier;

    private String deviceName;

    private String deviceType;
}