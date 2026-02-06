package com.checkfood.checkfoodservice.application.dto.request.restaurant;

import jakarta.validation.constraints.Size;

/**
 * DTO pro aktualizaci základních údajů restaurace. <br><br>
 *
 * Umožňuje měnit pouze:
 * - název <br>
 * - popis <br>
 * - aktivní stav <br><br>
 *
 * Neumožňuje měnit:
 * - stav restaurace (status) <br>
 * - vazby na jiné domény <br><br>
 *
 * VALIDACE <br>
 * - povoluje částečnou aktualizaci <br>
 * - null hodnoty jsou ignorovány v mapperu <br>
 */
public record RestaurantUpdateRequestDto(

        @Size(max = 150, message = "Název restaurace může mít maximálně 150 znaků.")
        String name,

        @Size(max = 500, message = "Popis restaurace může mít maximálně 500 znaků.")
        String description,

        Boolean active

) {
}
