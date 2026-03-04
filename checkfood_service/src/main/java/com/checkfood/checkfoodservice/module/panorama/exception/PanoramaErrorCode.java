package com.checkfood.checkfoodservice.module.panorama.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

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
