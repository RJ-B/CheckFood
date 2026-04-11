package com.checkfood.checkfoodservice.security.module.jwt.job;

import com.checkfood.checkfoodservice.security.module.jwt.repository.RefreshTokenRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.context.annotation.Profile;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.Instant;

/**
 * Daily housekeeping job that prunes expired refresh-token rows from the
 * rotation table. Without it the table would grow monotonically — every
 * login creates at least one row, every rotation creates another, and the
 * DB only ever deletes them on explicit user account deletion.
 *
 * <p>Retention window is 7 days past expiry so forensic inspection of a
 * suspected reuse event still has a reasonable trail to read.</p>
 *
 * <p>Skipped in the {@code test} profile so integration tests don't race
 * with the cleanup scheduler.</p>
 *
 * @author CheckFood team, Apr 2026
 */
@Slf4j
@Component
@Profile("!test")
@RequiredArgsConstructor
public class RefreshTokenCleanupJob {

    private static final Duration RETENTION_BEYOND_EXPIRY = Duration.ofDays(7);

    private final RefreshTokenRepository refreshTokenRepository;

    /**
     * Runs every day at 02:30 — kept off the full hour so it doesn't
     * contend with user login traffic on the top-of-hour and off the
     * Overture sync (03:00 Monday) so they don't both hammer the DB.
     */
    @Scheduled(cron = "0 30 2 * * *")
    @Transactional
    public void purgeExpiredRefreshTokens() {
        Instant threshold = Instant.now().minus(RETENTION_BEYOND_EXPIRY);
        int deleted = refreshTokenRepository.deleteAllExpiredBefore(threshold);
        if (deleted > 0) {
            log.info("[RefreshTokenCleanup] Deleted {} refresh-token rows expired before {}",
                    deleted, threshold);
        }
    }
}
