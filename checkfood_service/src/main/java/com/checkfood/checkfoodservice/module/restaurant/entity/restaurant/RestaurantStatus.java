package com.checkfood.checkfoodservice.module.restaurant.entity.restaurant;

/**
 * Definuje provozní stav restaurace v rámci platformy.
 */
public enum RestaurantStatus {
    /** Restaurace je v přípravě, nahrávají se data, není viditelná pro hosty. */
    PENDING,

    /** Restaurace je aktivní a plně funkční. */
    ACTIVE,

    /** Restaurace je dočasně uzavřena (např. rekonstrukce). */
    CLOSED,

    /** Restaurace již s platformou nespolupracuje, data jsou zachována pro historii. */
    ARCHIVED
}