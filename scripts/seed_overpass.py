"""
CheckFood — Seed restaurací z Overpass API (OSM) do Cloud SQL.

Použití:
  python seed_overpass.py --db-host=IP --db-name=checkfood --db-user=postgres --db-pass=HESLO

Nebo přes Cloud SQL proxy:
  cloud_sql_proxy -instances=checkfood-system-478116:europe-central2:checkfood-db=tcp:5432
  python seed_overpass.py --db-host=127.0.0.1 --db-port=5432 --db-name=checkfood --db-user=postgres --db-pass=HESLO
"""

import argparse
import json
import re
import sys
import uuid
from datetime import time

import psycopg2
import requests

# ============================================================
# 1. OVERPASS QUERY
# ============================================================

OVERPASS_URL = "https://overpass-api.de/api/interpreter"

OVERPASS_QUERY = """
[out:json][timeout:300];
area["ISO3166-1"="CZ"]->.cz;
(
  node["amenity"="restaurant"](area.cz);
  way["amenity"="restaurant"](area.cz);
  relation["amenity"="restaurant"](area.cz);
);
out center tags;
"""

# Fast-food řetězce k vyloučení (lowercase)
EXCLUDED_CHAINS = {
    "mcdonald's", "mcdonalds", "kfc", "burger king", "subway",
    "pizza hut", "domino's", "dominos", "starbucks", "costa coffee",
    "dunkin' donuts", "taco bell", "wendy's", "popeyes",
    "five guys", "chick-fil-a", "panda express",
    "paul", "nordsee",
}

SYSTEM_OWNER_ID = "00000000-0000-0000-0000-000000000000"

# ============================================================
# 2. CUISINE MAPPING
# ============================================================

CUISINE_MAP = {
    "czech": "CZECH",
    "bohemian": "CZECH",
    "italian": "ITALIAN",
    "pizza": "PIZZA",
    "asian": "ASIAN",
    "chinese": "ASIAN",
    "thai": "ASIAN",
    "korean": "ASIAN",
    "vietnamese": "VIETNAMESE",
    "indian": "INDIAN",
    "french": "FRENCH",
    "mexican": "MEXICAN",
    "tex-mex": "MEXICAN",
    "american": "AMERICAN",
    "burger": "BURGER",
    "mediterranean": "MEDITERRANEAN",
    "greek": "MEDITERRANEAN",
    "turkish": "MEDITERRANEAN",
    "japanese": "JAPANESE_SUSHI",
    "sushi": "JAPANESE_SUSHI",
    "vegan": "VEGAN_VEGETARIAN",
    "vegetarian": "VEGAN_VEGETARIAN",
    "international": "INTERNATIONAL",
    "street_food": "STREET_FOOD",
    "kebab": "KEBAB",
    "doner": "KEBAB",
    "cafe": "CAFE_DESSERT",
    "coffee_shop": "CAFE_DESSERT",
    "dessert": "CAFE_DESSERT",
    "pastry": "CAFE_DESSERT",
}


def map_cuisine(osm_cuisine: str | None) -> str:
    """Mapuje OSM cuisine tag na CuisineType enum."""
    if not osm_cuisine:
        return "OTHER"
    # OSM může mít více kuchyní: "czech;international"
    parts = re.split(r"[;,_]", osm_cuisine.lower().strip())
    for part in parts:
        part = part.strip()
        if part in CUISINE_MAP:
            return CUISINE_MAP[part]
    return "OTHER"


# ============================================================
# 3. OPENING HOURS PARSER
# ============================================================

DAY_MAP = {
    "mo": "MONDAY",
    "tu": "TUESDAY",
    "we": "WEDNESDAY",
    "th": "THURSDAY",
    "fr": "FRIDAY",
    "sa": "SATURDAY",
    "su": "SUNDAY",
}

DAY_ORDER = ["mo", "tu", "we", "th", "fr", "sa", "su"]


