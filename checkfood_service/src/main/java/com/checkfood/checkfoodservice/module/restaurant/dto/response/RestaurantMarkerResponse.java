package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Odlehčené DTO pro přenos dat o markerech a shlucích na mapu.
 * Navrženo pro vysoký výkon při hromadném přenosu dat.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RestaurantMarkerResponse {

    /**
     * ID konkrétní restaurace.
     * Hodnota je NULL, pokud se jedná o shluk (cluster) více restaurací.
     */
    private UUID id;

    /**
     * Zeměpisná šířka těžiště shluku nebo pozice restaurace.
     */
    private double latitude;

    /**
     * Zeměpisná délka těžiště shluku nebo pozice restaurace.
     */
    private double longitude;

    /**
     * Počet restaurací v daném bodě.
     * Hodnota 1 znamená standardní marker (pin), hodnota > 1 znamená cluster.
     */
    private int count;

    /**
     * Název restaurace. NULL pro clustery (count > 1).
     */
    private String name;

    /**
     * URL loga restaurace. NULL pro clustery (count > 1).
     */
    private String logoUrl;

    /**
     * Určuje, zda tento bod reprezentuje shluk více restaurací.
     *
     * @return {@code true} pokud {@code count > 1}, jinak {@code false}
     */
    public boolean isCluster() {
        return count > 1;
    }
}