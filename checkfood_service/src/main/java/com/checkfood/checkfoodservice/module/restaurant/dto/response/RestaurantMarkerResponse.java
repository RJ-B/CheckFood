package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

/**
 * Odlehčené DTO pro přenos dat o markerech a shlucích na mapu.
 * Navrženo pro vysoký výkon při hromadném přenosu dat.
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
     * Pomocný getter pro frontend, který určuje, zda se má zobrazit cluster.
     */
    public boolean isCluster() {
        return count > 1;
    }
}