def _expand_day_range(spec: str) -> list[str]:
    """Expanduje 'Mo-Fr' na ['mo','tu','we','th','fr']."""
    spec = spec.lower().strip()
    if "-" in spec:
        parts = spec.split("-")
        if len(parts) == 2:
            start = parts[0].strip()[:2]
            end = parts[1].strip()[:2]
            if start in DAY_ORDER and end in DAY_ORDER:
                si = DAY_ORDER.index(start)
                ei = DAY_ORDER.index(end)
                if ei >= si:
                    return DAY_ORDER[si : ei + 1]
                else:
                    return DAY_ORDER[si:] + DAY_ORDER[: ei + 1]
    # Jednotlivý den
    day = spec[:2]
    if day in DAY_ORDER:
        return [day]
    return []


def _parse_time(t: str) -> time | None:
    """Parsuje '10:00' nebo '10:30' na time objekt."""
    t = t.strip()
    match = re.match(r"(\d{1,2}):(\d{2})", t)
    if match:
        h, m = int(match.group(1)), int(match.group(2))
        if h == 24:
            h = 23
            m = 59
        if 0 <= h <= 23 and 0 <= m <= 59:
            return time(h, m)
    return None


def parse_opening_hours(oh_str: str | None) -> list[dict]:
    """
    Parsuje OSM opening_hours formát do seznamu slovníků.
    Příklady:
      "Mo-Fr 10:00-22:00; Sa 11:00-23:00; Su off"
      "Mo-Su 09:00-21:00"
      "10:00-22:00"  (platí pro všechny dny)
    """
    result = {day: {"closed": True, "open": None, "close": None} for day in DAY_ORDER}

    if not oh_str:
        return _to_list(result)

    oh_str = oh_str.replace("–", "-")  # em-dash na hyphen

    # Rozděl na pravidla: "Mo-Fr 10:00-22:00; Sa off"
    rules = re.split(r"\s*;\s*", oh_str.strip())

    for rule in rules:
        rule = rule.strip()
        if not rule:
            continue

        # Detekce "off" / "closed"
        is_off = rule.lower().endswith("off") or rule.lower().endswith("closed")

        # Pokus rozdělit na dny a čas
        time_match = re.search(r"(\d{1,2}:\d{2})\s*-\s*(\d{1,2}:\d{2})", rule)

        # Extrahuj denní specifikaci (vše před časem)
        if time_match:
            day_part = rule[: time_match.start()].strip().rstrip(",")
        elif is_off:
            day_part = re.sub(r"\s*(off|closed)\s*$", "", rule, flags=re.IGNORECASE).strip()
        else:
            continue

        # Expanduj dny
        if day_part:
            day_specs = re.split(r"\s*,\s*", day_part)
            days = []
            for ds in day_specs:
                days.extend(_expand_day_range(ds))
        else:
            # Žádné dny specifikovány = všechny
            days = list(DAY_ORDER)

        if is_off:
            for d in days:
                result[d] = {"closed": True, "open": None, "close": None}
        elif time_match:
            open_t = _parse_time(time_match.group(1))
            close_t = _parse_time(time_match.group(2))
            if open_t and close_t:
                for d in days:
                    result[d] = {"closed": False, "open": open_t, "close": close_t}

    return _to_list(result)


def _to_list(result: dict) -> list[dict]:
    """Převede dict na list s day_of_week."""
    out = []
    for day_key in DAY_ORDER:
        info = result[day_key]
        out.append(
            {
                "day_of_week": DAY_MAP[day_key],
                "open_at": info["open"],
                "close_at": info["close"],
                "is_closed": info["closed"],
            }
        )
    return out


# ============================================================
# 4. OVERPASS DATA FETCH
# ============================================================


