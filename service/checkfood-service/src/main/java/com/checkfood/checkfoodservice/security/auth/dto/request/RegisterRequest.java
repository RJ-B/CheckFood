package com.checkfood.checkfoodservice.security.auth.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RegisterRequest {

    @NotBlank(message = "Jméno nesmí být prázdné.")
    @Size(max = 50, message = "Jméno nesmí být delší než 50 znaků.")
    private String firstName;

    @NotBlank(message = "Příjmení nesmí být prázdné.")
    @Size(max = 50, message = "Příjmení nesmí být delší než 50 znaků.")
    private String lastName;

    @NotBlank(message = "Email nesmí být prázdný.")
    @Email(message = "Zadejte platnou emailovou adresu.")
    @Size(max = 254, message = "Email nesmí překročit délku 254 znaků.")
    private String email;

    @NotBlank(message = "Heslo nesmí být prázdné.")
    @Size(min = 8, max = 64, message = "Heslo musí mít 8 až 64 znaků.")
    private String password;

    @NotBlank(message = "Potvrzení hesla je povinné.")
    private String confirmPassword;

    @NotBlank(message = "Identifikátor zařízení je povinný.")
    private String deviceIdentifier;

    @NotBlank(message = "Název zařízení je povinný.")
    private String deviceName;

    @NotBlank(message = "Typ zařízení je povinný.")
    private String deviceType;
}