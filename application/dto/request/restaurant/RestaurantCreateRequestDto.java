package com.checkfood.checkfoodservice.application.dto.request.restaurant;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.UUID;

/**
 * DTO pro vytvoření nové restaurace. <br><br>
 *
 * Slouží jako univerzální vstupní model
 * pro:
 * <br>
 * - manuální založení restaurace administrátorem <br>
 * - import restaurace z externích služeb (např. Google Places) <br>
 * - synchronizaci základních dat z cizích systémů <br><br>
 *
 * DTO je navrženo jako rozšiřitelné
 * a připravené na budoucí integrace.
 *
 * VALIDACE <br>
 * - řeší pouze syntaktickou validaci vstupních dat <br>
 * - business validace probíhá v servisní vrstvě <br><br>
 *
 * CROSS-CUTTING PŘIPRAVENOST <br>
 * - validation: jakarta.validation <br>
 * - audit / logging / monitoring: servisní vrstva <br>
 * - externí integrace: client modul <br>
 */
public record RestaurantCreateRequestDto(

        /**
         * Veřejný název restaurace.
         */
        @NotBlank(message = "Název restaurace je povinný.")
        @Size(max = 150, message = "Název restaurace může mít maximálně 150 znaků.")
        String name,

        /**
         * Popis restaurace.
         */
        @Size(max = 500, message = "Popis restaurace může mít maximálně 500 znaků.")
        String description,

        /**
         * Externí identifikátor restaurace
         * (např. Google Places ID).
         *
         * Vyplněno pouze při importu
         * z externí služby.
         */
        String externalPlaceId,

        /**
         * Typ externího zdroje,
         * ze kterého restaurace pochází.
         *
         * Příklady:
         * - GOOGLE_PLACES
         * - PARTNER_API
         */
        String externalProvider,

        /**
         * Interní identifikátor vlastníka / provozovatele.
         *
         * Používá se zejména při:
         * - B2B integracích
         * - napojení na partnerské systémy
         */
        UUID ownerId,

        /**
         * Indikace, zda je restaurace po vytvoření aktivní.
         *
         * Typicky:
         * - FALSE při importu (čeká na schválení)
         * - TRUE při manuálním založení
         */
        @NotNull(message = "Je nutné určit, zda je restaurace aktivní.")
        Boolean active

) {
}
