package com.checkfood.checkfoodservice.support;

import jakarta.persistence.EntityManagerFactory;

import org.hibernate.SessionFactory;
import org.hibernate.stat.Statistics;

/**
 * Test helper that reads Hibernate's built-in {@link Statistics} to count
 * the number of prepared statements that actually hit the database during
 * a block of test code.
 *
 * <p>Used to pin down N+1 regressions. A typical usage:
 *
 * <pre>{@code
 * @Autowired EntityManagerFactory emf;
 *
 * @Test
 * void listsRestaurantsWithoutN1() {
 *     HibernateQueryCounter counter = HibernateQueryCounter.reset(emf);
 *     restaurantService.getMyRestaurants(userId);
 *     counter.assertAtMost(3, "getMyRestaurants");
 * }
 * }</pre>
 *
 * <p>The 3-statement budget in the example covers the employee fetch,
 * the restaurant fetch, and the opening-hours collection join.
 * If Hibernate ever starts emitting a per-row query for menu items
 * (classic N+1), the counter jumps to 3 + N and the test fails with
 * the actual number.
 *
 * <p>Hibernate statistics must be enabled in the test profile via
 * {@code spring.jpa.properties.hibernate.generate_statistics=true} —
 * see {@code application-test.properties}.
 *
 * @author CheckFood team, Apr 2026
 */
public final class HibernateQueryCounter {

    private final Statistics statistics;
    private final long baselineQueries;
    private final long baselineLoads;

    private HibernateQueryCounter(Statistics stats) {
        this.statistics = stats;
        this.baselineQueries = stats.getPrepareStatementCount();
        this.baselineLoads = stats.getEntityLoadCount();
    }

    /** Captures the current counters as the baseline for delta checks. */
    public static HibernateQueryCounter reset(EntityManagerFactory emf) {
        Statistics stats = emf.unwrap(SessionFactory.class).getStatistics();
        if (!stats.isStatisticsEnabled()) {
            stats.setStatisticsEnabled(true);
        }
        stats.clear();
        return new HibernateQueryCounter(stats);
    }

    /** Raw number of prepared statements executed since {@link #reset}. */
    public long prepareStatementCount() {
        return statistics.getPrepareStatementCount() - baselineQueries;
    }

    /** Number of entity loads (one per row, regardless of whether they share a query). */
    public long entityLoadCount() {
        return statistics.getEntityLoadCount() - baselineLoads;
    }

    /**
     * Asserts that no more than {@code limit} statements fired since
     * {@link #reset}. Error message names the code path being measured
     * so a failing test prints e.g. {@code "getMyRestaurants: expected <=3
     * statements, got 12 (probable N+1)"}.
     */
    public void assertAtMost(long limit, String codePath) {
        long actual = prepareStatementCount();
        if (actual > limit) {
            throw new AssertionError(
                    codePath + ": expected <= " + limit
                            + " prepared statements, got " + actual
                            + " (likely N+1 regression — entity loads: "
                            + entityLoadCount() + ")"
            );
        }
    }

    /**
     * Asserts that no statements fired — useful for read-through caches
     * and second-level cache hit checks.
     */
    public void assertNoQueries(String codePath) {
        assertAtMost(0, codePath);
    }
}
