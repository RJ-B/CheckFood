package com.checkfood.checkfoodservice.module.dining.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Chybové kódy specifické pro modul dining context a dining session,
 * kategorizované dle původu chyby (BUSINESS, SYSTEM).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@RequiredArgsConstructor
public enum DiningContextErrorCode {

    NO_ACTIVE_CONTEXT("BUSINESS"),
    CONTEXT_MISMATCH("BUSINESS"),
    DINING_SYSTEM_ERROR("SYSTEM");

    private final String category;
}
