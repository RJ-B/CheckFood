package com.checkfood.checkfoodservice.module.restaurant.entity;

import com.checkfood.checkfoodservice.application.entity.common.BaseEntity;
import com.checkfood.checkfoodservice.application.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * Hlavní doménová entita reprezentující restauraci.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "restaurant",
        indexes = {
                @Index(name = "idx_restaurant_status", columnList = "status"),
                @Index(name = "idx_restaurant_active", columnList = "active"),
                @Index(name = "idx_restaurant_geo", columnList = "latitude, longitude")
        }
)
public class Restaurant extends BaseEntity {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false, length = 150)
    private String name;

    @Column(length = 500)
    private String description;

    @Column(name = "cuisine_type", length = 50)
    private String cuisineType;

    @Column(name = "logo_url")
    private String logoUrl;

    @Column(name = "cover_image_url")
    private String coverImageUrl;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private RestaurantStatus status;

    @Column(nullable = false)
    private boolean active;

    /**
     * Průměrné hodnocení (denormalizovaná hodnota pro výkon).
     */
    @Column(precision = 2, scale = 1)
    private Double rating;

    @Embedded
    private Address address;

    /**
     * Kolekce štítků (tags) pro filtrování v Explore screenu.
     */
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(
            name = "restaurant_tag",
            joinColumns = @JoinColumn(name = "restaurant_id")
    )
    @Column(name = "tag")
    private Set<String> tags;

    /**
     * Seznam stolů je Transient, protože stoly tvoří samostatný agregát.
     */
    @Transient
    @Builder.Default
    private List<RestaurantTable> tables = new ArrayList<>();
}