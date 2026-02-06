package com.checkfood.checkfoodservice.application.entity.restaurant.table;

import jakarta.persistence.*;
import lombok.*;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Doménová entita reprezentující logický stůl (skupinu stolů).
 *
 * Vzniká dynamicky při rezervaci nebo usazení hostů
 * a zaniká po ukončení sezení.
 *
 * Příklady:
 * - "4+5"
 * - "VIP"
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "restaurant_table_group",
        indexes = {
                @Index(name = "idx_table_group_restaurant", columnList = "restaurant_id"),
                @Index(name = "idx_table_group_active", columnList = "active")
        }
)
public class RestaurantTableGroup {

    /**
     * Primární identifikátor skupiny stolů.
     */
    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Restaurace, ve které skupina vznikla.
     */
    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    /**
     * Lidsky čitelný popis (např. "4+5").
     */
    @Column(length = 50)
    private String label;

    /**
     * Zda je skupina aktivní (probíhá sezení).
     */
    @Column(nullable = false)
    private boolean active;

    /**
     * Čas vytvoření skupiny.
     */
    @Column(nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    /**
     * Čas ukončení sezení (null pokud aktivní).
     */
    @Column
    private OffsetDateTime closedAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = OffsetDateTime.now();
        this.active = true;
    }
}
