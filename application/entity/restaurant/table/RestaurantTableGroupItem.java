package com.checkfood.checkfoodservice.application.entity.restaurant.table;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

/**
 * Vazební entita spojující fyzický stůl
 * s logickou skupinou stolů.
 *
 * Umožňuje:
 * - spojení více stolů
 * - dynamickou alokaci
 * - přehledné uvolnění po sezení
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "restaurant_table_group_item",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uk_table_group_table",
                        columnNames = {"table_group_id", "restaurant_table_id"}
                )
        },
        indexes = {
                @Index(name = "idx_group_item_group", columnList = "table_group_id"),
                @Index(name = "idx_group_item_table", columnList = "restaurant_table_id")
        }
)
public class RestaurantTableGroupItem {

    /**
     * Primární identifikátor vazby.
     */
    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Skupina stolů.
     */
    @Column(name = "table_group_id", nullable = false)
    private UUID tableGroupId;

    /**
     * Fyzický stůl.
     */
    @Column(name = "restaurant_table_id", nullable = false)
    private UUID restaurantTableId;
}
