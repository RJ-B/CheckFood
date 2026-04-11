# CheckFood load tests (k6)

Synthetic load / stress / soak / spike scenarios for the CheckFood
Spring backend. Runnable with [`k6`](https://k6.io) against either:

- A locally-running backend (`./mvnw spring-boot:run` in another shell)
- A deployed staging environment (`https://staging.checkfood.cz`)
- The production Cloud Run service (only during a scheduled maintenance
  window — production load tests can and will trigger the Cloud Run
  scaler)

## Prerequisites

```bash
brew install k6                       # macOS
sudo apt install k6                   # Debian/Ubuntu
```

Check your install: `k6 version`.

## Running

All scripts take a single env var:

```bash
export K6_BASE_URL=http://localhost:8081/api   # or staging / prod

k6 run 01-smoke.js
k6 run 02-load.js
k6 run 03-stress.js
k6 run 04-soak.js
k6 run 05-spike.js
```

For CI-friendly output add `--out json=report.json` and feed `report.json`
into the GitHub Actions summary step in `.github/workflows/load-test.yml`.

## Scripts

| File | Duration | Peak | What it tells you |
|---|---|---|---|
| `01-smoke.js`  | 30 s  | 1 VU    | Did we break anything? Fastest sanity check. |
| `02-load.js`   | 5 min | 50 VUs  | Can we handle a normal lunch rush? Thresholds: `p(95) < 500 ms`, error rate `< 1 %`. |
| `03-stress.js` | 10 min| 300 VUs | Where does it break? Ramps until an SLO breach is inevitable — we capture the knee. |
| `04-soak.js`   | 30 min| 30 VUs  | Any memory leaks / connection starvation? Steady load for a long time, we watch heap + connection pool. |
| `05-spike.js`  | 2 min | 5 → 200 → 5 VUs | How fast do we recover? Simulates an instant-traffic spike (push notification, promo). |

Each script has the same five endpoints in its rotation:

1. `GET /api/v1/restaurants/nearest` — geospatial list (cached 5 min)
2. `GET /api/v1/restaurants/{id}` — restaurant detail
3. `GET /api/v1/restaurants/{id}/menu` — public menu
4. `POST /api/auth/login` — auth (rate-limited, so capped at 20/min)
5. `GET /api/v1/restaurants/all-markers` — marker batch download

Login is gated at 20/min per IP so the load tests use a pool of
pre-provisioned users (`TEST_USERS` env var) and rotate through them.
When running locally you can seed the users via
`scripts/seed_load_test_users.sh` (TODO).

## Thresholds

The `options.thresholds` block in each script is the hard gate:

```js
thresholds: {
  http_req_failed:      ['rate<0.01'],   // < 1 % errors
  http_req_duration:    ['p(95)<500'],   // 95 % of requests under 500 ms
  http_req_duration:    ['p(99)<1500'],  // 99 % under 1.5 s
}
```

If any threshold fails, `k6 run` exits non-zero — CI turns red.

## CI

`.github/workflows/load-test.yml` runs `01-smoke.js` + `02-load.js` on
every push to `main` against the staging environment. Stress / soak /
spike are manual-dispatch only (`workflow_dispatch`) because they take
10–30 minutes and can burn Cloud Run autoscaler budget.

The workflow requires two GitHub secrets:

- `LOAD_TEST_BASE_URL` — e.g. `https://staging.checkfood.cz/api`
- `LOAD_TEST_USERS` — JSON array of `{email,password}` seed users

## Not covered here

- Database-level load (pg_bench against Cloud SQL) — separate tool.
- Cost / billing impact — k6 reports latency and throughput, not
  Google Cloud Run billing. Check that separately after each run.
- Real-user monitoring (RUM) — k6 is synthetic only.
