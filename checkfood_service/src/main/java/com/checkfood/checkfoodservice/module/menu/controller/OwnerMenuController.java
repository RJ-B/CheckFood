package com.checkfood.checkfoodservice.module.menu.controller;

import com.checkfood.checkfoodservice.module.menu.dto.request.MenuCategoryRequest;
import com.checkfood.checkfoodservice.module.menu.dto.request.MenuItemRequest;
import com.checkfood.checkfoodservice.module.menu.dto.response.MenuCategoryResponse;
import com.checkfood.checkfoodservice.module.menu.dto.response.MenuItemResponse;
import com.checkfood.checkfoodservice.module.menu.service.OwnerMenuService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/owner/restaurant/me/menu")
@PreAuthorize("hasRole('OWNER')")
@RequiredArgsConstructor
public class OwnerMenuController {

    private final OwnerMenuService ownerMenuService;

    @GetMapping
    public ResponseEntity<List<MenuCategoryResponse>> getMenu(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(ownerMenuService.getOwnerMenu(userDetails.getUsername()));
    }

    @PostMapping("/categories")
    public ResponseEntity<MenuCategoryResponse> createCategory(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody MenuCategoryRequest request) {
        return ResponseEntity.ok(ownerMenuService.createCategory(userDetails.getUsername(), request));
    }

    @PutMapping("/categories/{id}")
    public ResponseEntity<MenuCategoryResponse> updateCategory(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id,
            @Valid @RequestBody MenuCategoryRequest request) {
        return ResponseEntity.ok(ownerMenuService.updateCategory(userDetails.getUsername(), id, request));
    }

    @DeleteMapping("/categories/{id}")
    public ResponseEntity<Void> deleteCategory(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        ownerMenuService.deleteCategory(userDetails.getUsername(), id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/categories/{catId}/items")
    public ResponseEntity<MenuItemResponse> createItem(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID catId,
            @Valid @RequestBody MenuItemRequest request) {
        return ResponseEntity.ok(ownerMenuService.createItem(userDetails.getUsername(), catId, request));
    }

    @PutMapping("/items/{id}")
    public ResponseEntity<MenuItemResponse> updateItem(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id,
            @Valid @RequestBody MenuItemRequest request) {
        return ResponseEntity.ok(ownerMenuService.updateItem(userDetails.getUsername(), id, request));
    }

    @DeleteMapping("/items/{id}")
    public ResponseEntity<Void> deleteItem(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        ownerMenuService.deleteItem(userDetails.getUsername(), id);
        return ResponseEntity.noContent().build();
    }
}
