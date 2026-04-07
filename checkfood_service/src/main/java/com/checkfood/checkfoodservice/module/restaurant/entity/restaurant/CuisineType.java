package com.checkfood.checkfoodservice.module.restaurant.entity.restaurant;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Definuje kategorie kuchyní pro účely kategorizace a filtrování restaurací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@RequiredArgsConstructor
public enum CuisineType {
    ITALIAN("Italská"),
    CZECH("Česká"),
    ASIAN("Asijská"),
    VIETNAMESE("Vietnamská"),
    INDIAN("Indická"),
    FRENCH("Francouzská"),
    MEXICAN("Mexická"),
    AMERICAN("Americká"),
    MEDITERRANEAN("Středomořská"),
    JAPANESE_SUSHI("Sushi a japonská"),
    BURGER("Burgery"),
    PIZZA("Pizza"),
    VEGAN_VEGETARIAN("Vegetariánská a veganská"),
    INTERNATIONAL("Mezinárodní"),
    STREET_FOOD("Street food"),
    KEBAB("Kebab"),
    CAFE_DESSERT("Kavárna a dezerty"),
    OTHER("Ostatní");

    /**
     * Lidsky čitelný název v češtině (pro interní logiku nebo defaultní zobrazení).
     */
    private final String displayName;
}