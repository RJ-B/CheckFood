package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import com.checkfood.checkfoodservice.security.module.auth.service.AuthService;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

/**
 * DTO pro registraci nového uživatele do systému.
 *
 * Obsahuje pouze základní osobní a přihlašovací údaje. Device metadata
 * nejsou součástí registrace protože session se vytváří až po email
 * verification během prvního login procesu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuthService
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RegisterRequest {

    /**
     * Křestní jméno uživatele pro profile a personalizaci.
     */
    @NotBlank(message = "Jméno nesmí být prázdné.")
    @Size(max = 50, message = "Jméno nesmí být delší než 50 znaků.")
    private String firstName;

    /**
     * Příjmení uživatele pro kompletní profile information.
     */
    @NotBlank(message = "Příjmení nesmí být prázdné.")
    @Size(max = 50, message = "Příjmení nesmí být delší než 50 znaků.")
    private String lastName;

    /**
     * Email adresa sloužící jako username a pro email verification workflow.
     */
    @NotBlank(message = "Email nesmí být prázdný.")
    @Email(message = "Zadejte platnou emailovou adresu.")
    @Size(max = 254, message = "Email nesmí překročit délku 254 znaků.")
    private String email;

    /**
     * Plain text heslo pro hash generation. Síla hesla je validována
     * PasswordValidator komponentou v service layer.
     */
    @NotBlank(message = "Heslo nesmí být prázdné.")
    @Size(min = 8, max = 64, message = "Heslo musí mít 8 až 64 znaků.")
    private String password;

    /**
     * Příznak pro registraci jako majitel restaurace.
     * Pokud true, uživatel dostane roli OWNER a je mu vytvořena zkušební restaurace (TRIAL).
     */
    @Builder.Default
    private boolean ownerRegistration = false;

    /** GPS šířka pro umístění zkušební restaurace (volitelné, jen pro owner registraci) */
    private Double latitude;

    /** GPS délka pro umístění zkušební restaurace (volitelné, jen pro owner registraci) */
    private Double longitude;
}