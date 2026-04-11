// Stress test — push past expected peak to find the breakpoint.
//
// Ramps aggressively to 300 VUs. Goal is NOT to pass the same
// SLO as 02-load.js, it's to find where the service starts
// degrading so we have hard numbers for capacity planning and
// for setting Cloud Run maxInstances + HPA thresholds.
//
// Pass criterion: error rate stays below 10% even at peak. If
// the service 500s at 200 VUs we need to know BEFORE a holiday.
//
// Run with: k6 run 03-stress.js
// Expect ~10 minutes wall clock.

import { sleep } from 'k6';
import { browseRound } from './lib/common.js';

export const options = {
  stages: [
    { duration: '1m',  target: 50 },
    { duration: '2m',  target: 100 },
    { duration: '2m',  target: 200 },
    { duration: '3m',  target: 300 },  // beyond expected peak
    { duration: '2m',  target: 0 },
  ],
  thresholds: {
    // Intentionally permissive — we WANT to see the cliff.
    checkfood_success_rate: ['rate>0.9'],
    http_req_failed: ['rate<0.1'],
    // Record p(99) for postmortem analysis — no hard threshold.
    'checkfood_endpoint_latency{endpoint:nearest}': ['p(99)<3000'],
  },
  tags: { scenario: 'stress' },
};

export default function () {
  browseRound();
  sleep(1);
}
