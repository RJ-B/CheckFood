package com.checkfood.checkfoodservice.module.restaurant.menu.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

/**
 * Response DTO pro kategorii menu obsahující seznam dostupných položek.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MenuCategoryResponse {

    private UUID id;
    private String name;
    private List<MenuItemResponse> items;
}
