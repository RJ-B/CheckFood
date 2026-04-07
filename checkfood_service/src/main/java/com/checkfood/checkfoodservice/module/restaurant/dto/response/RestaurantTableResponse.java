package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import lombok.*;
import java.util.UUID;

/**
 * Odpověď s daty fyzického stolu v restauraci.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
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