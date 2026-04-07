package com.checkfood.checkfoodservice.module.reservation.service;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.UpdateReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.*;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * Interface pro operace rezervací přístupné zákazníkovi.
 * Zahrnuje správu rezervací, dotazy na dostupné sloty a zpracování návrhů změn.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface ReservationService {

    /**
     * Vrátí data panoramatické scény restaurace s pozicemi stolů.
     *
     * @param restaurantId UUID restaurace
     * @return response s URL panoramatu a seznamem stolů
     */
    ReservationSceneResponse getReservationScene(UUID restaurantId);

    /**
     * Vrátí stav obsazenosti všech stolů restaurace pro daný den.
     *
     * @param restaurantId UUID restaurace
     * @param date         datum dotazu
     * @return response se stavem každého stolu (FREE / RESERVED / OCCUPIED)
     */
    TableStatusResponse getTableStatuses(UUID restaurantId, LocalDate date);

    /**
     * Vrátí seznam dostupných časových slotů pro rezervaci konkrétního stolu.
     *
     * @param restaurantId          UUID restaurace
     * @param tableId               UUID stolu
     * @param date                  datum dotazu
     * @param excludeReservationId  UUID rezervace která má být vynechána z kolizní kontroly (při úpravě), nebo {@code null}
     * @return response se seznamem dostupných začátků slotů
     */
    AvailableSlotsResponse getAvailableSlots(UUID restaurantId, UUID tableId, LocalDate date, UUID excludeReservationId);

    /**
     * Vytvoří novou rezervaci pro přihlášeného zákazníka.
     *
     * @param request data nové rezervace
     * @param userId  ID zákazníka
     * @return response s vytvořenou rezervací
     */
    ReservationResponse createReservation(CreateReservationRequest request, Long userId);

    /**
     * Vrátí přehled rezervací zákazníka (nadcházející + omezená historie).
     *
     * @param userId ID zákazníka
     * @return response s nadcházejícími rezervacemi a historií
     */
    MyReservationsOverviewResponse getMyReservationsOverview(Long userId);

    /**
     * Vrátí kompletní historii rezervací zákazníka.
     *
     * @param userId ID zákazníka
     * @return seznam historických rezervací
     */
    List<ReservationResponse> getMyReservationsHistory(Long userId);

    /**
     * Aktualizuje existující rezervaci zákazníka.
     *
     * @param id      UUID rezervace
     * @param request nová data rezervace
     * @param userId  ID zákazníka (pro ověření vlastnictví)
     * @return response s aktualizovanou rezervací
     */
    ReservationResponse updateReservation(UUID id, UpdateReservationRequest request, Long userId);

    /**
     * Zruší rezervaci zákazníka.
     *
     * @param id     UUID rezervace
     * @param userId ID zákazníka (pro ověření vlastnictví)
     * @return response se zrušenou rezervací
     */
    ReservationResponse cancelReservation(UUID id, Long userId);

    /**
     * Vrátí seznam nevyřízených návrhů změn rezervací zákazníka.
     *
     * @param userId ID zákazníka
     * @return seznam návrhů čekajících na rozhodnutí
     */
    List<PendingChangeResponse> getPendingChangesForUser(Long userId);

    /**
     * Zákazník přijme návrh změny rezervace navržený personálem.
     *
     * @param changeRequestId UUID návrhu změny
     * @param userId          ID zákazníka (pro ověření vlastnictví)
     * @return response s aktualizovanou rezervací
     */
    ReservationResponse acceptChangeRequest(UUID changeRequestId, Long userId);

    /**
     * Zákazník odmítne návrh změny rezervace navržený personálem.
     * Odmítnutí způsobí zrušení původní rezervace.
     *
     * @param changeRequestId UUID návrhu změny
     * @param userId          ID zákazníka (pro ověření vlastnictví)
     * @return response se zrušenou rezervací
     */
    ReservationResponse declineChangeRequest(UUID changeRequestId, Long userId);
}
