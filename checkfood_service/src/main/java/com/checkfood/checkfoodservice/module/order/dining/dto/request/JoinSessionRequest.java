package com.checkfood.checkfoodservice.module.order.dining.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Request DTO pro připojení k existujícímu skupinovému sezení pomocí pozvánkového kódu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class JoinSessionRequest {

    @NotBlank(message = "Kód pozvánky nesmí být prázdný.")
    @Size(min = 8, max = 8, message = "Kód pozvánky musí mít přesně 8 znaků.")
    private String inviteCode;
}
