package com.checkfood.checkfoodservice.module.restaurant.entity.employee;

import java.util.EnumSet;
import java.util.Set;

/**
 * Granulární oprávnění zaměstnance v restauraci.
 * Výchozí sady oprávnění pro jednotlivé role jsou definovány metodou {@link #defaultsForRole(RestaurantEmployeeRole)}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum EmployeePermission {
    CONFIRM_RESERVATION,
    EDIT_RESERVATION,
    CANCEL_RESERVATION,
    CHECK_IN_RESERVATION,
    COMPLETE_RESERVATION,
    EDIT_RESTAURANT_INFO,
    EDIT_RESERVATION_DURATION,
    VIEW_STATISTICS,
    VIEW_RESTAURANT_INFO,
    MANAGE_EMPLOYEES,
    MANAGE_MENU;

    /**
     * Vrací výchozí sadu oprávnění pro danou roli.
     *
     * @param role role zaměstnance
     * @return sada výchozích oprávnění pro roli
     */
    public static Set<EmployeePermission> defaultsForRole(RestaurantEmployeeRole role) {
        return switch (role) {
            case OWNER -> EnumSet.allOf(EmployeePermission.class);
            case MANAGER -> EnumSet.of(
                CONFIRM_RESERVATION, EDIT_RESERVATION, CANCEL_RESERVATION,
                CHECK_IN_RESERVATION, COMPLETE_RESERVATION,
                EDIT_RESTAURANT_INFO, EDIT_RESERVATION_DURATION,
                VIEW_STATISTICS, VIEW_RESTAURANT_INFO, MANAGE_MENU
            );
            case STAFF -> EnumSet.of(
                CONFIRM_RESERVATION, CHECK_IN_RESERVATION,
                COMPLETE_RESERVATION, VIEW_RESTAURANT_INFO
            );
            case HOST -> EnumSet.of(VIEW_RESTAURANT_INFO);
        };
    }
}
