package com.checkfood.checkfoodservice.application.controller.reservation;

import com.checkfood.checkfoodservice.application.dto.request.reservation.ReservationCancelRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.reservation.ReservationConfirmRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.reservation.ReservationCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.reservation.ReservationListResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.reservation.ReservationResponseDto;
import com.checkfood.checkfoodservice.application.service.reservation.ReservationService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST controller pro správu rezervací.
 *
 * <br><br>
 * ReservationController slouží jako HTTP adaptér
 * aplikační vrstvy pro agregát Reservation.
 *
 * <br><br>
 * Zodpovědnosti controlleru:
 * <br>
 * - mapování HTTP požadavků na aplikační service,
 * <br>
 * - spuštění validace vstupních DTO,
 * <br>
 * - vrácení response DTO klientovi.
 *
 * <br><br>
 * Controller:
 * <br>
 * - neobsahuje business logiku,
 * <br>
 * - nepracuje s entitami ani repository,
 * <br>
 * - neřídí transakce,
 * <br>
 * - neřeší audit ani autorizaci.
 *
 * <br><br>
 * Cross-cutting připravenost:
 * <br>
 * - validation: @Valid (aktivní),
 * <br>
 * - security: připraveno pro @PreAuthorize (TODO),
 * <br>
 * - logging: řešeno globálně (filter / interceptor),
 * <br>
 * - exception handling: řešeno přes @ControllerAdvice.
 */
@RestController
@RequestMapping("/api/reservations")
@RequiredArgsConstructor
public class ReservationController {

    /**
     * Aplikační service pro práci s agregátem Reservation.
     *
     * Controller komunikuje výhradně
     * přes rozhraní service vrstvy.
     */
    private final ReservationService reservationService;

    /**
     * Vytvoří novou rezervaci.
     *
     * <br><br>
     * HTTP:
     * <br>
     * POST /api/reservations
     *
     * <br><br>
     * Cross-cutting:
     * <br>
     * - validation: automaticky spuštěna (@Valid),
     * <br>
     * - security: TODO – veřejný endpoint / přihlášený uživatel,
     * <br>
     * - audit: řešeno v service vrstvě,
     * <br>
     * - transaction: řešeno v service vrstvě.
     *
     * @param request vstupní DTO pro vytvoření rezervace
     * @return detail nově vytvořené rezervace
     */
    @PostMapping
    public ReservationResponseDto createReservation(
            @Valid @RequestBody ReservationCreateRequestDto request
    ) {
        // TODO security: případné omezení podle kontextu (USER / ANONYMOUS)
        return reservationService.createReservation(request);
    }

    /**
     * Potvrdí existující rezervaci.
     *
     * <br><br>
     * HTTP:
     * <br>
     * POST /api/reservations/{reservationId}/confirm
     *
     * <br><br>
     * Používá se typicky:
     * <br>
     * - obsluhou restaurace,
     * <br>
     * - automatickým potvrzením systému.
     *
     * <br><br>
     * Controller:
     * <br>
     * - neověřuje aktuální stav rezervace,
     * <br>
     * - neřeší přechody stavů.
     *
     * @param reservationId identifikátor rezervace
     * @param request potvrzovací DTO
     * @return aktualizovaný detail rezervace
     */
    @PostMapping("/{reservationId}/confirm")
    public ReservationResponseDto confirmReservation(
            @PathVariable UUID reservationId,
            @Valid @RequestBody ReservationConfirmRequestDto request
    ) {
        // TODO security: omezení přístupu (STAFF / SYSTEM)
        return reservationService.confirmReservation(reservationId, request);
    }

    /**
     * Zruší existující rezervaci.
     *
     * <br><br>
     * HTTP:
     * <br>
     * POST /api/reservations/{reservationId}/cancel
     *
     * <br><br>
     * Rezervace může být zrušena:
     * <br>
     * - zákazníkem,
     * <br>
     * - obsluhou,
     * <br>
     * - systémem (např. timeout).
     *
     * <br><br>
     * Business pravidla zrušení
     * jsou řešena výhradně v service vrstvě.
     *
     * @param reservationId identifikátor rezervace
     * @param request DTO se zrušovacími informacemi
     */
    @PostMapping("/{reservationId}/cancel")
    public void cancelReservation(
            @PathVariable UUID reservationId,
            @Valid @RequestBody ReservationCancelRequestDto request
    ) {
        // TODO security: kontrola oprávnění ke zrušení rezervace
        reservationService.cancelReservation(reservationId, request);
    }

    /**
     * Vrátí detail rezervace.
     *
     * <br><br>
     * HTTP:
     * <br>
     * GET /api/reservations/{reservationId}
     *
     * <br><br>
     * Používá se:
     * <br>
     * - pro náhled rezervace zákazníkem,
     * <br>
     * - pro obsluhu restaurace,
     * <br>
     * - pro administraci.
     *
     * @param reservationId identifikátor rezervace
     * @return detail rezervace
     */
    @GetMapping("/{reservationId}")
    public ReservationResponseDto getReservationDetail(
            @PathVariable UUID reservationId
    ) {
        return reservationService.getReservationDetail(reservationId);
    }

    /**
     * Vrátí seznam rezervací.
     *
     * <br><br>
     * HTTP:
     * <br>
     * GET /api/reservations
     *
     * <br><br>
     * Poznámka:
     * <br>
     * V budoucnu může být rozšířeno o:
     * <br>
     * - filtrování podle restaurace,
     * <br>
     * - filtrování podle data,
     * <br>
     * - filtrování podle stavu rezervace.
     *
     * @return seznam rezervací
     */
    @GetMapping
    public List<ReservationListResponseDto> getReservations() {
        return reservationService.getReservations();
    }
}
