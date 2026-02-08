package com.checkfood.checkfoodservice.scheduler.job;

/**
 * Úloha pro expirování rezervací.
 *
 * Typický business-trigger:
 * - změní stav rezervace
 * - publikuje event
 */
public class ReservationExpirationJob {

    // TODO:
    // - @Scheduled
    // - publikace ReservationExpiredEvent
}
