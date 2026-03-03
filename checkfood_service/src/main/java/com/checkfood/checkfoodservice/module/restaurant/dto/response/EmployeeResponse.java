package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import lombok.*;

import java.time.LocalDateTime;

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
}
