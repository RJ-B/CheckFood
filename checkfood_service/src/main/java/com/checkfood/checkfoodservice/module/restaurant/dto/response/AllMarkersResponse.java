package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Odpověď pro endpoint /all-markers — obsahuje verzi a seznam všech aktivních markerů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AllMarkersResponse {

    /** Verze sady markerů — inkrementuje se při každé změně restaurace. */
    private long version;

    /** Seznam všech aktivních markerů (count=1 pro každou restauraci). */
    private List<RestaurantMarkerResponse> data;
}
