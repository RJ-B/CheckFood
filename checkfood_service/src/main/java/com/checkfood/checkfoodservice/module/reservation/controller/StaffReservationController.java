package com.checkfood.checkfoodservice.module.reservation.controller;

import com.checkfood.checkfoodservice.module.reservation.dto.response.ReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.StaffReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.service.StaffReservationService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/staff")
@PreAuthorize("hasAnyRole('OWNER', 'MANAGER', 'STAFF')")
@RequiredArgsConstructor
public class StaffReservationController {

    private final StaffReservationService staffReservationService;

    @GetMapping("/my-restaurant/reservations")
    public ResponseEntity<List<StaffReservationResponse>> getReservations(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.getReservationsForMyRestaurant(email, date));
    }

    @PostMapping("/reservations/{id}/confirm")
    public ResponseEntity<ReservationResponse> confirmReservation(
            @PathVariable UUID id,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.confirmReservation(id, email));
    }

    @PostMapping("/reservations/{id}/reject")
    public ResponseEntity<ReservationResponse> rejectReservation(
            @PathVariable UUID id,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.rejectReservation(id, email));
    }

    @PostMapping("/reservations/{id}/check-in")
    public ResponseEntity<ReservationResponse> checkInReservation(
            @PathVariable UUID id,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.checkInReservation(id, email));
    }

    @PostMapping("/reservations/{id}/complete")
    public ResponseEntity<ReservationResponse> completeReservation(
            @PathVariable UUID id,
            Authentication authentication) {
        String email = extractEmail(authentication);
        return ResponseEntity.ok(staffReservationService.completeReservation(id, email));
    }

    private String extractEmail(Authentication authentication) {
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return user.getEmail();
    }
}
