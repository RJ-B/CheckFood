package com.checkfood.checkfoodservice.module.restaurant.dto.request;

import jakarta.validation.constraints.*;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RestaurantTableRequest {
    @NotBlank(message = "Označení stolu je povinné")
    private String label;

    @Min(value = 1, message = "Kapacita musí být alespoň 1")
    private int capacity;

    private boolean active;

    private Double yaw;
    private Double pitch;
}