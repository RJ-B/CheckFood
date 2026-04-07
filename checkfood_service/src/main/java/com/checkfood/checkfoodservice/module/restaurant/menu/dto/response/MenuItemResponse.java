package com.checkfood.checkfoodservice.module.restaurant.menu.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Response DTO pro položku menu zobrazovanou zákazníkovi nebo vlastníkovi restaurace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MenuItemResponse {

    private UUID id;
    private String name;
    private String description;
    private int priceMinor;
    private String currency;
    private String imageUrl;
    private boolean available;
}
