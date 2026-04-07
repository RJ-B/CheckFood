package com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

/**
 * Doménová entita reprezentující fyzický stůl v restauraci.
 * Stůl je základním prvkem pro správu kapacity a rezervací.
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
        name = "restaurant_table",
        indexes = {
                @Index(name = "idx_table_restaurant", columnList = "restaurant_id"),
                @Index(name = "idx_table_active", columnList = "is_active")
        }
)
public class RestaurantTable {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    /**
     * Odkaz na restauraci, které stůl patří.
     * Vazba přes ID zajišťuje, že načítání stolů neprovádí zbytečné JOINy na celou restauraci.
     */
    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    /**
     * Označení stolu pro personál a hosty (např. "Stůl 4", "Terasa A1").
     */
    @Column(name = "label", nullable = false, length = 50)
    private String label;

    /**
     * Standardní počet míst k sezení u tohoto stolu.
     */
    @Column(name = "capacity", nullable = false)
    private int capacity;

    /**
     * Indikuje, zda je stůl momentálně k dispozici pro provoz.
     */
    @Column(name = "is_active", nullable = false)
    private boolean active;

    /**
     * Horizontální úhel (stupně) pozice stolu v 360° panoramatu.
     */
    @Column(name = "yaw")
    private Double yaw;

    /**
     * Vertikální úhel (stupně) pozice stolu v 360° panoramatu.
     */
    @Column(name = "pitch")
    private Double pitch;
}