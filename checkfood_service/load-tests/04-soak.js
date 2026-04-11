// Soak test — medium load held for a long time.
//
// Hunts for slow leaks: JDBC pool exhaustion, connection handles
// that never get returned, Hibernate second-level cache unbounded
// growth, JVM heap creeping up under steady pressure.
//
// 30 VUs for 30 minutes. Memory + DB connection counts should be
// flat at the end — compare first 5min vs last 5min latency.
//
// Only run on workflow_dispatch. Way too long for PR gate.

import { sleep } from 'k6';
import { browseRound } from './lib/common.js';

export const options = {
  stages: [
    { duration: '2m',  target: 30 },   // warm up
    { duration: '26m', target: 30 },   // steady soak
    { duration: '2m',  target: 0 },    // cool down
  ],
  thresholds: {
    // Soak should NOT degrade over time. If p(95) in the last minute
    // is worse than the first minute, we have a leak somewhere.
    checkfood_success_rate: ['rate>0.98'],
    http_req_failed: ['rate<0.02'],
    'checkfood_endpoint_latency{endpoint:nearest}': ['p(95)<600'],
  },
  tags: { scenario: 'soak' },
};

export default function () {
  browseRound();
  sleep(3);
}
