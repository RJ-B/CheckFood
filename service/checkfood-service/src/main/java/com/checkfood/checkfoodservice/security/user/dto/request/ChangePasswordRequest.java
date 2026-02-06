package com.checkfood.checkfoodservice.security.user.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

/**
 * DTO pro bezpečné zpracování požadavku na změnu hesla.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChangePasswordRequest {

    /**
     * Stávající heslo uživatele pro ověření identity.
     */
    @NotBlank(message = "Původní heslo musí být vyplněno.")
    private String currentPassword;

    /**
     * Nové heslo splňující bezpečnostní politiku (min 8 znaků).
     */
    @NotBlank(message = "Nové heslo musí být vyplněno.")
    @Size(min = 8, max = 64, message = "Nové heslo musí mít délku mezi 8 a 64 znaky.")
    private String newPassword;

    /**
     * Potvrzení nového hesla pro eliminaci překlepů.
     */
    @NotBlank(message = "Potvrzení hesla musí být vyplněno.")
    private String confirmPassword;
}