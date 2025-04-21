package com.example.CheckFood.domain.reservation;

import java.util.List;

public interface ReservationService {
    ReservationDto createReservation(ReservationDto dto);
    List<ReservationDto> getAllReservations();
    ReservationDto getReservationById(Long id);
    void deleteReservation(Long id);
}
