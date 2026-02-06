package com.checkfood.checkfoodservice.application.entity.payment;

import jakarta.persistence.*;
import lombok.*;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Doménová entita reprezentující platbu objednávky.
 *
 * Payment je samostatný agregátový kořen.
 * Slouží k evidenci plateb provedených různými
 * způsoby a kanály (QR, obsluha, takeaway).
 *
 * Neřeší samotnou autorizaci plateb –
 * pouze eviduje výsledek platebního procesu.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "payment",
        indexes = {
                @Index(name = "idx_payment_order_id", columnList = "order_id"),
                @Index(name = "idx_payment_status", columnList = "status"),
                @Index(name = "idx_payment_method", columnList = "payment_method"),
                @Index(name = "idx_payment_channel", columnList = "payment_channel"),
                @Index(name = "idx_payment_created_at", columnList = "created_at")
        }
)
public class Payment {

    /**
     * Primární identifikátor platby.
     */
    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Identifikátor objednávky, ke které se platba vztahuje.
     *
     * Jedna objednávka může mít více platebních pokusů.
     */
    @Column(name = "order_id", nullable = false, updatable = false)
    private UUID orderId;

    /**
     * Způsob platby (hotově / karta / online).
     */
    @Enumerated(EnumType.STRING)
    @Column(name = "payment_method", nullable = false, length = 30)
    private PaymentMethod method;

    /**
     * Kanál, kterým byla platba iniciována.
     */
    @Enumerated(EnumType.STRING)
    @Column(name = "payment_channel", nullable = false, length = 30)
    private PaymentChannel channel;

    /**
     * Aktuální stav platby.
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private PaymentStatus status;

    /**
     * Částka platby v nejmenší měnové jednotce
     * (např. haléře).
     */
    @Column(nullable = false)
    private long amount;

    /**
     * Měna platby (ISO 4217).
     */
    @Column(nullable = false, length = 3)
    private String currency;

    /**
     * Externí identifikátor platby (např. Stripe payment intent).
     *
     * Vyplněno pouze pro online platby.
     */
    @Column(name = "external_payment_id", length = 100)
    private String externalPaymentId;

    /**
     * Idempotency klíč pro ochranu proti duplicitním platbám.
     */
    @Column(name = "idempotency_key", length = 100, unique = true)
    private String idempotencyKey;

    /**
     * Důvod selhání platby (pokud nastane).
     */
    @Column(name = "failure_reason", length = 255)
    private String failureReason;

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
     * Aktualizace času změny.
     */
    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = OffsetDateTime.now();
    }

}
