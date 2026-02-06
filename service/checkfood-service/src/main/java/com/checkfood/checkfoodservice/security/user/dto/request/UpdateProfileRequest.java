package com.checkfood.checkfoodservice.security.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

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
}