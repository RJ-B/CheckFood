package com.checkfood.checkfoodservice.module.reservation.controller;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.UpdateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.*;
import com.checkfood.checkfoodservice.module.reservation.dto.response.PendingChangeResponse;
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

/**
 * REST controller pro zákaznické operace s rezervacemi.
 * Zahrnuje dotazy na scénu, dostupné sloty, správu rezervací a zpracování návrhů změn.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequiredArgsConstructor
public class ReservationController {

    private final ReservationService reservationService;

    @GetMapping("/api/v1/restaurants/{restaurantId}/reservation-scene")
    public ResponseEntity<ReservationSceneResponse> getReservationScene(
            @PathVariable UUID restaurantId) {
        return ResponseEntity.ok(reservationService.getReservationScene(restaurantId));
    }

    @GetMapping("/api/v1/restaurants/{restaurantId}/tables/status")
    public ResponseEntity<TableStatusResponse> getTableStatuses(
            @PathVariable UUID restaurantId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        return ResponseEntity.ok(reservationService.getTableStatuses(restaurantId, date));
    }

    @GetMapping("/api/v1/restaurants/{restaurantId}/tables/{tableId}/available-slots")
    public ResponseEntity<AvailableSlotsResponse> getAvailableSlots(
            @PathVariable UUID restaurantId,
            @PathVariable UUID tableId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(required = false) UUID excludeReservationId) {
        return ResponseEntity.ok(reservationService.getAvailableSlots(restaurantId, tableId, date, excludeReservationId));
    }

    @PostMapping("/api/v1/reservations")
    public ResponseEntity<ReservationResponse> createReservation(
            @Valid @RequestBody CreateReservationRequest request,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        ReservationResponse response = reservationService.createReservation(request, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @GetMapping("/api/v1/reservations/me")
    public ResponseEntity<MyReservationsOverviewResponse> getMyReservationsOverview(
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.getMyReservationsOverview(userId));
    }

    @GetMapping("/api/v1/reservations/me/history")
    public ResponseEntity<List<ReservationResponse>> getMyReservationsHistory(
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.getMyReservationsHistory(userId));
    }

    @PutMapping("/api/v1/reservations/{id}")
    public ResponseEntity<ReservationResponse> updateReservation(
            @PathVariable UUID id,
            @Valid @RequestBody UpdateReservationRequest request,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.updateReservation(id, request, userId));
    }

    @PatchMapping("/api/v1/reservations/{id}/cancel")
    public ResponseEntity<ReservationResponse> cancelReservation(
            @PathVariable UUID id,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.cancelReservation(id, userId));
    }

    @GetMapping("/api/v1/reservations/me/pending-changes")
    public ResponseEntity<List<PendingChangeResponse>> getPendingChanges(
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.getPendingChangesForUser(userId));
    }

    @PostMapping("/api/v1/reservations/change-requests/{changeRequestId}/accept")
    public ResponseEntity<ReservationResponse> acceptChangeRequest(
            @PathVariable UUID changeRequestId,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.acceptChangeRequest(changeRequestId, userId));
    }

    @PostMapping("/api/v1/reservations/change-requests/{changeRequestId}/decline")
    public ResponseEntity<ReservationResponse> declineChangeRequest(
            @PathVariable UUID changeRequestId,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(reservationService.declineChangeRequest(changeRequestId, userId));
    }

    /**
     * Extrahuje ID přihlášeného zákazníka z autentizačního kontextu.
     *
     * @param authentication Spring Security authentication objekt
     * @return ID přihlášeného uživatele
     */
    private Long extractUserId(Authentication authentication) {
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return user.getId();
    }
}
