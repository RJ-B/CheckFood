package com.checkfood.checkfoodservice.application.mapper.restaurant;

import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantTableUpdateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.restaurant.RestaurantTableResponseDto;
import com.checkfood.checkfoodservice.application.entity.restaurant.table.RestaurantTable;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;
import java.util.UUID;

/**
 * Mapper zodpovědný za převod mezi
 * RestaurantTable entitou a DTO objekty.
 *
 * <br><br>
 * Mapper neobsahuje žádnou business logiku
 * a slouží výhradně k transformaci dat
 * mezi aplikačními vrstvami.
 */
@Mapper(componentModel = "spring")
public interface RestaurantTableMapper {

    /**
     * Převede DTO na novou entitu fyzického stolu.
     *
     * <br><br>
     * Vlastnosti:
     * <br>
     * - ID je ignorováno,
     * <br>
     * - restaurace je nastavena explicitně,
     * <br>
     * - nový stůl je implicitně aktivní.
     *
     * @param request vstupní DTO
     * @param restaurantId identifikátor restaurace
     * @return nová entita stolu
     */
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "restaurantId", source = "restaurantId")
    @Mapping(target = "active", constant = "true")
    RestaurantTable toEntity(
            RestaurantTableUpdateRequestDto request,
            UUID restaurantId
    );

    /**
     * Převede seznam DTO objektů
     * na seznam entit fyzických stolů.
     *
     * <br><br>
     * Slouží pro hromadnou aktualizaci
     * konfigurace stolů restaurace.
     *
     * @param tables seznam DTO
     * @param restaurantId identifikátor restaurace
     * @return seznam entit stolů
     */
    default List<RestaurantTable> toEntities(
            List<RestaurantTableUpdateRequestDto> tables,
            UUID restaurantId
    ) {
        return tables.stream()
                .map(t -> toEntity(t, restaurantId))
                .toList();
    }

    /**
     * Převede entitu fyzického stolu
     * na response DTO.
     *
     * @param table entita stolu
     * @return response DTO
     */
    RestaurantTableResponseDto toResponse(RestaurantTable table);

    /**
     * Převede seznam entit fyzických stolů
     * na seznam response DTO.
     *
     * @param tables seznam entit
     * @return seznam response DTO
     */
    List<RestaurantTableResponseDto> toResponseList(List<RestaurantTable> tables);
}
