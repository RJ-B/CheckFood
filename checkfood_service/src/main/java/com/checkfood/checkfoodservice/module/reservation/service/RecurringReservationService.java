package com.checkfood.checkfoodservice.module.reservation.service;

import com.checkfood.checkfoodservice.module.reservation.dto.request.CreateRecurringReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.RecurringReservationResponse;

import java.util.List;
import java.util.UUID;

/**
 * Rozhraní pro operace opakovaných rezervací přístupné zákazníkovi.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface RecurringReservationService {

    /**
     * Vytvoří novou opakovanou rezervaci ve stavu {@code PENDING_CONFIRMATION}.
     * Rezervace čeká na potvrzení personálem restaurace.
     *
     * @param request data nové opakované rezervace
     * @param userId  ID zákazníka
     * @return response s vytvořenou opakovanou rezervací
     */
    RecurringReservationResponse createRecurringReservation(CreateRecurringReservationRequest request, Long userId);

    /**
     * Vrátí seznam opakovaných rezervací přihlášeného zákazníka.
     *
     * @param userId ID zákazníka
     * @return seznam opakovaných rezervací seřazený od nejnovějších
     */
    List<RecurringReservationResponse> getMyRecurringReservations(Long userId);

    /**
     * Zruší opakovanou rezervaci zákazníka a všechny její budoucí instance.
     *
     * @param id     UUID opakované rezervace
     * @param userId ID zákazníka (pro ověření vlastnictví)
     * @return response se zrušenou opakovanou rezervací
     */
    RecurringReservationResponse cancelRecurringReservation(UUID id, Long userId);
}
