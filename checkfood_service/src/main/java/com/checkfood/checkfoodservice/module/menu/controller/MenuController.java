package com.checkfood.checkfoodservice.module.menu.controller;

import com.checkfood.checkfoodservice.module.menu.dto.response.MenuCategoryResponse;
import com.checkfood.checkfoodservice.module.menu.service.MenuService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class MenuController {

    private final MenuService menuService;

    @GetMapping("/api/v1/restaurants/{restaurantId}/menu")
    public ResponseEntity<List<MenuCategoryResponse>> getMenu(@PathVariable UUID restaurantId) {
        return ResponseEntity.ok(menuService.getMenu(restaurantId));
    }
}
