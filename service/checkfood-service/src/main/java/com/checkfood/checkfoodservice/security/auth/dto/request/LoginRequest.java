package com.checkfood.checkfoodservice.security.auth.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

/**
 * DTO pro přihlášení uživatele.
 * Obsahuje přihlašovací údaje a identifikátor zařízení pro správu relací.
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

    @NotBlank(message = "Identifikátor zařízení je povinný pro správu relací.")
    private String deviceIdentifier;

    /**
     * Čitelný název zařízení (např. "Samsung S24", "iPhone 15").
     */
    private String deviceName;

    /**
     * Typ zařízení (např. "ANDROID", "IOS").
     * Přidáno pro správné mapování v DeviceEntity.
     */
    private String deviceType; // ✅ PŘIDÁNO
}