package com.checkfood.checkfoodservice.application.service.reservation;

import com.checkfood.checkfoodservice.application.dto.request.reservation.ReservationCancelRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.reservation.ReservationConfirmRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.reservation.ReservationCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.reservation.ReservationListResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.reservation.ReservationResponseDto;
import com.checkfood.checkfoodservice.application.entity.reservation.Reservation;
import com.checkfood.checkfoodservice.application.entity.reservation.ReservationStatus;
import com.checkfood.checkfoodservice.application.mapper.reservation.ReservationMapper;
import com.checkfood.checkfoodservice.application.repository.reservation.ReservationRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Implementace aplikační service
 * pro agregát Reservation.
 *
 * <br><br>
 * Třída definuje transakční hranice
 * a životní cyklus rezervace.
 *
 * <br><br>
 * Cross-cutting připravenost:
 * <br>
 * - validace časů,
 * <br>
 * - bezpečnost,
 * <br>
 * - audit,
 * <br>
 * - doménové události.
 */
@Service
@RequiredArgsConstructor
@Transactional
public class ReservationServiceImpl implements ReservationService {

    private final ReservationRepository reservationRepository;
    private final ReservationMapper reservationMapper;

    @Override
    public ReservationResponseDto createReservation(ReservationCreateRequestDto request) {

        // TODO validation: validace času rezervace
        // TODO validation: ověření existence restaurace a stolů
        // TODO security: anonymní / přihlášený uživatel

        Reservation reservation = reservationMapper.toEntity(request);

        reservation.setStatus(ReservationStatus.CREATED);

        Reservation saved = reservationRepository.save(reservation);

        // TODO event: ReservationCreatedEvent
        // TODO audit: vytvoření rezervace

        return reservationMapper.toResponse(saved);
    }

    @Override
    public ReservationResponseDto confirmReservation(
            UUID reservationId,
            ReservationConfirmRequestDto request
    ) {
        Reservation reservation = getReservationOrThrow(reservationId);

        // TODO business rule: lze potvrdit pouze CREATED
        reservation.setStatus(ReservationStatus.CONFIRMED);

        // TODO audit: potvrzení rezervace
        // TODO event: ReservationConfirmedEvent

        return reservationMapper.toResponse(reservation);
    }

    @Override
    public void cancelReservation(
            UUID reservationId,
            ReservationCancelRequestDto request
    ) {
        Reservation reservation = getReservationOrThrow(reservationId);

        // TODO business rule: nelze rušit ukončenou rezervaci
        reservation.setStatus(ReservationStatus.CANCELLED);

        // TODO audit: zrušení rezervace
        // TODO event: ReservationCancelledEvent
    }

    @Override
    @Transactional(Transactional.TxType.SUPPORTS)
    public ReservationResponseDto getReservationDetail(UUID reservationId) {
        return reservationMapper.toResponse(getReservationOrThrow(reservationId));
    }

    @Override
    @Transactional(Transactional.TxType.SUPPORTS)
    public List<ReservationListResponseDto> getReservations() {
        return reservationMapper.toListResponse(reservationRepository.findAll());
    }

    private Reservation getReservationOrThrow(UUID reservationId) {
        return reservationRepository.findById(reservationId)
                .orElseThrow(() ->
                        new IllegalArgumentException("Reservation not found: " + reservationId)
                );
    }
}
