package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import lombok.*;

import java.util.UUID;

/**
 * Odpověď reprezentující jednu fotku v galerii restaurace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RestaurantPhotoResponse {
    private UUID id;
    private String url;
    private int sortOrder;
}
