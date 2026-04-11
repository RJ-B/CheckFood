-- V4: Refresh token rotation with reuse detection.
--
-- Implements OAuth 2.0 Security Best Current Practice (RFC 9700 §2.2.2)
-- and OWASP ASVS V3.5.2: every refresh-token grant exchange must invalidate
-- the presented token AND, on detection of a re-used token, invalidate the
-- entire descendant chain (the "family") so a stolen token cannot outlive
-- its theft.
--
-- Schema design:
--   token_hash           SHA-256 of the raw token value, uniquely indexed.
--                        Never store the raw JWT — the hash is enough to
--                        look up a presented token without leaking its
--                        content via a DB dump or backup.
--   family_id            UUID shared by every token in a single login
--                        lineage. On reuse, all rows with the same
--                        family_id are revoked in one statement.
--   parent_hash          SHA-256 of the token this one was rotated from,
--                        or NULL for the first token of the family. Lets
--                        us reconstruct the chain for forensics.
--   used_at              Set on successful rotation. A second rotation
--                        attempt against a token with used_at != NULL is
--                        the reuse signal.
--   revoked_at / reason  Populated by logout, explicit revocation, or
--                        reuse detection. Separate from used_at so we can
--                        distinguish "consumed normally" from "killed".

CREATE TABLE IF NOT EXISTS refresh_tokens (
    id                 BIGSERIAL PRIMARY KEY,
    user_id            BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    device_identifier  VARCHAR(255),
    token_hash         VARCHAR(64) NOT NULL,
    family_id          UUID NOT NULL,
    parent_hash        VARCHAR(64),
    issued_at          TIMESTAMP NOT NULL,
    expires_at         TIMESTAMP NOT NULL,
    used_at            TIMESTAMP,
    revoked_at         TIMESTAMP,
    revocation_reason  VARCHAR(50)
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_refresh_tokens_token_hash
    ON refresh_tokens(token_hash);
CREATE INDEX IF NOT EXISTS idx_refresh_tokens_user_id
    ON refresh_tokens(user_id);
CREATE INDEX IF NOT EXISTS idx_refresh_tokens_family_id
    ON refresh_tokens(family_id);
CREATE INDEX IF NOT EXISTS idx_refresh_tokens_expires_at
    ON refresh_tokens(expires_at);