def fetch_overpass() -> list[dict]:
    """Stáhne restaurace z Overpass API."""
    print("Stahuji restaurace z Overpass API (celá ČR)...")
    resp = requests.post(OVERPASS_URL, data={"data": OVERPASS_QUERY}, timeout=600)
    resp.raise_for_status()
    data = resp.json()
    elements = data.get("elements", [])
    print(f"  Staženo {len(elements)} elementů z OSM.")
    return elements


def process_elements(elements: list[dict]) -> list[dict]:
    """Zpracuje OSM elementy na restaurace."""
    restaurants = []
    skipped_no_name = 0
    skipped_chain = 0
    skipped_no_coords = 0

    for el in elements:
        tags = el.get("tags", {})

        # Souřadnice
        lat = el.get("lat") or (el.get("center", {}) or {}).get("lat")
        lon = el.get("lon") or (el.get("center", {}) or {}).get("lon")
        if not lat or not lon:
            skipped_no_coords += 1
            continue

        # Název
        name = tags.get("name", "").strip()
        if not name:
            skipped_no_name += 1
            continue

        # Vyloučení řetězců
        if name.lower() in EXCLUDED_CHAINS:
            skipped_chain += 1
            continue

        # Vyloučení uzavřených
        if tags.get("disused:amenity") or tags.get("abandoned:amenity"):
            continue

        # Cuisine
        cuisine_type = map_cuisine(tags.get("cuisine"))

        # Adresa
        street = tags.get("addr:street", "")
        house_number = tags.get("addr:housenumber", "")
        city = tags.get("addr:city", "")
        postcode = tags.get("addr:postcode", "")

        # Telefon
        phone = tags.get("phone", tags.get("contact:phone", ""))
        if phone:
            phone = phone[:20]  # max length

        # Email
        email = tags.get("email", tags.get("contact:email", ""))
        if email:
            email = email[:254]

        # Website (jako popis)
        website = tags.get("website", tags.get("contact:website", ""))

        # Opening hours
        oh_raw = tags.get("opening_hours", "")
        opening_hours = parse_opening_hours(oh_raw) if oh_raw else []

        # OSM ID pro deduplikaci
        osm_id = f"osm_{el.get('type', 'node')}_{el.get('id', 0)}"

        description = ""
        if website:
            description = website[:1000]

        restaurants.append(
            {
                "id": str(uuid.uuid4()),
                "overture_id": osm_id,
                "owner_id": SYSTEM_OWNER_ID,
                "name": name[:150],
                "description": description,
                "cuisine_type": cuisine_type,
                "phone": phone or None,
                "contact_email": email or None,
                "status": "ACTIVE",
                "is_active": True,
                "onboarding_completed": False,
                "default_reservation_duration_minutes": 60,
                "min_advance_minutes": 10,
                "min_reservation_duration_minutes": 30,
                "max_reservation_duration_minutes": 180,
                "reservation_slot_interval_minutes": 30,
                "street": street or None,
                "street_number": house_number or None,
                "city": city or None,
                "postal_code": postcode or None,
                "country": "CZ",
                "lat": float(lat),
                "lon": float(lon),
                "opening_hours": opening_hours,
            }
        )

    print(f"  Zpracováno: {len(restaurants)} restaurací")
    print(f"  Přeskočeno: {skipped_no_name} bez názvu, {skipped_chain} řetězců, {skipped_no_coords} bez souřadnic")
    return restaurants


# ============================================================
# 5. DATABASE INSERT
# ============================================================


