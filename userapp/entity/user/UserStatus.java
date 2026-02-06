package com.checkfood.checkfoodservice.application.entity.user;

/**
 * Stav uživatelského účtu.
 *
 * Používá se:
 * - v business pravidlech
 * - v security (blokovaný uživatel)
 */
public enum UserStatus {
    ACTIVE,
    BLOCKED,
    DELETED
}
