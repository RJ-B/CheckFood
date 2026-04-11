-- V3: Odstranění sloupce restaurant.owner_id
--
-- Proč:
--   Sloupec `restaurant.owner_id` byl dvojitě spravován — zároveň s tabulkou
--   `restaurant_employee`, která od začátku drží skutečné členství uživatelů
--   v restauracích včetně role OWNER. Tím vznikala duplicita, kterou kód
--   udržoval nekonzistentně:
--
--     • AuthServiceImpl.registerAsOwner:177 ukládal
--       `Restaurant.ownerId = UUID.randomUUID()` (= vazba nikam), ale souběžně
--       vytvářel správný RestaurantEmployee záznam.
--     • RestaurantController.extractUserId volal
--       `UUID.fromString(auth.getName())`, kde `getName()` vrací e-mail —
--       crash na každém owner-scoped endpointu.
--     • MyRestaurantController + AuthServiceImpl.buildAuthResponse používaly
--       čistě RestaurantEmployee a fungovaly korektně.
--
-- Vlastnictví je tedy už dnes implementované přes RestaurantEmployee
-- (role = 'OWNER'). Tato migrace jen odstraňuje mrtvou `owner_id` duplicitu.
--
-- Bezpečné pro existující data:
--   • Produkční záznamy mají validní RestaurantEmployee (OWNER) od prvního
--     releasu — nic se nerozbije.
--   • Systémové restaurace z Overture Maps neměly OWNER RestaurantEmployee
--     vůbec (jenom `owner_id = 00000000-...`) a žádný kód se na to nespoléhal
--     (getMyRestaurants filtruje přes RestaurantEmployee, takže je nevidí).
--     Zůstávají dostupné přes veřejné read endpointy, což je žádoucí.

ALTER TABLE restaurant DROP COLUMN IF EXISTS owner_id;
DROP INDEX IF EXISTS idx_restaurant_owner;
