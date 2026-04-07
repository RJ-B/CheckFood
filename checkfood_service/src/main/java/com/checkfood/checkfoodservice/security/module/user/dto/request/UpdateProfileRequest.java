package com.checkfood.checkfoodservice.security.module.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

/**
 * DTO pro aktualizaci uživatelského profilu.
 * Umožňuje změnu jména, příjmení, profilového obrázku a kontaktních/adresních údajů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UpdateProfileRequest {

    @NotBlank(message = "Jméno nesmí být prázdné.")
    @Size(max = 50, message = "Jméno nesmí být delší než 50 znaků.")
    private String firstName;

    @NotBlank(message = "Příjmení nesmí být prázdné.")
    @Size(max = 50, message = "Příjmení nesmí být delší než 50 znaků.")
    private String lastName;

    /**
     * URL adresa profilového obrázku.
     */
    @Size(max = 512, message = "URL obrázku nesmí být delší než 512 znaků.")
    private String profileImageUrl;

    @Size(max = 20, message = "Telefonní číslo nesmí být delší než 20 znaků.")
    private String phone;

    @Size(max = 255, message = "Ulice nesmí být delší než 255 znaků.")
    private String addressStreet;

    @Size(max = 100, message = "Město nesmí být delší než 100 znaků.")
    private String addressCity;

    @Size(max = 20, message = "PSČ nesmí být delší než 20 znaků.")
    private String addressPostalCode;

    @Size(max = 100, message = "Stát nesmí být delší než 100 znaků.")
    private String addressCountry;
}