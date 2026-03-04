package com.checkfood.checkfoodservice.module.reservation.controller;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.UpdateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.*;
import com.checkfood.checkfoodservice.module.reservation.service.ReservationService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class ReservationController {

    private final ReservationService reservationService;

    // ── Scene (panorama + table positions) ──────────────────────────────

    @GetMapping("/api/v1/restaurants/{restaurantId}/reservation-scene")
    public ResponseEntity<ReservationSceneResponse> getReservationScene(
            @PathVariable UUID restaurantId) {
        return ResponseEntity.ok(reservationService.getReservationScene(restaurantId));
    }

    // ── Table statuses for marker coloring ──────────────────────────────

    @GetMapping("/api/v1/restaurants/{restaurantId}/tables/status")
    public ResponseEntity<TableStatusResponse> getTableStatuses(
            @PathVariable UUID restaurantId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        return ResponseEntity.ok(reservationService.getTableStatuses(restaurantId, date));
    }

    // ── Available time slots for a specific table ───────────────────────

    @GetMapping("/api/v1/restaurants/{restaurantId}/tables/{tableId}/available-slots")
    public ResponseEntity<AvailableSlotsResponse> getAvailableSlots(
            @PathVariable UUID restaurantId,
            @PathVariable UUID tableId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(required = false) UUID excludeReservationId) {
        return ResponseEntity.ok(reservationService.getAvailableSlots(restaurantId, tableId, date, excludeReservationId));
    }

    // ── Create reservation (authenticated) ──────────────────────────────

    @PostMapping("/api/v1/reservations")
    public ResponseEntity<ReservationResponse> createReservation(
            @Valid @RequestBody CreateReservationRequest request,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        ReservationResponse response = reservationService.createReservation(request, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    // ── My reservations overview (authenticated) ─────────────────────────

    @GetMapping("/api/v1/reservations/me")
    public ResponseEntity<MyReservationsOverviewResponse> getMyReservationsOverview(
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.getMyReservationsOverview(userId));
    }

    // ── My reservations history - all (authenticated) ────────────────────

    @GetMapping("/api/v1/reservations/me/history")
    public ResponseEntity<List<ReservationResponse>> getMyReservationsHistory(
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.getMyReservationsHistory(userId));
    }

    // ── Update reservation (authenticated) ───────────────────────────────

    @PutMapping("/api/v1/reservations/{id}")
    public ResponseEntity<ReservationResponse> updateReservation(
            @PathVariable UUID id,
            @Valid @RequestBody UpdateReservationRequest request,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.updateReservation(id, request, userId));
    }

    // ── Cancel reservation (authenticated) ───────────────────────────────

    @PatchMapping("/api/v1/reservations/{id}/cancel")
    public ResponseEntity<ReservationResponse> cancelReservation(
            @PathVariable UUID id,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.cancelReservation(id, userId));
    }

    // ── Helpers ─────────────────────────────────────────────────────────

    private Long extractUserId(Authentication authentication) {
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return user.getId();
    }
}
