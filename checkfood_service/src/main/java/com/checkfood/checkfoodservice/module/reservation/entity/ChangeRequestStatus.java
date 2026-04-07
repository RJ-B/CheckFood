package com.checkfood.checkfoodservice.module.reservation.entity;

/**
 * Výčet stavů návrhu změny rezervace ({@link ReservationChangeRequest}).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum ChangeRequestStatus {
    PENDING,
    ACCEPTED,
    DECLINED
}
