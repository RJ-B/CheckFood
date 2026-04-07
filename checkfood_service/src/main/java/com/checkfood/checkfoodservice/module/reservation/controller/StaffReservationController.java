package com.checkfood.checkfoodservice.module.reservation.controller;

import com.checkfood.checkfoodservice.module.reservation.dto.request.ConfirmRecurringReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.ExtendReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.ProposeChangeRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.PendingChangeResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.RecurringReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.ReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.StaffReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.StaffTableResponse;
import com.checkfood.checkfoodservice.module.reservation.service.StaffReservationService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * REST controller pro operace rezervací přístupné personálu restaurace.
 * Přístup vyžaduje roli OWNER, MANAGER nebo STAFF.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/v1/staff")
@PreAuthorize("hasAnyRole('OWNER', 'MANAGER', 'STAFF')")
@RequiredArgsConstructor
public class StaffReservationController {

    private final StaffReservationService staffReservationService;

    @GetMapping("/my-restaurant/tables")
    public ResponseEntity<List<StaffTableResponse>> getRestaurantTables(
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.getTablesForMyRestaurant(email, restaurantId));
    }

    @GetMapping("/my-restaurant/reservations")
    public ResponseEntity<List<StaffReservationResponse>> getReservations(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.getReservationsForMyRestaurant(email, date, restaurantId));
    }

    @PostMapping("/reservations/{id}/confirm")
    public ResponseEntity<ReservationResponse> confirmReservation(
            @PathVariable UUID id,
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.confirmReservation(id, email, restaurantId));
    }

    @PostMapping("/reservations/{id}/reject")
    public ResponseEntity<ReservationResponse> rejectReservation(
            @PathVariable UUID id,
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.rejectReservation(id, email, restaurantId));
    }

    @PostMapping("/reservations/{id}/check-in")
    public ResponseEntity<ReservationResponse> checkInReservation(
            @PathVariable UUID id,
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.checkInReservation(id, email, restaurantId));
    }

    @PostMapping("/reservations/{id}/complete")
    public ResponseEntity<ReservationResponse> completeReservation(
            @PathVariable UUID id,
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.completeReservation(id, email, restaurantId));
    }

    @PutMapping("/reservations/{id}/propose-change")
    public ResponseEntity<PendingChangeResponse> proposeChange(
            @PathVariable UUID id,
            @Valid @RequestBody ProposeChangeRequest request,
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.proposeChange(id, request, email, restaurantId));
    }

    @PatchMapping("/reservations/{id}/extend")
    public ResponseEntity<ReservationResponse> extendReservation(
            @PathVariable UUID id,
            @Valid @RequestBody ExtendReservationRequest request,
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.extendReservation(id, request, email, restaurantId));
    }

    @GetMapping("/recurring-reservations")
    public ResponseEntity<List<RecurringReservationResponse>> getRecurringReservations(
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.getRecurringReservationsForMyRestaurant(email, restaurantId));
    }

    @PostMapping("/recurring-reservations/{id}/confirm")
    public ResponseEntity<RecurringReservationResponse> confirmRecurringReservation(
            @PathVariable UUID id,
            @Valid @RequestBody ConfirmRecurringReservationRequest request,
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.confirmRecurringReservation(id, request, email, restaurantId));
    }

    @PostMapping("/recurring-reservations/{id}/reject")
    public ResponseEntity<RecurringReservationResponse> rejectRecurringReservation(
            @PathVariable UUID id,
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.rejectRecurringReservation(id, email, restaurantId));
    }

    @PostMapping("/recurring-reservations/{id}/cancel")
    public ResponseEntity<RecurringReservationResponse> cancelRecurringReservation(
            @PathVariable UUID id,
            @RequestParam(required = false) UUID restaurantId,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.cancelRecurringReservation(id, email, restaurantId));
    }

    /**
     * Extrahuje e-mail přihlášeného zaměstnance z autentizačního kontextu.
     *
     * @param authentication Spring Security authentication objekt
     * @return e-mail přihlášeného uživatele
     */
    private String extractEmail(Authentication authentication) {
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return user.getEmail();
    }
}
