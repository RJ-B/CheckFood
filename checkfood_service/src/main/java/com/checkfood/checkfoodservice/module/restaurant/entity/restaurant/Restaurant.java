package com.checkfood.checkfoodservice.module.restaurant.entity.restaurant;

import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Hlavní doménová entita reprezentující restauraci na platformě CheckFood.
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
        name = "restaurant",
        indexes = {
                @Index(name = "idx_restaurant_status", columnList = "status"),
                @Index(name = "idx_restaurant_active", columnList = "is_active"),
                @Index(name = "idx_restaurant_overture_id", columnList = "overture_id"),
                @Index(name = "idx_restaurant_ico", columnList = "ico")
        }
)
public class Restaurant {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private java.util.UUID id;

    @Column(name = "overture_id", unique = true, length = 64)
    private String overtureId;

    @Column(name = "ico", length = 8, unique = true)
    private String ico;

    // Vlastnictví restaurace se řeší výhradně přes tabulku restaurant_employee
    // (role = OWNER). Sloupec `owner_id` byl odstraněn ve V3 migraci — viz
    // db/migration/V3__drop_restaurant_owner_id.sql a AuthServiceImpl.

    @Column(name = "name", nullable = false, length = 150)
    private String name;

    @Column(name = "description", length = 1000)
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(name = "cuisine_type", nullable = false, length = 50)
    private CuisineType cuisineType;

    @Column(name = "logo_url")
    private String logoUrl;

    @Column(name = "cover_image_url")
    private String coverImageUrl;

    @Column(name = "panorama_url")
    private String panoramaUrl;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "contact_email", length = 254)
    private String contactEmail;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 30)
    private RestaurantStatus status;

    @Column(name = "is_active", nullable = false)
    private boolean active;

    @Column(name = "rating", precision = 2, scale = 1)
    private BigDecimal rating;

    @Embedded
    private Address address;

    @ElementCollection(fetch = FetchType.LAZY)
    @CollectionTable(name = "restaurant_opening_hours", joinColumns = @JoinColumn(name = "restaurant_id"))
    @Builder.Default
    private List<OpeningHours> openingHours = new ArrayList<>();

    @ElementCollection(fetch = FetchType.LAZY)
    @CollectionTable(name = "restaurant_tag", joinColumns = @JoinColumn(name = "restaurant_id"))
    @Column(name = "tag")
    private Set<String> tags;

    @ElementCollection(fetch = FetchType.LAZY)
    @CollectionTable(name = "restaurant_special_day", joinColumns = @JoinColumn(name = "restaurant_id"))
    @Builder.Default
    private List<SpecialDay> specialDays = new ArrayList<>();

    @Transient
    @Builder.Default
    private List<RestaurantTable> tables = new ArrayList<>();

    @Builder.Default
    @Column(name = "default_reservation_duration_minutes", nullable = false)
    private int defaultReservationDurationMinutes = 60;

    @Builder.Default
    @Column(name = "min_advance_minutes", nullable = false)
    private int minAdvanceMinutes = 10;

    @Builder.Default
    @Column(name = "min_reservation_duration_minutes", nullable = false)
    private int minReservationDurationMinutes = 30;

    @Builder.Default
    @Column(name = "max_reservation_duration_minutes", nullable = false)
    private int maxReservationDurationMinutes = 180;

    @Builder.Default
    @Column(name = "reservation_slot_interval_minutes", nullable = false)
    private int reservationSlotIntervalMinutes = 30;

    @Builder.Default
    @Column(name = "onboarding_completed", nullable = false)
    private boolean onboardingCompleted = false;

    @Builder.Default
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Builder.Default
    @Column(name = "updated_at")
    private LocalDateTime updatedAt = LocalDateTime.now();
}