package com.checkfood.checkfoodservice.module.restaurant.dto.request;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;

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