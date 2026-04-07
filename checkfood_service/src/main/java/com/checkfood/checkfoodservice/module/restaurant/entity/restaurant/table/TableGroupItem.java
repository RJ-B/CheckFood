package com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

/**
 * Vazební entita propojující TableGroup s konkrétním fyzickým stolem.
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
        name = "restaurant_table_group_item",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uk_group_table",
                        columnNames = {"group_id", "table_id"}
                )
        }
)
public class TableGroupItem {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "group_id", nullable = false)
    private TableGroup group;

    /**
     * Odkaz na fyzický stůl skrze jeho UUID.
     */
    @Column(name = "table_id", nullable = false)
    private UUID tableId;
}