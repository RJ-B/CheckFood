package com.checkfood.checkfoodservice.module.restaurant.menu.controller;

import com.checkfood.checkfoodservice.module.restaurant.menu.dto.response.MenuCategoryResponse;
import com.checkfood.checkfoodservice.module.restaurant.menu.service.MenuService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

/**
 * REST kontroler pro veřejné čtení menu restaurace zákazníky.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequiredArgsConstructor
public class MenuController {

    private final MenuService menuService;

    /**
     * Vrátí menu restaurace jako seznam aktivních kategorií s dostupnými položkami.
     *
     * @param restaurantId UUID restaurace
     * @return seznam kategorií s položkami
     */
    @GetMapping("/api/v1/restaurants/{restaurantId}/menu")
    public ResponseEntity<List<MenuCategoryResponse>> getMenu(@PathVariable UUID restaurantId) {
        return ResponseEntity.ok(menuService.getMenu(restaurantId));
    }
}
