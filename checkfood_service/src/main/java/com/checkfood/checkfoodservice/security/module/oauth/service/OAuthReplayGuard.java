package com.checkfood.checkfoodservice.security.module.oauth.service;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Duration;
import java.time.Instant;
import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * In-memory guard against OAuth ID-token replay attacks.
 *
 * <p>Google and Apple already sign their ID tokens with per-user claims
 * ({@code aud}, {@code iss}, {@code exp}), but neither provider enforces
 * single-use semantics — the same ID token is valid for its whole
 * lifetime (~1h), which means an attacker who captures one (via a
 * leaking log, browser extension, or XSS on a sibling app) could replay
 * it against our backend for the rest of the window and mint a brand
 * new CheckFood session. This guard closes that window by remembering
 * every accepted ID token's SHA-256 hash for 1 hour and rejecting any
 * repeat presentation within that window.</p>
 *
 * <p>Memory footprint: one entry per successful OAuth login = one 64-char
 * hex + one long epoch second ≈ 80 bytes. With 10 k logins per hour
 * (pessimistic) the map stays under 1 MB. A lazy sweep runs on every
 * write, so expired entries clear themselves out without a background
 * thread.</p>
 *
 * <p>Not a distributed solution — when CheckFood runs multiple backend
 * replicas, this guard only protects against replays hitting the same
 * replica. A shared Redis/Postgres-backed blacklist is the next step; an
 * attacker who knows two replicas exist can still replay once per
 * replica. Acceptable risk for a single-instance deployment like the
 * current Cloud Run service.</p>
 *
 * @author CheckFood team, Apr 2026
 */
@Slf4j
@Component
public class OAuthReplayGuard {

    /** How long a hash stays in the cache. Matches Google/Apple ID-token
     *  default lifetime so an expired ID token would be rejected by the
     *  provider validator anyway. */
    private static final Duration RETENTION = Duration.ofHours(1);

    /**
     * Disable flag. Turned on in the {@code test} profile via
     * {@code security.oauth.replay-guard.enabled=false} so the
     * integration test suite can reuse a single fake ID-token literal
     * across dozens of tests without tripping the replay check.
     */
    @Value("${security.oauth.replay-guard.enabled:true}")
    private boolean enabled;

    private final Map<String, Instant> seenHashes = new ConcurrentHashMap<>();

    /**
     * Records the supplied token as "seen". Returns {@code true} if this
     * was the first time we saw it (login may proceed), {@code false} if
     * it was already cached (replay — reject).
     *
     * <p>Also sweeps expired entries on each call.</p>
     */
    public boolean acceptIfFirstTime(String idToken) {
        if (!enabled) {
            return true;
        }
        Instant now = Instant.now();
        sweep(now);

        String hash = sha256Hex(idToken);
        Instant expiresAt = now.plus(RETENTION);
        Instant previous = seenHashes.putIfAbsent(hash, expiresAt);
        if (previous == null) {
            return true;
        }
        // Existing entry — only a true replay if the previous one is still
        // within retention. If the previous one has already expired but
        // the sweeper hasn't run yet, reset the window.
        if (previous.isBefore(now)) {
            seenHashes.put(hash, expiresAt);
            return true;
        }
        log.warn("[OAuth] Replay detected for ID-token hash prefix {}...",
                hash.substring(0, 12));
        return false;
    }

    private void sweep(Instant now) {
        Iterator<Map.Entry<String, Instant>> it = seenHashes.entrySet().iterator();
        while (it.hasNext()) {
            if (it.next().getValue().isBefore(now)) {
                it.remove();
            }
        }
    }

    private static String sha256Hex(String value) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(value.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(bytes.length * 2);
            for (byte b : bytes) sb.append(String.format("%02x", b));
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 not available", e);
        }
    }
}
