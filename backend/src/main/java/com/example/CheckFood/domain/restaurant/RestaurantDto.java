package com.example.CheckFood.domain.restaurant;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RestaurantDto {

    @NotBlank(message = "Název restaurace je povinný")
    private String name;

    @NotBlank(message = "Adresa je povinná")
    private String address;

    @NotBlank(message = "Telefon je povinný")
    private String phone;

    @NotBlank(message = "Email je povinný")
    @Email(message = "Neplatný formát emailu")
    private String email;

    private String description;
}
