package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Odlehčená odpověď pro endpoint /markers-version.
 * Klient ji může použít k detekci, zda je jeho lokální cache markerů stale.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MarkerVersionResponse {

    /** Aktuální verze sady markerů. */
    private long version;
}
