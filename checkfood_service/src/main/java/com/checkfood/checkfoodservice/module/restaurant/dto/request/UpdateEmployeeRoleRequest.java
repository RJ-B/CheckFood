package com.checkfood.checkfoodservice.module.restaurant.dto.request;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UpdateEmployeeRoleRequest {

    @NotNull(message = "Role zaměstnance je povinná")
    private RestaurantEmployeeRole role;
}