// Shared helpers for the CheckFood k6 load-test suite.
//
// Keeps the individual scenario scripts thin: they just import `url`,
// `poolLogin`, and the endpoint-hitter functions from here, then pick
// their own traffic shape.

import http from 'k6/http';
import { check, sleep, fail } from 'k6';
import { Counter, Rate, Trend } from 'k6/metrics';

// ---------------------------------------------------------------------
// Configuration — read from env vars so the same scripts run against
// localhost / staging / prod without code changes.
// ---------------------------------------------------------------------
export const BASE_URL = __ENV.K6_BASE_URL || 'http://localhost:8081/api';

// TEST_USERS is a JSON array literal:
//   export TEST_USERS='[{"email":"load1@checkfood.test","password":"..."}]'
// Falls back to a single default so a dry run against a fresh dev DB
// doesn't explode at import time.
let _users;
try {
  _users = __ENV.TEST_USERS
    ? JSON.parse(__ENV.TEST_USERS)
    : [{ email: 'load1@checkfood.test', password: 'LoadTest1234!' }];
} catch (e) {
  fail('TEST_USERS env var is not valid JSON: ' + e.message);
}
export const TEST_USERS = _users;

// Custom metrics — surfaced at the end of the run + in the HTML report.
export const loginFailures = new Counter('checkfood_login_failures');
export const successRate = new Rate('checkfood_success_rate');
export const endpointLatency = new Trend('checkfood_endpoint_latency', true);

// Cached tokens per VU so we login once per iteration cohort.
const tokenCache = {};

/**
 * Log in as a pooled test user (picked round-robin by the k6 VU id) and
 * return a Bearer token. Caches per VU so multiple calls in the same
 * iteration reuse the same login.
 */
export function poolLogin() {
  const user = TEST_USERS[(__VU - 1) % TEST_USERS.length];
  if (tokenCache[user.email]) return tokenCache[user.email];

  const res = http.post(
    BASE_URL + '/auth/login',
    JSON.stringify({
      email: user.email,
      password: user.password,
      deviceIdentifier: 'k6-vu-' + __VU,
      deviceName: 'k6',
      deviceType: 'ANDROID',
    }),
    { headers: { 'Content-Type': 'application/json' } }
  );

  const ok = check(res, {
    'login 200': (r) => r.status === 200,
    'login has access token': (r) => r.json('accessToken') !== undefined,
  });
  if (!ok) {
    loginFailures.add(1);
    return null;
  }
  const token = res.json('accessToken');
  tokenCache[user.email] = token;
  return token;
}

export function nearest() {
  const res = http.get(
    BASE_URL + '/v1/restaurants/nearest?lat=49.74&lng=13.37&page=0&size=10'
  );
  endpointLatency.add(res.timings.duration, { endpoint: 'nearest' });
  successRate.add(res.status === 200);
}

export function allMarkers() {
  const res = http.get(BASE_URL + '/v1/restaurants/all-markers');
  endpointLatency.add(res.timings.duration, { endpoint: 'all-markers' });
  successRate.add(res.status === 200);
}

export function restaurantDetail(id) {
  const res = http.get(BASE_URL + '/v1/restaurants/' + id);
  endpointLatency.add(res.timings.duration, { endpoint: 'detail' });
  successRate.add(res.status === 200);
}

export function publicMenu(id) {
  const res = http.get(BASE_URL + '/v1/restaurants/' + id + '/menu');
  endpointLatency.add(res.timings.duration, { endpoint: 'menu' });
  successRate.add(res.status === 200);
}

/**
 * Runs one "user session" round: pick a restaurant from the markers
 * list, hit its detail + menu, take a short pause. Mirrors the shape
 * of real-user traffic fetched by the mobile client on Explore screen.
 */
export function browseRound() {
  allMarkers();
  nearest();
  // Pretend to scroll a bit.
  sleep(1);

  // Pick a "random" UUID-looking string that won't exist — we measure
  // 404 path latency, not DB contention on a specific row. If you seed
  // real restaurant IDs into TEST_RESTAURANT_IDS, this uses them.
  const ids = (__ENV.TEST_RESTAURANT_IDS || '').split(',').filter(Boolean);
  const id = ids.length > 0
    ? ids[Math.floor(Math.random() * ids.length)]
    : '00000000-0000-0000-0000-000000000000';
  restaurantDetail(id);
  publicMenu(id);
}
