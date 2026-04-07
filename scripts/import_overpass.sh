#!/bin/bash
# Import restaurants from Overpass API (OSM) into CheckFood PostgreSQL database
# Usage: bash scripts/import_overpass.sh

set -e

DB_USER="checkfood_admin"
DB_NAME="checkfood"
DB_CONTAINER="checkfood-db"

# A system owner UUID for imported restaurants (no real owner)
SYSTEM_OWNER_ID="00000000-0000-0000-0000-000000000000"

OVERPASS_FILE="/tmp/overpass_restaurants.json"

echo "=== CheckFood Overpass Import ==="

# 1. Download data from Overpass API
echo "[1/3] Downloading restaurants from Overpass API (Plzeň bbox)..."
curl -s -X POST "https://overpass-api.de/api/interpreter" \
  --data-urlencode 'data=[out:json][timeout:25];(node["amenity"="restaurant"]["opening_hours"](49.70,13.30,49.79,13.42);way["amenity"="restaurant"]["opening_hours"](49.70,13.30,49.79,13.42););out body;>;out skel qt;' \
  > "$OVERPASS_FILE"

COUNT=$(grep -c '"amenity"' "$OVERPASS_FILE" 2>/dev/null || echo "0")
echo "   Found $COUNT restaurants with opening_hours"

if [ "$COUNT" -eq 0 ]; then
  echo "ERROR: No restaurants found. Check Overpass API availability."
  exit 1
fi

# 2. Parse and generate SQL
echo "[2/3] Generating SQL insert statements..."

SQL_FILE="/tmp/overpass_import.sql"
cat > "$SQL_FILE" << 'HEADER'
BEGIN;

-- Temporary table for dedup check
CREATE TEMP TABLE _import_check (osm_id BIGINT, name TEXT);

HEADER

# Use node.js to parse JSON and generate SQL
node -e "
const fs = require('fs');
const path = process.platform === 'win32' ? 'C:/Users/A/AppData/Local/Temp/overpass_restaurants.json' : '/tmp/overpass_restaurants.json';
const data = JSON.parse(fs.readFileSync(path, 'utf8'));

const elements = data.elements.filter(e => e.tags && e.tags.amenity === 'restaurant' && e.tags.name);

// Cuisine mapping from OSM to our enum
const cuisineMap = {
  'italian': 'ITALIAN', 'pizza': 'PIZZA', 'czech': 'CZECH',
  'asian': 'ASIAN', 'chinese': 'ASIAN', 'thai': 'ASIAN',
  'vietnamese': 'VIETNAMESE', 'indian': 'INDIAN',
  'french': 'FRENCH', 'mexican': 'MEXICAN',
  'american': 'AMERICAN', 'burger': 'BURGER',
  'mediterranean': 'MEDITERRANEAN', 'greek': 'MEDITERRANEAN',
  'japanese': 'JAPANESE_SUSHI', 'sushi': 'JAPANESE_SUSHI',
  'vegan': 'VEGAN_VEGETARIAN', 'vegetarian': 'VEGAN_VEGETARIAN',
  'kebab': 'KEBAB', 'turkish': 'KEBAB', 'doner': 'KEBAB',
  'cafe': 'CAFE_DESSERT', 'coffee': 'CAFE_DESSERT',
  'international': 'INTERNATIONAL', 'street_food': 'STREET_FOOD',
};

function mapCuisine(osmCuisine) {
  if (!osmCuisine) return 'OTHER';
  const parts = osmCuisine.toLowerCase().split(/[;,]/);
  for (const p of parts) {
    const trimmed = p.trim();
    if (cuisineMap[trimmed]) return cuisineMap[trimmed];
  }
  return 'OTHER';
}

// Parse OSM opening_hours to day-based structure
// Format examples: 'Mo-Fr 11:00-22:00; Sa-Su 12:00-23:00', 'Mo-Su 11:00-22:00'
const dayMap = { 'Mo': 'MONDAY', 'Tu': 'TUESDAY', 'We': 'WEDNESDAY', 'Th': 'THURSDAY', 'Fr': 'FRIDAY', 'Sa': 'SATURDAY', 'Su': 'SUNDAY' };
const dayOrder = ['Mo','Tu','We','Th','Fr','Sa','Su'];

function parseOpeningHours(oh) {
  if (!oh) return [];
  const result = {};
  // Initialize all days as closed
  for (const d of Object.values(dayMap)) result[d] = { closed: true };

  try {
    // Split by semicolons for multiple rules
    const rules = oh.split(';').map(s => s.trim());
    for (const rule of rules) {
      // Match patterns like 'Mo-Fr 11:00-22:00' or 'Sa 12:00-23:00' or 'Mo,We,Fr 10:00-20:00'
      const match = rule.match(/^([A-Za-z,\\-]+)\\s+(\\d{1,2}:\\d{2})\\s*-\\s*(\\d{1,2}:\\d{2})/);
      if (!match) continue;
      const [, daysPart, openAt, closeAt] = match;

      // Expand day ranges
      const days = [];
      const daySegments = daysPart.split(',');
      for (const seg of daySegments) {
        const rangeParts = seg.trim().split('-');
        if (rangeParts.length === 2) {
          const startIdx = dayOrder.indexOf(rangeParts[0].trim());
          const endIdx = dayOrder.indexOf(rangeParts[1].trim());
          if (startIdx >= 0 && endIdx >= 0) {
            for (let i = startIdx; i <= endIdx; i++) {
              days.push(dayOrder[i]);
            }
          }
        } else if (rangeParts.length === 1) {
          const d = rangeParts[0].trim();
          if (dayOrder.includes(d)) days.push(d);
        }
      }

      for (const d of days) {
        const fullDay = dayMap[d];
        if (fullDay) {
          result[fullDay] = {
            closed: false,
            openAt: openAt.padStart(5, '0') + ':00',
            closeAt: closeAt.padStart(5, '0') + ':00',
          };
        }
      }
    }
  } catch (e) {
    // Fallback — can't parse, leave all closed
  }
  return Object.entries(result);
}

