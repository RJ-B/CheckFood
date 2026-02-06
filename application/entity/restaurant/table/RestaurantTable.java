package com.checkfood.checkfoodservice.application.entity.restaurant.table;

import jakarta.persistence.*;
import lombok.*;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Doménová entita reprezentující fyzický stůl v restauraci.
 *
 * Fyzický stůl je neměnný provozní prvek:
 * - má kapacitu
 * - patří jedné restauraci
 * - může být dočasně součástí skupiny stolů
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "restaurant_table",
        indexes = {
                @Index(name = "idx_restaurant_table_restaurant", columnList = "restaurant_id"),
                @Index(name = "idx_restaurant_table_active", columnList = "active")
        }
)
public class RestaurantTable {

    /**
     * Primární identifikátor fyzického stolu.
     */
    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Restaurace, do které stůl patří.
     *
     * Pouze ID – bez JPA vazby.
     */
    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    /**
     * Označení stolu viditelné pro obsluhu (např. "4", "A1").
     */
    @Column(nullable = false, length = 50)
    private String label;

    /**
     * Maximální kapacita stolu.
     */
    @Column(nullable = false)
    private int capacity;

    /**
     * Zda je stůl aktivní (není vyřazen).
     */
    @Column(nullable = false)
    private boolean active;

    /**
     * Auditní informace.
     */
    @Column(nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @Column(nullable = false)
    private OffsetDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        OffsetDateTime now = OffsetDateTime.now();
        this.createdAt = now;
        this.updatedAt = now;
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = OffsetDateTime.now();
    }
}
