// Load test — "normal peak traffic" shape.
//
// Ramps to 50 VUs over 30s, holds for 4 minutes, ramps down.
// Threshold: p(95) < 500ms on read endpoints. This is the target
// SLO for the public restaurant browsing endpoints.
//
// Not run on every push — too long. Run on workflow_dispatch and
// nightly via load-test.yml.

import { sleep } from 'k6';
import { browseRound } from './lib/common.js';

export const options = {
  stages: [
    { duration: '30s', target: 50 },  // warm up
    { duration: '4m',  target: 50 },  // steady peak
    { duration: '30s', target: 0 },   // cool down
  ],
  thresholds: {
    checkfood_success_rate: ['rate>0.98'],
    http_req_failed: ['rate<0.02'],
    // p(95) targets per endpoint — markers is unpaginated so budget higher.
    'checkfood_endpoint_latency{endpoint:nearest}':    ['p(95)<500'],
    'checkfood_endpoint_latency{endpoint:all-markers}':['p(95)<1500'],
    'checkfood_endpoint_latency{endpoint:detail}':     ['p(95)<400'],
    'checkfood_endpoint_latency{endpoint:menu}':       ['p(95)<400'],
  },
  tags: { scenario: 'load' },
};

export default function () {
  browseRound();
  sleep(2);
}
