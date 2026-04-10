-- V2: Rozšíření modelu pro novou strukturu media storage (GCS)
--
-- Co tato migrace dělá:
--   1) Vytváří tabulku restaurant_photo pro galerii fotek restaurace (M:1)
--   2) Přidává users.avatar_object_path pro custom avatar uploadovaný do
--      privátního bucketu (signed URL při čtení). Stávající profile_image_url
--      zůstává jako fallback pro OAuth-provided URLs (Google, Apple).
--
-- Veřejné URL fotek (logo, cover, panorama, menu_item.image_url) zůstávají
-- uložené přímo jako string v existujících sloupcích — pro veřejný content
-- to je perf-optimální a nevyžaduje to mapping při čtení.

-- ---------- 1. RESTAURANT GALLERY ----------
CREATE TABLE IF NOT EXISTS restaurant_photo (
    id            UUID PRIMARY KEY,
    restaurant_id UUID NOT NULL REFERENCES restaurant(id) ON DELETE CASCADE,
    photo_url     VARCHAR(512) NOT NULL,
    object_path   VARCHAR(512) NOT NULL,
    sort_order    INT NOT NULL DEFAULT 0,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_restaurant_photo_restaurant
    ON restaurant_photo (restaurant_id);

CREATE INDEX IF NOT EXISTS idx_restaurant_photo_sort
    ON restaurant_photo (restaurant_id, sort_order);

-- ---------- 2. USER AVATAR (PRIVÁTNÍ BUCKET) ----------
ALTER TABLE users
    ADD COLUMN IF NOT EXISTS avatar_object_path VARCHAR(512);
