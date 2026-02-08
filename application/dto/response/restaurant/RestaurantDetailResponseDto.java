package com.checkfood.checkfoodservice.application.dto.response.restaurant;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

/**
 * DTO reprezentující rozšířený detail restaurace. <br><br>
 *
 * Obsahuje kompletní informace
 * včetně stolů patřících k restauraci.
 *
 * Používá se výhradně pro:
 * <br> - detail restaurace
 * <br> - administrační správu
 *
 * Toto DTO není určeno pro listování
 * z důvodu větší datové náročnosti.
 */
public record RestaurantDetailResponseDto(

        UUID id,

        String name,

        String description,

        String status,

        boolean active,

        OffsetDateTime createdAt,

        OffsetDateTime updatedAt,

        List<RestaurantTableResponseDto> tables

) {
}
