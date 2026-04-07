package com.checkfood.checkfoodservice.module.restaurant.dto.request;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

/**
 * Požadavek na přidání nového zaměstnance do restaurace pomocí jeho e-mailové adresy.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AddEmployeeRequest {

    @NotBlank(message = "Email zaměstnance je povinný")
    @Email(message = "Neplatný formát emailu")
    private String email;

    @NotNull(message = "Role zaměstnance je povinná")
    private RestaurantEmployeeRole role;
}