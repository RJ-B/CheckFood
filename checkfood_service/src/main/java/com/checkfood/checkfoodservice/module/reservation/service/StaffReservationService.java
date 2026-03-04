package com.checkfood.checkfoodservice.module.reservation.service;

import com.checkfood.checkfoodservice.module.reservation.dto.response.ReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.StaffReservationResponse;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public interface StaffReservationService {

    List<StaffReservationResponse> getReservationsForMyRestaurant(String userEmail, LocalDate date);

    ReservationResponse confirmReservation(UUID reservationId, String userEmail);

    ReservationResponse rejectReservation(UUID reservationId, String userEmail);

    ReservationResponse checkInReservation(UUID reservationId, String userEmail);

    ReservationResponse completeReservation(UUID reservationId, String userEmail);
}
