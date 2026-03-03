package com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table;

import jakarta.persistence.*;
import lombok.*;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Agregát reprezentující logické spojení stolů pro konkrétní sezení nebo skupinu.
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
                @Index(name = "idx_table_group_active", columnList = "is_active")
        }
)
public class TableGroup {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    /**
     * ID restaurace, ke které sezení patří.
     */
    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    /**
     * Volitelný název skupiny pro lepší orientaci personálu.
     */
    @Column(name = "label", length = 100)
    private String label;

    /**
     * Příznak, zda je sezení aktuálně probíhající.
     */
    @Column(name = "is_active", nullable = false)
    private boolean active;

    /**
     * Čas ukončení sezení a uvolnění stolů.
     */
    @Column(name = "closed_at")
    private OffsetDateTime closedAt;

    /**
     * Seznam vazeb na fyzické stoly, které jsou součástí této skupiny.
     */
    @OneToMany(
            mappedBy = "group",
            cascade = CascadeType.ALL,
            orphanRemoval = true,
            fetch = FetchType.LAZY
    )
    @Builder.Default
    private List<TableGroupItem> items = new ArrayList<>();

    /**
     * Pomocná metoda pro přidání stolu do skupiny.
     */
    public void addTable(UUID tableId) {
        TableGroupItem item = TableGroupItem.builder()
                .group(this)
                .tableId(tableId)
                .build();
        items.add(item);
    }
}