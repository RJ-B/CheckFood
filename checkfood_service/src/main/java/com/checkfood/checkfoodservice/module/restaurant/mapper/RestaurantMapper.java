package com.checkfood.checkfoodservice.module.restaurant.mapper;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.SpecialDayDto;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantMarkerResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.SpecialDay;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * MapStruct mapper pro konverzi entre entitou {@link Restaurant} a příslušnými DTO.
 * Deleguje mapování adresy a provozní doby na {@link AddressMapper} a {@link OpeningHoursMapper}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Mapper(
        componentModel = "spring",
        uses = {AddressMapper.class, OpeningHoursMapper.class},
        unmappedTargetPolicy = ReportingPolicy.IGNORE
)
public interface RestaurantMapper {

    /**
     * Převede entitu restaurace na detailní response DTO.
     *
     * @param restaurant entita restaurace
     * @return response DTO
     */
    RestaurantResponse toResponse(Restaurant restaurant);

    /**
     * Převede entitu výjimečného dne na DTO.
     *
     * @param specialDay entita výjimečného dne
     * @return DTO výjimečného dne
     */
    SpecialDayDto toSpecialDayDto(SpecialDay specialDay);

    /**
     * Převede seznam entit výjimečných dní na seznam DTO.
     *
     * @param specialDays seznam entit výjimečných dní
     * @return seznam DTO
     */
    List<SpecialDayDto> toSpecialDayDtoList(List<SpecialDay> specialDays);

    /**
     * Hromadný převod entit restaurací na seznam response DTO.
     *
     * @param restaurants seznam entit restaurací
     * @return seznam response DTO
     */
    List<RestaurantResponse> toResponseList(List<Restaurant> restaurants);

    /**
     * Převede request DTO na entitu restaurace. Systémová pole (id, status, rating) jsou ignorována.
     *
     * @param request request DTO
     * @return entita restaurace
     */
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "ownerId", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "active", ignore = true)
    @Mapping(target = "rating", ignore = true)
    @Mapping(target = "tables", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    Restaurant toEntity(RestaurantRequest request);

    /**
     * Mapuje surový řádek z databáze (Object[]) na strukturované marker DTO.
     * Indexy odpovídají pořadí sloupců v SQL dotazu v RestaurantRepository.
     *
     * @param row surový řádek výsledku nativního SQL dotazu
     * @return marker DTO, nebo {@code null} pokud je row prázdný nebo krátký
     */
    default RestaurantMarkerResponse toMarkerResponse(Object[] row) {
        if (row == null || row.length < 4) {
            return null;
        }

        return RestaurantMarkerResponse.builder()
                .id((UUID) row[0])
                .latitude(((Number) row[1]).doubleValue())
                .longitude(((Number) row[2]).doubleValue())
                .count(((Number) row[3]).intValue())
                .name(row.length > 4 && row[4] != null ? row[4].toString() : null)
                .logoUrl(row.length > 5 && row[5] != null ? row[5].toString() : null)
                .build();
    }

    /**
     * Hromadné mapování surových výsledků shlukování na seznam marker DTO.
     *
     * @param rows seznam surových řádků z databáze
     * @return seznam marker DTO, nebo {@code null} pokud je vstup null
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