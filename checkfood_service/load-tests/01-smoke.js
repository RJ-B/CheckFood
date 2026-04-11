// Smoke test — the lightest possible "does the system respond" check.
//
// 1 VU, 30 seconds. Designed to run on every push to main as a CI
// gate. If this fails the whole stack is dead, not a performance issue.
//
// Run locally:
//   k6 run 01-smoke.js
//
// Run against staging:
//   K6_BASE_URL=https://staging-api.checkfood.cz/api k6 run 01-smoke.js

import { sleep } from 'k6';
import { browseRound, nearest, allMarkers } from './lib/common.js';

export const options = {
  vus: 1,
  duration: '30s',
  thresholds: {
    // Smoke test must be boring: near-zero errors, fast responses.
    checkfood_success_rate: ['rate>0.99'],
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<800'],
  },
  tags: { scenario: 'smoke' },
};

export default function () {
  // Hit the two endpoints most likely to break under a cold DB:
  // spatial query (PostGIS) and the unpaginated markers dump.
  allMarkers();
  nearest();
  sleep(1);
}
