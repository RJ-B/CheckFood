package com.checkfood.checkfoodservice.module.reservation.service;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.UpdateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.*;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public interface ReservationService {

    ReservationSceneResponse getReservationScene(UUID restaurantId);

    TableStatusResponse getTableStatuses(UUID restaurantId, LocalDate date);

    AvailableSlotsResponse getAvailableSlots(UUID restaurantId, UUID tableId, LocalDate date, UUID excludeReservationId);

    ReservationResponse createReservation(CreateReservationRequest request, Long userId);

    MyReservationsOverviewResponse getMyReservationsOverview(Long userId);

    List<ReservationResponse> getMyReservationsHistory(Long userId);

    ReservationResponse updateReservation(UUID id, UpdateReservationRequest request, Long userId);

    ReservationResponse cancelReservation(UUID id, Long userId);

    ReservationResponse confirmReservation(UUID id, UUID staffOwnerId);

    ReservationResponse rejectReservation(UUID id, UUID staffOwnerId);
}