def insert_restaurants(restaurants: list[dict], conn):
    """Vloží restaurace do PostgreSQL."""
    cur = conn.cursor()

    inserted = 0
    skipped_dup = 0

    for r in restaurants:
        # Kontrola duplikátu dle overture_id
        cur.execute("SELECT 1 FROM restaurant WHERE overture_id = %s", (r["overture_id"],))
        if cur.fetchone():
            skipped_dup += 1
            continue

        # INSERT restaurant
        cur.execute(
            """
            INSERT INTO restaurant (
                id, overture_id, owner_id, name, description, cuisine_type,
                phone, contact_email, status, is_active, onboarding_completed,
                default_reservation_duration_minutes, min_advance_minutes,
                min_reservation_duration_minutes, max_reservation_duration_minutes,
                reservation_slot_interval_minutes,
                street, street_number, city, postal_code, country,
                location, created_at
            ) VALUES (
                %s::uuid, %s, %s::uuid, %s, %s, %s,
                %s, %s, %s, %s, %s,
                %s, %s, %s, %s, %s,
                %s, %s, %s, %s, %s,
                ST_SetSRID(ST_MakePoint(%s, %s), 4326),
                NOW()
            )
            """,
            (
                r["id"],
                r["overture_id"],
                r["owner_id"],
                r["name"],
                r["description"],
                r["cuisine_type"],
                r["phone"],
                r["contact_email"],
                r["status"],
                r["is_active"],
                r["onboarding_completed"],
                r["default_reservation_duration_minutes"],
                r["min_advance_minutes"],
                r["min_reservation_duration_minutes"],
                r["max_reservation_duration_minutes"],
                r["reservation_slot_interval_minutes"],
                r["street"],
                r["street_number"],
                r["city"],
                r["postal_code"],
                r["country"],
                r["lon"],  # PostGIS: X = longitude
                r["lat"],  # PostGIS: Y = latitude
            ),
        )

        # INSERT opening hours
        for oh in r["opening_hours"]:
            cur.execute(
                """
                INSERT INTO restaurant_opening_hours (
                    restaurant_id, day_of_week, open_at, close_at, is_closed
                ) VALUES (%s::uuid, %s, %s, %s, %s)
                """,
                (
                    r["id"],
                    oh["day_of_week"],
                    oh["open_at"],
                    oh["close_at"],
                    oh["is_closed"],
                ),
            )

        inserted += 1
        if inserted % 500 == 0:
            print(f"  Vloženo {inserted} restaurací...")
            conn.commit()

    conn.commit()
    print(f"\nHotovo: {inserted} vloženo, {skipped_dup} duplikátů přeskočeno.")
    cur.close()


# ============================================================
# 6. MAIN
# ============================================================


def main():
    parser = argparse.ArgumentParser(description="Seed restaurací z Overpass API do CheckFood DB")
    parser.add_argument("--db-host", default="127.0.0.1", help="DB host (default: 127.0.0.1)")
    parser.add_argument("--db-port", default="5432", help="DB port (default: 5432)")
    parser.add_argument("--db-name", default="checkfood", help="DB name (default: checkfood)")
    parser.add_argument("--db-user", default="postgres", help="DB user (default: postgres)")
    parser.add_argument("--db-pass", required=True, help="DB password")
    parser.add_argument("--dry-run", action="store_true", help="Jen stáhni a zpracuj, nevkládej do DB")
    args = parser.parse_args()

    # 1. Fetch
    elements = fetch_overpass()

    # 2. Process
    restaurants = process_elements(elements)

    if args.dry_run:
        print("\n[DRY RUN] Žádná data nebyla vložena do DB.")
        # Ukázka prvních 3
        for r in restaurants[:3]:
            print(f"  {r['name']} | {r['cuisine_type']} | {r['city']} | {r['lat']},{r['lon']}")
            if r["opening_hours"]:
                for oh in r["opening_hours"]:
                    status = "Zavřeno" if oh["is_closed"] else f"{oh['open_at']}-{oh['close_at']}"
                    print(f"    {oh['day_of_week']}: {status}")
        return

    # 3. Insert
    print(f"\nPřipojuji se k DB: {args.db_host}:{args.db_port}/{args.db_name}...")
    conn = psycopg2.connect(
        host=args.db_host,
        port=args.db_port,
        dbname=args.db_name,
        user=args.db_user,
        password=args.db_pass,
    )
    try:
        insert_restaurants(restaurants, conn)
    finally:
        conn.close()


if __name__ == "__main__":
    main()
