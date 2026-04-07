package com.checkfood.checkfoodservice.module.restaurant.dto.request;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import jakarta.validation.constraints.NotNull;
import lombok.*;

/**
 * Požadavek na změnu role zaměstnance v restauraci.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UpdateEmployeeRoleRequest {

    @NotNull(message = "Role zaměstnance je povinná")
    private RestaurantEmployeeRole role;
}