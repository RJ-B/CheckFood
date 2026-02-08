package com.checkfood.checkfoodservice.application.mapper.restaurant;

import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantUpdateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.restaurant.RestaurantDetailResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.restaurant.RestaurantListResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.restaurant.RestaurantResponseDto;
import com.checkfood.checkfoodservice.application.entity.restaurant.Restaurant;
import org.mapstruct.*;

import java.util.List;

/**
 * Mapper pro převod mezi {@link Restaurant} a DTO objekty. <br><br>
 *
 * Mapper:
 * - nepoužívá validaci <br>
 * - neobsahuje business logiku <br>
 * - pracuje pouze s datovou transformací <br><br>
 *
 * VALIDACE <br>
 * - je garantována vstupními DTO <br>
 * - mapper předpokládá validní data <br>
 */
@Mapper(componentModel = "spring")
public interface RestaurantMapper {

    Restaurant toEntity(RestaurantCreateRequestDto request);

    void updateEntity(
            @MappingTarget Restaurant restaurant,
            RestaurantUpdateRequestDto request
    );

    RestaurantDetailResponseDto toDetailResponse(Restaurant restaurant);

    RestaurantListResponseDto toListResponse(Restaurant restaurant);

    List<RestaurantListResponseDto> toListResponse(List<Restaurant> restaurants);
}

