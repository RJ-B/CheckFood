package com.example.CheckFood.domain.product;

import com.example.CheckFood.domain.restaurant.Restaurant;

public class ProductMapper {

    public static Product toEntity(ProductDto dto, Restaurant restaurant) {
        return Product.builder()
                .name(dto.getName())
                .description(dto.getDescription())
                .price(dto.getPrice())
                .category(dto.getCategory())
                .restaurant(restaurant)
                .build();
    }

    public static ProductDto toDto(Product product) {
        return ProductDto.builder()
                .name(product.getName())
                .description(product.getDescription())
                .price(product.getPrice())
                .category(product.getCategory())
                .restaurantId(product.getRestaurant().getId())
                .build();
    }
}
