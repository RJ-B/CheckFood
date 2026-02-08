package com.checkfood.checkfoodservice.application.entity.reservation;

import jakarta.persistence.*;
import lombok.*;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Doménová entita reprezentující rezervaci v restauraci.
 *
 * Reservation je stavový záznam, který:
 * - blokuje kapacitu restaurace na konkrétní čas
 * - může být přiřazen ke konkrétnímu stolu nebo skupině stolů
 * - může (ale nemusí) být následně použit pro objednávku
 *
 * Entita neobsahuje žádnou provozní logiku.
 * Veškerá rozhodnutí probíhají ve service vrstvě.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "reservation",
        indexes = {
                @Index(
                        name = "idx_reservation_restaurant_time",
                        columnList = "restaurant_id, reservation_time"
                ),
                @Index(
                        name = "idx_reservation_status",
                        columnList = "status"
                ),
                @Index(
                        name = "idx_reservation_table_group",
                        columnList = "table_group_id"
                )
        }
)
public class Reservation {

    /**
     * Primární identifikátor rezervace.
     */
    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Identifikátor restaurace, pro kterou je rezervace vytvořena.
     *
     * Používáme pouze ID – bez JPA vazby
     * kvůli výkonu a jasným hranicím agregátů.
     */
    @Column(name = "restaurant_id", nullable = false)
    private UUID restaurantId;

    /**
     * Identifikátor uživatele, který rezervaci vytvořil.
     *
     * Může být null:
     * - telefonická rezervace
     * - rezervace vytvořená obsluhou
     */
    @Column(name = "user_id")
    private UUID userId;

    /**
     * Logický stůl (skupina stolů), ke kterému je rezervace přiřazena.
     *
     * Může být null:
     * - při vytvoření rezervace
     * - dokud obsluha neurčí konkrétní usazení
     */
    @Column(name = "table_group_id")
    private UUID tableGroupId;

    /**
     * Čas začátku rezervace.
     */
    @Column(name = "reservation_time", nullable = false)
    private OffsetDateTime reservationTime;

    /**
     * Počet hostů v rámci rezervace.
     */
    @Column(nullable = false)
    private int numberOfGuests;

    /**
     * Aktuální stav rezervace.
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private ReservationStatus status;

    /**
     * Volitelná poznámka k rezervaci.
     */
    @Column(length = 500)
    private String note;

    /**
     * Auditní informace.
     */
    @Column(nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @Column(nullable = false)
    private OffsetDateTime updatedAt;

    /**
     * Inicializace auditních polí při vytvoření.
     */
    @PrePersist
    protected void onCreate() {
        OffsetDateTime now = OffsetDateTime.now();
        this.createdAt = now;
        this.updatedAt = now;
    }

    /**
     * Aktualizace času změny při úpravě.
     */
    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = OffsetDateTime.now();
    }
}
