package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import lombok.*;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RestaurantTableResponse {
    private UUID id;
    private String label;
    private int capacity;
    private boolean active;
    private Double yaw;
    private Double pitch;
}