package com.checkfood.checkfoodservice.module.reservation.controller;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateRecurringReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.RecurringReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.service.RecurringReservationService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST controller pro zákaznické operace s opakovanými rezervacemi.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/v1/recurring-reservations")
@RequiredArgsConstructor
public class RecurringReservationController {

    private final RecurringReservationService recurringReservationService;

    @PostMapping
    public ResponseEntity<RecurringReservationResponse> createRecurringReservation(
            @Valid @RequestBody CreateRecurringReservationRequest request,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return new ResponseEntity<>(
                recurringReservationService.createRecurringReservation(request, userId),
                HttpStatus.CREATED);
    }

    @GetMapping("/me")
    public ResponseEntity<List<RecurringReservationResponse>> getMyRecurringReservations(
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(recurringReservationService.getMyRecurringReservations(userId));
    }

    @PatchMapping("/{id}/cancel")
    public ResponseEntity<RecurringReservationResponse> cancelRecurringReservation(
            @PathVariable UUID id,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(recurringReservationService.cancelRecurringReservation(id, userId));
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
