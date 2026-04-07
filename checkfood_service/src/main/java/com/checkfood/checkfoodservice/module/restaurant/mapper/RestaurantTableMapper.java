package com.checkfood.checkfoodservice.module.restaurant.mapper;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantTableRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantTableResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

/**
 * MapStruct mapper pro konverzi entre entitou {@link RestaurantTable} a příslušnými DTO.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface RestaurantTableMapper {

    /**
     * Převede entitu stolu na response DTO.
     *
     * @param table entita stolu
     * @return response DTO
     */
    RestaurantTableResponse toResponse(RestaurantTable table);

    /**
     * Převede request DTO na entitu stolu. Pole {@code id} a {@code restaurantId} jsou ignorována.
     *
     * @param request request DTO
     * @return entita stolu
     */
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "restaurantId", ignore = true)
    RestaurantTable toEntity(RestaurantTableRequest request);
}