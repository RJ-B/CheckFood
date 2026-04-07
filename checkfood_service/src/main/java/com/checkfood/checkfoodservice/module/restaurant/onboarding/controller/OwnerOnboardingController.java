package com.checkfood.checkfoodservice.module.restaurant.onboarding.controller;

import com.checkfood.checkfoodservice.module.restaurant.onboarding.dto.onboarding.OnboardingHoursRequest;
import com.checkfood.checkfoodservice.module.restaurant.onboarding.dto.onboarding.OnboardingInfoRequest;
import com.checkfood.checkfoodservice.module.restaurant.onboarding.dto.onboarding.OnboardingStatusResponse;
import com.checkfood.checkfoodservice.module.restaurant.onboarding.service.OwnerOnboardingService;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantTableRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantTableResponse;
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
 * REST kontroler pro správu onboardingu restaurace přihlášeného majitele.
 * Všechny endpointy jsou přístupné pouze uživatelům s rolí OWNER.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/v1/owner/restaurant")
@PreAuthorize("hasRole('OWNER')")
@RequiredArgsConstructor
public class OwnerOnboardingController {

    private final OwnerOnboardingService onboardingService;

    /**
     * Vrátí detail restaurace přiřazené přihlášenému majiteli.
     *
     * @param userDetails detail přihlášeného uživatele
     * @return detail restaurace
     */
    @GetMapping("/me")
    public ResponseEntity<RestaurantResponse> getMyRestaurant(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(onboardingService.getMyRestaurant(userDetails.getUsername()));
    }

    /**
     * Aktualizuje základní informace restaurace přihlášeného majitele.
     *
     * @param userDetails detail přihlášeného uživatele
     * @param request     nové informace o restauraci
     * @return aktualizovaný detail restaurace
     */
    @PutMapping("/me/info")
    public ResponseEntity<RestaurantResponse> updateInfo(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody OnboardingInfoRequest request) {
        return ResponseEntity.ok(onboardingService.updateInfo(userDetails.getUsername(), request));
    }

    /**
     * Aktualizuje otevírací dobu restaurace přihlášeného majitele.
     *
     * @param userDetails detail přihlášeného uživatele
     * @param request     nová otevírací doba
     * @return aktualizovaný detail restaurace
     */
    @PutMapping("/me/hours")
    public ResponseEntity<RestaurantResponse> updateHours(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody OnboardingHoursRequest request) {
        return ResponseEntity.ok(onboardingService.updateHours(userDetails.getUsername(), request));
    }

    /**
     * Vrátí seznam stolů restaurace přihlášeného majitele.
     *
     * @param userDetails detail přihlášeného uživatele
     * @return seznam stolů
     */
    @GetMapping("/me/tables")
    public ResponseEntity<List<RestaurantTableResponse>> getTables(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(onboardingService.getTables(userDetails.getUsername()));
    }

    /**
     * Přidá nový stůl do restaurace přihlášeného majitele.
     *
     * @param userDetails detail přihlášeného uživatele
     * @param request     parametry nového stolu
     * @return vytvořený stůl
     */
    @PostMapping("/me/tables")
    public ResponseEntity<RestaurantTableResponse> addTable(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody RestaurantTableRequest request) {
        return ResponseEntity.ok(onboardingService.addTable(userDetails.getUsername(), request));
    }

    /**
     * Aktualizuje existující stůl restaurace přihlášeného majitele.
     *
     * @param userDetails detail přihlášeného uživatele
     * @param id          identifikátor stolu
     * @param request     nové parametry stolu
     * @return aktualizovaný stůl
     */
    @PutMapping("/me/tables/{id}")
    public ResponseEntity<RestaurantTableResponse> updateTable(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id,
            @Valid @RequestBody RestaurantTableRequest request) {
        return ResponseEntity.ok(onboardingService.updateTable(userDetails.getUsername(), id, request));
    }

    /**
     * Smaže stůl z restaurace přihlášeného majitele.
     *
     * @param userDetails detail přihlášeného uživatele
     * @param id          identifikátor stolu ke smazání
     * @return prázdná odpověď s HTTP 204
     */
    @DeleteMapping("/me/tables/{id}")
    public ResponseEntity<Void> deleteTable(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        onboardingService.deleteTable(userDetails.getUsername(), id);
        return ResponseEntity.noContent().build();
    }

    /**
     * Vrátí stav onboardingu restaurace přihlášeného majitele.
     *
     * @param userDetails detail přihlášeného uživatele
     * @return stav onboardingu
     */
    @GetMapping("/me/onboarding-status")
    public ResponseEntity<OnboardingStatusResponse> getOnboardingStatus(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(onboardingService.getOnboardingStatus(userDetails.getUsername()));
    }

    /**
     * Publikuje restauraci přihlášeného majitele po splnění všech podmínek onboardingu.
     *
     * @param userDetails detail přihlášeného uživatele
     * @return aktualizovaný detail publikované restaurace
     */
    @PostMapping("/me/publish")
    public ResponseEntity<RestaurantResponse> publish(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(onboardingService.publish(userDetails.getUsername()));
    }
}
