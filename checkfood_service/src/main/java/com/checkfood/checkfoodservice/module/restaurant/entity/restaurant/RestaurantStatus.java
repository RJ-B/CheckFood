package com.checkfood.checkfoodservice.module.restaurant.entity.restaurant;

/**
 * Definuje provozní stav restaurace v rámci platformy.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum RestaurantStatus {
    /** Restaurace je v přípravě, nahrávají se data, není viditelná pro hosty. */
    PENDING,

    /** Restaurace je aktivní a plně funkční. */
    ACTIVE,

    /** Restaurace je dočasně uzavřena (např. rekonstrukce). */
    CLOSED,

    /** Restaurace již s platformou nespolupracuje, data jsou zachována pro historii. */
    ARCHIVED,

    /**
     * Zkušební restaurace vytvořená automaticky při registraci majitele.
     * Není viditelná pro hosty (is_active = false), slouží k dokončení onboardingu.
     */
    TRIAL
}