package com.example.CheckFood.domain.restaurant;

public class RestaurantMapper {

    public static Restaurant toEntity(RestaurantDto dto) {
        return Restaurant.builder()
                .name(dto.getName())
                .address(dto.getAddress())
                .phone(dto.getPhone())
                .email(dto.getEmail())
                .description(dto.getDescription())
                .build();
    }

    public static RestaurantDto toDto(Restaurant restaurant) {
        return RestaurantDto.builder()
                .name(restaurant.getName())
                .address(restaurant.getAddress())
                .phone(restaurant.getPhone())
                .email(restaurant.getEmail())
                .description(restaurant.getDescription())
                .build();
    }
}
