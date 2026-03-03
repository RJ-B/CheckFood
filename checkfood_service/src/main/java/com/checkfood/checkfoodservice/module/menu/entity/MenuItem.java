package com.checkfood.checkfoodservice.module.menu.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "menu_item", indexes = {
        @Index(name = "idx_menu_item_category", columnList = "category_id"),
        @Index(name = "idx_menu_item_restaurant", columnList = "restaurant_id"),
        @Index(name = "idx_menu_item_sort", columnList = "category_id, sort_order")
})
public class MenuItem {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "category_id", nullable = false)
    private UUID categoryId;

    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    @Column(nullable = false, length = 150)
    private String name;

    @Column(length = 500)
    private String description;

    @Column(name = "price_minor", nullable = false)
    private int priceMinor;

    @Column(nullable = false, length = 3)
    @Builder.Default
    private String currency = "CZK";

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "is_available", nullable = false)
    @Builder.Default
    private boolean available = true;

    @Column(name = "sort_order", nullable = false)
    @Builder.Default
    private int sortOrder = 0;
}
