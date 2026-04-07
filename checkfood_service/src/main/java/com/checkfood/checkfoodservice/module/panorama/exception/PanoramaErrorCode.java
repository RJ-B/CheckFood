package com.checkfood.checkfoodservice.module.panorama.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Chybové kódy specifické pro panoramatický modul, kategorizované na byznys a systémové chyby.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@RequiredArgsConstructor
public enum PanoramaErrorCode {
    SESSION_NOT_FOUND("BUSINESS"),
    INVALID_SESSION_STATE("BUSINESS"),
    PANORAMA_SYSTEM_ERROR("SYSTEM"),
    STITCHING_FAILED("SYSTEM"),
    STITCHER_UNAVAILABLE("SYSTEM");

    private final String category;
}
