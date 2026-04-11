#!/usr/bin/env bash
# ------------------------------------------------------------
# build_dev.sh — run/build CheckFood client against a local backend
#
# Prereqs:
#   - Populate `android/local.properties` with MAPS_API_KEY=... (gitignored)
#   - Populate `ios/Flutter/Secrets.xcconfig` with MAPS_API_KEY=... (gitignored)
#   - Copy `.env.example` values for GOOGLE_WEB_CLIENT_ID into this script or
#     export them as shell env vars before running.
#
# Usage:
#   scripts/build_dev.sh                   # flutter run on default device
#   scripts/build_dev.sh -d <deviceId>     # flutter run on specific device
#   scripts/build_dev.sh build apk         # build debug APK
# ------------------------------------------------------------
set -euo pipefail

cd "$(dirname "$0")/.."

# Local backend — adjust to your LAN IP or emulator loopback
API_BASE_URL="${API_BASE_URL:-http://192.168.1.199:8081/api}"
GOOGLE_WEB_CLIENT_ID="${GOOGLE_WEB_CLIENT_ID:-}"
APPLE_CLIENT_ID="${APPLE_CLIENT_ID:-com.checkfood.checkfood_client}"
APPLE_REDIRECT_URL="${APPLE_REDIRECT_URL:-http://192.168.1.199:8081/api/oauth/apple/callback}"
# GOOGLE_MAPS_API_KEY is consumed by the Dart-side Places API (autocomplete).
# The native Maps SDK reads a separate value from local.properties / Secrets.xcconfig.
GOOGLE_MAPS_API_KEY="${GOOGLE_MAPS_API_KEY:-}"

if [ -z "$GOOGLE_WEB_CLIENT_ID" ]; then
  echo "WARNING: GOOGLE_WEB_CLIENT_ID is empty — OAuth will fail." >&2
fi

# Default action is `run`
ACTION="${1:-run}"
shift || true

exec flutter "$ACTION" \
  --dart-define=API_BASE_URL="$API_BASE_URL" \
  --dart-define=GOOGLE_WEB_CLIENT_ID="$GOOGLE_WEB_CLIENT_ID" \
  --dart-define=APPLE_CLIENT_ID="$APPLE_CLIENT_ID" \
  --dart-define=APPLE_REDIRECT_URL="$APPLE_REDIRECT_URL" \
  --dart-define=GOOGLE_MAPS_API_KEY="$GOOGLE_MAPS_API_KEY" \
  "$@"
