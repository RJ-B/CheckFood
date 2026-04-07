package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import lombok.*;

import java.time.LocalDateTime;
import java.util.Set;

/**
 * Odpověď s daty zaměstnance restaurace včetně jeho role a efektivních oprávnění.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeResponse {
    private Long id;
    private Long userId;
    private String name;
    private String email;
    private RestaurantEmployeeRole role;
    private LocalDateTime createdAt;
    private Set<String> permissions;
}
