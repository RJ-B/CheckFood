package com.checkfood.checkfoodservice.module.reservation.entity;

public enum ReservationStatus {
    PENDING_CONFIRMATION,
    CONFIRMED,
    RESERVED,   // backward compat with existing DB rows
    REJECTED,
    CANCELLED,
    COMPLETED
}
