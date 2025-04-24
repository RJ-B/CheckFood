package com.example.CheckFood.domain.user;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDto {

    @NotBlank(message = "Jméno je povinné")
    private String firstName;

    @NotBlank(message = "Příjmení je povinné")
    private String lastName;

    @NotBlank(message = "Email je povinný")
    @Email(message = "Neplatný formát emailu")
    private String email;

    @NotBlank(message = "Telefon je povinný")
    @Pattern(regexp = "^\\+?[0-9]{9,15}$", message = "Neplatné telefonní číslo")
    private String phone;

    @NotBlank(message = "Uživatelské jméno je povinné")
    private String username;

    @NotBlank(message = "Heslo je povinné")
    @Size(min = 6, message = "Heslo musí mít alespoň 6 znaků")
    private String password;

    private Integer age;

    @NotBlank(message = "Role je povinná")
    @Pattern(regexp = "^(admin|user|manager)$", message = "Neplatná role")
    private String role;
}
