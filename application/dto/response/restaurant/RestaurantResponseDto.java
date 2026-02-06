package com.checkfood.checkfoodservice.application.dto.response.restaurant;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * DTO reprezentující detail restaurace. <br><br>
 *
 * Slouží jako výstupní model
 * pro API a administrační rozhraní.
 *
 * Neobsahuje validační logiku.
 */
public record RestaurantResponseDto(

        UUID id,

        String name,

        String description,

        String status,

        boolean active,

        OffsetDateTime createdAt,

        OffsetDateTime updatedAt

) {
}
