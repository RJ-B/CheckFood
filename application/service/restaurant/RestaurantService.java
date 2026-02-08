package com.checkfood.checkfoodservice.application.service.restaurant;

import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantTableUpdateRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantUpdateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.restaurant.RestaurantDetailResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.restaurant.RestaurantListResponseDto;

import java.util.List;
import java.util.UUID;

/**
 * Aplikační service pro práci s agregátem Restaurant.
 *
 * Tato service představuje aplikační vstupní bod
 * pro veškeré use-cases spojené s restaurací.
 * <br><br>
 * Zodpovědnosti:
 * <br>
 * - vytvoření a aktualizace restaurace,
 * <br>
 * - změna životního cyklu restaurace,
 * <br>
 * - správa fyzických stolů restaurace,
 * <br>
 * - udržení konzistence agregátu.
 *
 * <br><br>
 * Service neřeší:
 * <br>
 * - HTTP vrstvu,
 * <br>
 * - perzistenční detaily,
 * <br>
 * - mapování JSON ↔ DTO.
 */
public interface RestaurantService {

    /**
     * Vytvoří novou restauraci.
     *
     * <br><br>
     * Součástí vytvoření je:
     * <br>
     * - inicializace výchozího stavu,
     * <br>
     * - validace vstupních dat,
     * <br>
     * - persistování agregátu.
     *
     * @param request vstupní data restaurace
     * @return detail nově vytvořené restaurace
     */
    RestaurantDetailResponseDto createRestaurant(RestaurantCreateRequestDto request);

    /**
     * Aktualizuje základní informace restaurace.
     *
     * @param restaurantId identifikátor restaurace
     * @param request aktualizační data
     * @return aktualizovaný detail restaurace
     */
    RestaurantDetailResponseDto updateRestaurant(
            UUID restaurantId,
            RestaurantUpdateRequestDto request
    );

    /**
     * Změní aktivní stav restaurace.
     *
     * <br><br>
     * Slouží k:
     * <br>
     * - dočasnému vypnutí,
     * <br>
     * - archivaci,
     * <br>
     * - znovuaktivaci restaurace.
     *
     * @param restaurantId identifikátor restaurace
     * @param active nový stav
     */
    void changeRestaurantActiveState(UUID restaurantId, boolean active);

    /**
     * Aktualizuje konfiguraci stolů restaurace.
     *
     * <br><br>
     * Metoda řídí:
     * <br>
     * - přidání nových stolů,
     * <br>
     * - aktualizaci existujících,
     * <br>
     * - deaktivaci odebraných stolů.
     *
     * @param restaurantId identifikátor restaurace
     * @param tables seznam stolů
     */
    void updateRestaurantTables(
            UUID restaurantId,
            List<RestaurantTableUpdateRequestDto> tables
    );

    /**
     * Vrátí detail restaurace.
     *
     * @param restaurantId identifikátor restaurace
     * @return detail restaurace
     */
    RestaurantDetailResponseDto getRestaurantDetail(UUID restaurantId);

    /**
     * Vrátí seznam restaurací.
     *
     * <br><br>
     * Typicky používané pro:
     * <br>
     * - administraci,
     * <br>
     * - výpis v aplikaci.
     *
     * @return seznam restaurací
     */
    List<RestaurantListResponseDto> getRestaurants();
}
