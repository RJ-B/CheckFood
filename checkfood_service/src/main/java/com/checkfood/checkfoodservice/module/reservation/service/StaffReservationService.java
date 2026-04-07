package com.checkfood.checkfoodservice.module.reservation.service;

import com.checkfood.checkfoodservice.module.reservation.dto.request.ConfirmRecurringReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.ExtendReservationRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.request.ProposeChangeRequest;
import com.checkfood.checkfoodservice.module.reservation.dto.response.PendingChangeResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.RecurringReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.ReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.StaffReservationResponse;
import com.checkfood.checkfoodservice.module.reservation.dto.response.StaffTableResponse;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

/**
 * Rozhraní pro operace rezervací dostupné personálu restaurace.
 * Zahrnuje správu rezervací, check-in, návrhy změn, prodloužení a správu opakovaných rezervací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface StaffReservationService {

    /**
     * Vrátí seznam rezervací restaurace pro daný den.
     *
     * @param userEmail    e-mail přihlášeného zaměstnance
     * @param date         datum dotazu
     * @param restaurantId UUID restaurace, nebo {@code null} pro první přiřazenou restauraci
     * @return seznam rezervací s příznaky dostupných akcí
     */
    List<StaffReservationResponse> getReservationsForMyRestaurant(String userEmail, LocalDate date, UUID restaurantId);

    /**
     * Potvrdí rezervaci čekající na potvrzení.
     *
     * @param reservationId UUID rezervace
     * @param userEmail     e-mail přihlášeného zaměstnance
     * @param restaurantId  UUID restaurace, nebo {@code null}
     * @return response s potvrzenou rezervací
     */
    ReservationResponse confirmReservation(UUID reservationId, String userEmail, UUID restaurantId);

    /**
     * Zamítne rezervaci čekající na potvrzení.
     *
     * @param reservationId UUID rezervace
     * @param userEmail     e-mail přihlášeného zaměstnance
     * @param restaurantId  UUID restaurace, nebo {@code null}
     * @return response se zamítnutou rezervací
     */
    ReservationResponse rejectReservation(UUID reservationId, String userEmail, UUID restaurantId);

    /**
     * Zaregistruje příchod hosta (check-in) u potvrzené rezervace.
     * Check-in je povoleno pouze v okně 30 minut před až 60 minut po začátku rezervace.
     *
     * @param reservationId UUID rezervace
     * @param userEmail     e-mail přihlášeného zaměstnance
     * @param restaurantId  UUID restaurace, nebo {@code null}
     * @return response s rezervací ve stavu CHECKED_IN
     */
    ReservationResponse checkInReservation(UUID reservationId, String userEmail, UUID restaurantId);

    /**
     * Označí rezervaci jako dokončenou a nastaví aktuální čas jako čas ukončení.
     *
     * @param reservationId UUID rezervace
     * @param userEmail     e-mail přihlášeného zaměstnance
     * @param restaurantId  UUID restaurace, nebo {@code null}
     * @return response s dokončenou rezervací
     */
    ReservationResponse completeReservation(UUID reservationId, String userEmail, UUID restaurantId);

    /**
     * Vrátí seznam všech stolů restaurace pro přehled personálu.
     *
     * @param userEmail    e-mail přihlášeného zaměstnance
     * @param restaurantId UUID restaurace, nebo {@code null}
     * @return seznam stolů
     */
    List<StaffTableResponse> getTablesForMyRestaurant(String userEmail, UUID restaurantId);

    /**
     * Vytvoří návrh změny rezervace (jiný stůl nebo čas) odeslaný zákazníkovi ke schválení.
     *
     * @param reservationId UUID rezervace
     * @param request       navrhovaná změna
     * @param userEmail     e-mail přihlášeného zaměstnance
     * @param restaurantId  UUID restaurace, nebo {@code null}
     * @return response s vytvořeným návrhem změny
     */
    PendingChangeResponse proposeChange(UUID reservationId, ProposeChangeRequest request, String userEmail, UUID restaurantId);

    /**
     * Prodlouží dobu trvání aktivní rezervace nastavením nového času ukončení.
     *
     * @param reservationId UUID rezervace
     * @param request       nový čas ukončení
     * @param userEmail     e-mail přihlášeného zaměstnance
     * @param restaurantId  UUID restaurace, nebo {@code null}
     * @return response s aktualizovanou rezervací
     */
    ReservationResponse extendReservation(UUID reservationId, ExtendReservationRequest request, String userEmail, UUID restaurantId);

    /**
     * Potvrdí opakovanou rezervaci a nastaví datum ukončení série; generuje instance.
     *
     * @param id           UUID opakované rezervace
     * @param request      datum ukončení série
     * @param userEmail    e-mail přihlášeného zaměstnance
     * @param restaurantId UUID restaurace, nebo {@code null}
     * @return response s potvrzenou opakovanou rezervací
     */
    RecurringReservationResponse confirmRecurringReservation(UUID id, ConfirmRecurringReservationRequest request, String userEmail, UUID restaurantId);

    /**
     * Zamítne opakovanou rezervaci čekající na potvrzení.
     *
     * @param id           UUID opakované rezervace
     * @param userEmail    e-mail přihlášeného zaměstnance
     * @param restaurantId UUID restaurace, nebo {@code null}
     * @return response se zamítnutou opakovanou rezervací
     */
    RecurringReservationResponse rejectRecurringReservation(UUID id, String userEmail, UUID restaurantId);

    /**
     * Zruší opakovanou rezervaci a všechny její budoucí instance.
     *
     * @param id           UUID opakované rezervace
     * @param userEmail    e-mail přihlášeného zaměstnance
     * @param restaurantId UUID restaurace, nebo {@code null}
     * @return response se zrušenou opakovanou rezervací
     */
    RecurringReservationResponse cancelRecurringReservation(UUID id, String userEmail, UUID restaurantId);

    /**
     * Vrátí seznam opakovaných rezervací restaurace ve všech stavech.
     *
     * @param userEmail    e-mail přihlášeného zaměstnance
     * @param restaurantId UUID restaurace, nebo {@code null}
     * @return seznam opakovaných rezervací
     */
    List<RecurringReservationResponse> getRecurringReservationsForMyRestaurant(String userEmail, UUID restaurantId);
}
