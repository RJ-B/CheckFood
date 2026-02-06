package com.checkfood.checkfoodservice.application.dto.response.restaurant;

import java.util.UUID;

/**
 * DTO reprezentující stůl restaurace.
 *
 * DTO je používáno výhradně jako součást
 * {@link RestaurantResponseDto}.
 *
 * Neexistuje samostatné API pro práci
 * se stolem mimo kontext restaurace.
 *
 * Tento přístup:
 * <br> - zachovává hranice agregátu
 * <br> - zjednodušuje autorizaci
 * <br> - minimalizuje počet dotazů
 */
public record RestaurantTableResponseDto(

        UUID id,

        String label,

        int capacity,

        boolean active

) {
}
