-- V1: Smazání osiřelých tabulek odstraněných z kódu
-- permissions + role_permissions: systém permissions nahrazen employee permissions (enum)

DROP TABLE IF EXISTS role_permissions CASCADE;
DROP TABLE IF EXISTS permissions CASCADE;
