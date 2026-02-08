package com.checkfood.checkfoodservice.application.dto.response.restaurant;

import java.util.UUID;

/**
 * DTO pro listování restaurací. <br><br>
 *
 * Optimalizováno pro:
 * - rychlou odezvu <br>
 * - minimální objem přenášených dat <br>
 */
public record RestaurantListResponseDto(

        UUID id,

        String name,

        boolean active

) {
}
