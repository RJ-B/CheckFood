#!/usr/bin/env bash
# ------------------------------------------------------------
# build_prod.sh — production release build with obfuscation
#
# Obfuscation: Dart symbols stripped + debug info written to `symbols/`.
# Upload `symbols/` to Sentry / Crashlytics to de-obfuscate crash reports.
#
# Prereqs (all gitignored, supplied by CI secret store or local ops):
#   - android/local.properties          → MAPS_API_KEY=...
#   - ios/Flutter/Secrets.xcconfig       → MAPS_API_KEY=...
#   - env vars GOOGLE_WEB_CLIENT_ID, GOOGLE_MAPS_API_KEY
#
# Usage:
#   scripts/build_prod.sh apk            # Android release APK
#   scripts/build_prod.sh appbundle      # Android Play Store bundle
#   scripts/build_prod.sh ipa            # iOS IPA
# ------------------------------------------------------------
set -euo pipefail

cd "$(dirname "$0")/.."

TARGET="${1:?usage: build_prod.sh <apk|appbundle|ipa>}"
shift || true

API_BASE_URL="${API_BASE_URL:-https://checkfood-api-809801655996.europe-central2.run.app/api}"
GOOGLE_WEB_CLIENT_ID="${GOOGLE_WEB_CLIENT_ID:?GOOGLE_WEB_CLIENT_ID must be set in the environment}"
APPLE_CLIENT_ID="${APPLE_CLIENT_ID:-com.checkfood.checkfood_client}"
APPLE_REDIRECT_URL="${APPLE_REDIRECT_URL:-https://checkfood-api-809801655996.europe-central2.run.app/api/oauth/apple/callback}"
GOOGLE_MAPS_API_KEY="${GOOGLE_MAPS_API_KEY:?GOOGLE_MAPS_API_KEY must be set in the environment (used by Dart Places API)}"

SYMBOLS_DIR="${SYMBOLS_DIR:-build/symbols}"

exec flutter build "$TARGET" \
  --release \
  --obfuscate \
  --split-debug-info="$SYMBOLS_DIR" \
  --dart-define=API_BASE_URL="$API_BASE_URL" \
  --dart-define=GOOGLE_WEB_CLIENT_ID="$GOOGLE_WEB_CLIENT_ID" \
  --dart-define=APPLE_CLIENT_ID="$APPLE_CLIENT_ID" \
  --dart-define=APPLE_REDIRECT_URL="$APPLE_REDIRECT_URL" \
  --dart-define=GOOGLE_MAPS_API_KEY="$GOOGLE_MAPS_API_KEY" \
  "$@"
