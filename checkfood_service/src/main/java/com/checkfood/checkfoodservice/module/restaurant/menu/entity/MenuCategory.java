package com.checkfood.checkfoodservice.module.restaurant.menu.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

/**
 * JPA entita kategorie menu seskupující položky menu v rámci jedné restaurace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "menu_category", indexes = {
        @Index(name = "idx_menu_category_restaurant", columnList = "restaurant_id"),
        @Index(name = "idx_menu_category_sort", columnList = "restaurant_id, sort_order")
})
public class MenuCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(name = "sort_order", nullable = false)
    @Builder.Default
    private int sortOrder = 0;

    @Column(name = "is_active", nullable = false)
    @Builder.Default
    private boolean active = true;
}