function esc(s) {
  if (!s) return 'NULL';
  return \"'\" + s.replace(/'/g, \"''\") + \"'\";
}

let sql = '';
let count = 0;

for (const el of elements) {
  const t = el.tags;
  const name = t.name;
  if (!name) continue;

  const lat = el.lat;
  const lon = el.lon;
  if (!lat || !lon) continue;

  const osmId = el.id;
  const street = t['addr:street'] || null;
  const streetNum = t['addr:housenumber'] || t['addr:streetnumber'] || null;
  const postcode = t['addr:postcode'] || null;
  const city = t['addr:city'] || 'Plzeň';
  const country = 'CZ';
  const phone = t.phone || t['contact:phone'] || null;
  const email = t.email || t['contact:email'] || null;
  const website = t.website || t['contact:website'] || null;
  const cuisine = mapCuisine(t.cuisine);
  const description = t.description || (website ? 'Web: ' + website : null);
  const wheelchair = t.wheelchair;

  const uuid = 'gen_random_uuid()';

  sql += \`
-- \${name} (OSM ID: \${osmId})
INSERT INTO restaurant (id, name, description, cuisine_type, status, is_active, phone, contact_email,
  street, street_number, city, postal_code, country, location,
  owner_id, onboarding_completed, created_at, default_reservation_duration_minutes, rating, overture_id)
SELECT \${uuid}, \${esc(name)}, \${esc(description)}, '\${cuisine}', 'ACTIVE', true,
  \${esc(phone)}, \${esc(email)},
  \${esc(street)}, \${esc(streetNum)}, \${esc(city)}, \${esc(postcode)}, \${esc(country)},
  ST_SetSRID(ST_MakePoint(\${lon}, \${lat}), 4326),
  '\${process.env.SYSTEM_OWNER_ID || '00000000-0000-0000-0000-000000000000'}', false, NOW(), 60, NULL, NULL
WHERE NOT EXISTS (
  SELECT 1 FROM restaurant
  WHERE name = \${esc(name)}
    AND ST_DWithin(location, ST_SetSRID(ST_MakePoint(\${lon}, \${lat}), 4326)::geography, 50)
);\`;

  // Opening hours
  const hours = parseOpeningHours(t.opening_hours);
  for (const [day, info] of hours) {
    if (info.closed) {
      sql += \`
INSERT INTO restaurant_opening_hours (restaurant_id, day_of_week, is_closed, open_at, close_at)
SELECT r.id, '\${day}', true, NULL, NULL
FROM restaurant r WHERE r.name = \${esc(name)} AND ST_DWithin(r.location, ST_SetSRID(ST_MakePoint(\${lon}, \${lat}), 4326)::geography, 50)
AND NOT EXISTS (SELECT 1 FROM restaurant_opening_hours h WHERE h.restaurant_id = r.id AND h.day_of_week = '\${day}');\`;
    } else {
      sql += \`
INSERT INTO restaurant_opening_hours (restaurant_id, day_of_week, is_closed, open_at, close_at)
SELECT r.id, '\${day}', false, '\${info.openAt}', '\${info.closeAt}'
FROM restaurant r WHERE r.name = \${esc(name)} AND ST_DWithin(r.location, ST_SetSRID(ST_MakePoint(\${lon}, \${lat}), 4326)::geography, 50)
AND NOT EXISTS (SELECT 1 FROM restaurant_opening_hours h WHERE h.restaurant_id = r.id AND h.day_of_week = '\${day}');\`;
    }
  }

  sql += '\\n';
  count++;
}

sql += '\\nCOMMIT;\\n';
sql += \`-- Imported \${count} restaurants\\n\`;

// Write to file
const outPath = process.platform === 'win32' ? 'C:/Users/A/AppData/Local/Temp/overpass_import.sql' : '/tmp/overpass_import.sql';
fs.writeFileSync(outPath, sql);
console.log('Generated SQL for ' + count + ' restaurants');
" 2>&1

echo "[3/3] Importing into database..."
# Copy SQL into container and execute
docker cp "C:/Users/A/AppData/Local/Temp/overpass_import.sql" "$DB_CONTAINER:/tmp/import.sql" 2>/dev/null || \
docker cp "/tmp/overpass_import.sql" "$DB_CONTAINER:/tmp/import.sql"

docker exec "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" -f /tmp/import.sql 2>&1 | tail -5

echo ""
echo "=== Import complete ==="
docker exec "$DB_CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT COUNT(*) as total_restaurants FROM restaurant WHERE is_active = true;"
