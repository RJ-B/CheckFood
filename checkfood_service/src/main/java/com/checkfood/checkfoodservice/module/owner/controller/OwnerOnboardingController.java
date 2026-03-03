package com.checkfood.checkfoodservice.module.owner.controller;

import com.checkfood.checkfoodservice.module.owner.dto.onboarding.OnboardingHoursRequest;
import com.checkfood.checkfoodservice.module.owner.dto.onboarding.OnboardingInfoRequest;
import com.checkfood.checkfoodservice.module.owner.dto.onboarding.OnboardingStatusResponse;
import com.checkfood.checkfoodservice.module.owner.service.OwnerOnboardingService;
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

@RestController
@RequestMapping("/api/v1/owner/restaurant")
@PreAuthorize("hasRole('OWNER')")
@RequiredArgsConstructor
public class OwnerOnboardingController {

    private final OwnerOnboardingService onboardingService;

    @GetMapping("/me")
    public ResponseEntity<RestaurantResponse> getMyRestaurant(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(onboardingService.getMyRestaurant(userDetails.getUsername()));
    }

    @PutMapping("/me/info")
    public ResponseEntity<RestaurantResponse> updateInfo(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody OnboardingInfoRequest request) {
        return ResponseEntity.ok(onboardingService.updateInfo(userDetails.getUsername(), request));
    }

    @PutMapping("/me/hours")
    public ResponseEntity<RestaurantResponse> updateHours(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody OnboardingHoursRequest request) {
        return ResponseEntity.ok(onboardingService.updateHours(userDetails.getUsername(), request));
    }

    @GetMapping("/me/tables")
    public ResponseEntity<List<RestaurantTableResponse>> getTables(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(onboardingService.getTables(userDetails.getUsername()));
    }

    @PostMapping("/me/tables")
    public ResponseEntity<RestaurantTableResponse> addTable(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody RestaurantTableRequest request) {
        return ResponseEntity.ok(onboardingService.addTable(userDetails.getUsername(), request));
    }

    @PutMapping("/me/tables/{id}")
    public ResponseEntity<RestaurantTableResponse> updateTable(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id,
            @Valid @RequestBody RestaurantTableRequest request) {
        return ResponseEntity.ok(onboardingService.updateTable(userDetails.getUsername(), id, request));
    }

    @DeleteMapping("/me/tables/{id}")
    public ResponseEntity<Void> deleteTable(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        onboardingService.deleteTable(userDetails.getUsername(), id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/me/onboarding-status")
    public ResponseEntity<OnboardingStatusResponse> getOnboardingStatus(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(onboardingService.getOnboardingStatus(userDetails.getUsername()));
    }

    @PostMapping("/me/publish")
    public ResponseEntity<RestaurantResponse> publish(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(onboardingService.publish(userDetails.getUsername()));
    }
}
