package com.checkfood.checkfoodservice.application.service.reservation;

import com.checkfood.checkfoodservice.application.dto.request.reservation.ReservationCancelRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.reservation.ReservationConfirmRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.reservation.ReservationCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.reservation.ReservationListResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.reservation.ReservationResponseDto;

import java.util.List;
import java.util.UUID;

/**
 * Aplikační service pro práci s agregátem Reservation.
 *
 * <br><br>
 * Reservation reprezentuje rezervaci zákazníka
 * v konkrétní restauraci a čase.
 *
 * <br><br>
 * Service zodpovídá za:
 * <br>
 * - vytvoření rezervace,
 * <br>
 * - potvrzení rezervace,
 * <br>
 * - zrušení rezervace,
 * <br>
 * - čtení rezervací.
 *
 * <br><br>
 * Service neřídí restauraci ani stoly,
 * pouze pracuje s jejich identifikátory.
 */
public interface ReservationService {

    /**
     * Vytvoří novou rezervaci.
     *
     * @param request vstupní data rezervace
     * @return detail rezervace
     */
    ReservationResponseDto createReservation(ReservationCreateRequestDto request);

    /**
     * Potvrdí existující rezervaci.
     *
     * @param reservationId identifikátor rezervace
     * @param request potvrzovací data
     * @return aktualizovaný detail rezervace
     */
    ReservationResponseDto confirmReservation(
            UUID reservationId,
            ReservationConfirmRequestDto request
    );

    /**
     * Zruší rezervaci.
     *
     * @param reservationId identifikátor rezervace
     * @param request důvod zrušení
     */
    void cancelReservation(
            UUID reservationId,
            ReservationCancelRequestDto request
    );

    /**
     * Vrátí detail rezervace.
     *
     * @param reservationId identifikátor rezervace
     * @return detail rezervace
     */
    ReservationResponseDto getReservationDetail(UUID reservationId);

    /**
     * Vrátí seznam rezervací.
     *
     * <br><br>
     * Typicky:
     * <br>
     * - pro restauraci,
     * <br>
     * - pro administraci.
     *
     * @return seznam rezervací
     */
    List<ReservationListResponseDto> getReservations();
}
