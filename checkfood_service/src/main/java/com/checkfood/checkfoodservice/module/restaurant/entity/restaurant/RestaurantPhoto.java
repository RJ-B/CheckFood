package com.checkfood.checkfoodservice.module.restaurant.entity.restaurant;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

/**
 * JPA entita pro fotku v galerii restaurace. Každá restaurace může mít N fotek
 * řazených podle {@code sortOrder}. Ukládá jak veřejnou URL (pro rychlé čtení),
 * tak object path v GCS bucketu (pro mazání souboru při delete).
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
@Table(
        name = "restaurant_photo",
        indexes = {
                @Index(name = "idx_restaurant_photo_restaurant", columnList = "restaurant_id"),
                @Index(name = "idx_restaurant_photo_sort", columnList = "restaurant_id, sort_order")
        }
)
public class RestaurantPhoto {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    /** Veřejná URL na obrázek (pro rychlé servírování klientovi). */
    @Column(name = "photo_url", nullable = false, length = 512)
    private String photoUrl;

    /** Object path v GCS bucketu — potřebné pro {@code delete} při smazání. */
    @Column(name = "object_path", nullable = false, length = 512)
    private String objectPath;

    @Column(name = "sort_order", nullable = false)
    @Builder.Default
    private int sortOrder = 0;

    @Column(name = "created_at", nullable = false, updatable = false)
    @Builder.Default
    private LocalDateTime createdAt = LocalDateTime.now();
}
