package com.checkfood.checkfoodservice.module.restaurant.entity.employee;

/**
 * Role zaměstnance v rámci restaurace, určující jeho základní úroveň přístupu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum RestaurantEmployeeRole {
    OWNER,
    MANAGER,
    STAFF,
    HOST
}