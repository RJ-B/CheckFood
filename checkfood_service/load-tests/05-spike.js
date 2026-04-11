// Spike test — sudden traffic surge, then drop.
//
// Simulates a marketing push: TV ad airs, 200 people open the
// Explore screen in 15 seconds. We want to see:
//   1. Cloud Run cold-starts don't cause a wall of 5xx
//   2. DB connection pool saturates gracefully (429 > 500)
//   3. Latency recovers quickly once the spike passes
//
// Short enough to be practical (~2-3 minutes), but hard enough
// to expose scaling bugs. Run on workflow_dispatch.

import { sleep } from 'k6';
import { nearest, allMarkers } from './lib/common.js';

export const options = {
  stages: [
    { duration: '15s', target: 5   },  // baseline
    { duration: '15s', target: 200 },  // SPIKE
    { duration: '45s', target: 200 },  // hold at peak
    { duration: '15s', target: 5   },  // recovery
    { duration: '30s', target: 5   },  // back to baseline
  ],
  thresholds: {
    // Accept some failures during the spike itself, but the system
    // must NOT stay broken afterwards. We watch total error rate.
    checkfood_success_rate: ['rate>0.85'],
    http_req_failed: ['rate<0.15'],
    http_req_duration: ['p(95)<2000'],
  },
  tags: { scenario: 'spike' },
};

export default function () {
  // Skip the full browseRound — spike specifically hits the
  // two endpoints that the Explore screen fires on app open.
  allMarkers();
  nearest();
  sleep(1);
}
