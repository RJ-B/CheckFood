package com.checkfood.checkfoodservice.security.module.jwt.entity;

import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;

import jakarta.persistence.*;
import lombok.*;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;
import java.util.UUID;

/**
 * Persistent record of a single refresh-token grant exchange, used for
 * OAuth 2.0 Security BCP-compliant rotation with reuse detection
 * (RFC 9700 §2.2.2, OWASP ASVS V3.5.2).
 *
 * <p>Each refresh-token rotation performs:
 * <ol>
 *   <li>lookup by SHA-256 {@code tokenHash}</li>
 *   <li>check {@code usedAt} / {@code revokedAt} — if either is set
 *       this is a reuse attempt, so the entire {@code familyId} is
 *       revoked in one statement and the exchange fails</li>
 *   <li>mark this row {@code usedAt = now}</li>
 *   <li>insert a new row with the same {@code familyId} and
 *       {@code parentHash = this.tokenHash}</li>
 * </ol>
 *
 * <p>Raw JWT values are never stored — only their SHA-256 hash. This
 * keeps the DB safe against data exfiltration (an attacker with a DB
 * dump cannot replay tokens against the server) and keeps lookups
 * deterministic.
 *
 * @author CheckFood team, Apr 2026
 */
@Entity
@Table(
        name = "refresh_tokens",
        indexes = {
                @Index(name = "idx_refresh_tokens_user_id", columnList = "user_id"),
                @Index(name = "idx_refresh_tokens_family_id", columnList = "family_id"),
                @Index(name = "idx_refresh_tokens_expires_at", columnList = "expires_at")
        },
        uniqueConstraints = {
                @UniqueConstraint(name = "ux_refresh_tokens_token_hash", columnNames = "token_hash")
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RefreshTokenEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private UserEntity user;

    /** Device identifier the token was bound to at issue time. */
    @Column(name = "device_identifier", length = 255)
    private String deviceIdentifier;

    /** SHA-256 hex of the raw JWT value. */
    @Column(name = "token_hash", nullable = false, length = 64, updatable = false)
    private String tokenHash;

    /**
     * Shared ID for the entire rotation lineage. All tokens rotated from
     * a single login share this value. On reuse detection, all rows with
     * this family_id are revoked at once.
     */
    @Column(name = "family_id", nullable = false, updatable = false)
    private UUID familyId;

    /**
     * {@code tokenHash} of the previous token in the chain, or {@code null}
     * for the first token of the family. Kept for forensic replay.
     */
    @Column(name = "parent_hash", length = 64, updatable = false)
    private String parentHash;

    @Column(name = "issued_at", nullable = false, updatable = false)
    private Instant issuedAt;

    @Column(name = "expires_at", nullable = false, updatable = false)
    private Instant expiresAt;

    /** Set when the token is consumed in a normal rotation exchange. */
    @Column(name = "used_at")
    private Instant usedAt;

    /** Set when the token is killed outside a normal rotation. */
    @Column(name = "revoked_at")
    private Instant revokedAt;

    /**
     * Human-readable reason the row was revoked:
     * {@code REUSE_DETECTED}, {@code LOGOUT}, {@code ADMIN_REVOKED},
     * {@code FAMILY_ROTATED_ON_REUSE}.
     */
    @Column(name = "revocation_reason", length = 50)
    private String revocationReason;

    public boolean isActive(Instant now) {
        return usedAt == null
                && revokedAt == null
                && expiresAt.isAfter(now);
    }
}
