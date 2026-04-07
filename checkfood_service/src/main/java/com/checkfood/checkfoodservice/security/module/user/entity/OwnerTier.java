package com.checkfood.checkfoodservice.security.module.user.entity;

/**
 * Výčet úrovní vlastníka restaurace.
 * Aplikuje se výhradně na uživatele s rolí OWNER — ostatní uživatelé mají hodnotu {@code null}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum OwnerTier {
    /** Zkušební režim — restaurace viditelná jen pro vlastníka */
    TRIAL,
    /** Plný přístup — restaurace viditelná pro všechny */
    FULL
}
