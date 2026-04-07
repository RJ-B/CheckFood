package com.checkfood.checkfoodservice.module.restaurant.menu.controller;

import com.checkfood.checkfoodservice.module.restaurant.menu.dto.request.MenuCategoryRequest;
import com.checkfood.checkfoodservice.module.restaurant.menu.dto.request.MenuItemRequest;
import com.checkfood.checkfoodservice.module.restaurant.menu.dto.response.MenuCategoryResponse;
import com.checkfood.checkfoodservice.module.restaurant.menu.dto.response.MenuItemResponse;
import com.checkfood.checkfoodservice.module.restaurant.menu.service.OwnerMenuService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST kontroler pro správu menu vlastníkem restaurace — CRUD operace nad kategoriemi a položkami menu.
 * Přístup je omezen na uživatele s rolí OWNER.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/v1/owner/restaurant/me/menu")
@PreAuthorize("hasRole('OWNER')")
@RequiredArgsConstructor
public class OwnerMenuController {

    private final OwnerMenuService ownerMenuService;

    /**
     * Vrátí celé menu restaurace vlastníka včetně všech kategorií a jejich položek.
     *
     * @param userDetails přihlášený vlastník
     * @return seznam kategorií s položkami
     */
    @GetMapping
    public ResponseEntity<List<MenuCategoryResponse>> getMenu(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(ownerMenuService.getOwnerMenu(userDetails.getUsername()));
    }

    /**
     * Vytvoří novou kategorii menu pro restauraci vlastníka.
     *
     * @param userDetails přihlášený vlastník
     * @param request     data nové kategorie
     * @return vytvořená kategorie
     */
    @PostMapping("/categories")
    public ResponseEntity<MenuCategoryResponse> createCategory(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody MenuCategoryRequest request) {
        return ResponseEntity.ok(ownerMenuService.createCategory(userDetails.getUsername(), request));
    }

    /**
     * Aktualizuje existující kategorii menu.
     *
     * @param userDetails přihlášený vlastník
     * @param id          UUID kategorie
     * @param request     aktualizovaná data kategorie
     * @return aktualizovaná kategorie s položkami
     */
    @PutMapping("/categories/{id}")
    public ResponseEntity<MenuCategoryResponse> updateCategory(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id,
            @Valid @RequestBody MenuCategoryRequest request) {
        return ResponseEntity.ok(ownerMenuService.updateCategory(userDetails.getUsername(), id, request));
    }

    /**
     * Smaže kategorii menu i s jejími položkami.
     *
     * @param userDetails přihlášený vlastník
     * @param id          UUID kategorie ke smazání
     * @return HTTP 204 bez těla
     */
    @DeleteMapping("/categories/{id}")
    public ResponseEntity<Void> deleteCategory(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        ownerMenuService.deleteCategory(userDetails.getUsername(), id);
        return ResponseEntity.noContent().build();
    }

    /**
     * Vytvoří novou položku menu v dané kategorii.
     *
     * @param userDetails přihlášený vlastník
     * @param catId       UUID kategorie
     * @param request     data nové položky
     * @return vytvořená položka menu
     */
    @PostMapping("/categories/{catId}/items")
    public ResponseEntity<MenuItemResponse> createItem(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID catId,
            @Valid @RequestBody MenuItemRequest request) {
        return ResponseEntity.ok(ownerMenuService.createItem(userDetails.getUsername(), catId, request));
    }

    /**
     * Aktualizuje existující položku menu.
     *
     * @param userDetails přihlášený vlastník
     * @param id          UUID položky menu
     * @param request     aktualizovaná data položky
     * @return aktualizovaná položka menu
     */
    @PutMapping("/items/{id}")
    public ResponseEntity<MenuItemResponse> updateItem(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id,
            @Valid @RequestBody MenuItemRequest request) {
        return ResponseEntity.ok(ownerMenuService.updateItem(userDetails.getUsername(), id, request));
    }

    /**
     * Smaže položku menu.
     *
     * @param userDetails přihlášený vlastník
     * @param id          UUID položky menu ke smazání
     * @return HTTP 204 bez těla
     */
    @DeleteMapping("/items/{id}")
    public ResponseEntity<Void> deleteItem(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        ownerMenuService.deleteItem(userDetails.getUsername(), id);
        return ResponseEntity.noContent().build();
    }
}
