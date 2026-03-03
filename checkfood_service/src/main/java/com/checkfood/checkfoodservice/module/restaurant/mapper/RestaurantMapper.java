package com.checkfood.checkfoodservice.module.restaurant.mapper;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantMarkerResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Mapper(
        componentModel = "spring",
        uses = {AddressMapper.class, OpeningHoursMapper.class},
        unmappedTargetPolicy = ReportingPolicy.IGNORE
)
public interface RestaurantMapper {

    // --- Standardní mapování ---

    RestaurantResponse toResponse(Restaurant restaurant);

    List<RestaurantResponse> toResponseList(List<Restaurant> restaurants);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "ownerId", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "active", ignore = true)
    @Mapping(target = "rating", ignore = true)
    @Mapping(target = "tables", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    Restaurant toEntity(RestaurantRequest request);

    // --- Nové mapování pro prostorové shlukování (Clustering) ---

    /**
     * Mapuje surový řádek z databáze (Object[]) na strukturované DTO.
     * Indexy odpovídají pořadí v SQL dotazu v RestaurantRepository.
     */
    default RestaurantMarkerResponse toMarkerResponse(Object[] row) {
        if (row == null || row.length < 4) {
            return null;
        }

        return RestaurantMarkerResponse.builder()
                .id((UUID) row[0])
                .latitude(((Number) row[1]).doubleValue())
                .longitude(((Number) row[2]).doubleValue())
                .count(((Number) row[3]).intValue()) // Bezpečný převod z Long/Integer
                .build();
    }

    /**
     * Hromadné mapování výsledků shlukování.
     */
    default List<RestaurantMarkerResponse> toMarkerResponseList(List<Object[]> rows) {
        if (rows == null) {
            return null;
        }
        return rows.stream()
                .map(this::toMarkerResponse)
                .collect(Collectors.toList());
    }
}