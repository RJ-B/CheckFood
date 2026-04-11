-- V3: Enforce NOT NULL on reservation.end_time
--
-- Background:
--   Earlier in the codebase reservations were stored as "open-ended" rows
--   with end_time NULL — the slot algorithm walked from start_time forward
--   indefinitely. Commit c5a0e47 ("flexible reservation duration") replaced
--   that with a half-open [start, end) interval check, which silently
--   ignores any row with NULL end_time → potential double-booking on
--   legacy data.
--
--   The current cloud DB has 0 such rows (verified manually 2026-04-11),
--   but the schema still allowed NULL, which means the bug could come
--   back the next time a write path forgets to populate the column.
--
-- This migration:
--   1. Defensively backfills any remaining NULL end_time using the
--      restaurant's defaultReservationDurationMinutes. The COALESCE +
--      JOIN keeps the migration idempotent — if every row already has a
--      value, the UPDATE is a no-op.
--   2. Adds the NOT NULL constraint so future inserts cannot regress.

-- Step 1: backfill any orphaned NULL end_time rows
UPDATE reservation r
SET end_time = r.start_time + (
    COALESCE(
        (SELECT res.default_reservation_duration_minutes
         FROM restaurant res
         WHERE res.id = r.restaurant_id),
        60  -- fallback if the restaurant row is also missing somehow
    ) * INTERVAL '1 minute'
)
WHERE r.end_time IS NULL;

-- Step 2: enforce NOT NULL going forward
ALTER TABLE reservation
    ALTER COLUMN end_time SET NOT NULL;
