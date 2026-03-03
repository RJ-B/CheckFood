package com.checkfood.checkfoodservice.module.dining.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum DiningContextErrorCode {

    NO_ACTIVE_CONTEXT("BUSINESS"),
    CONTEXT_MISMATCH("BUSINESS"),
    DINING_SYSTEM_ERROR("SYSTEM");

    private final String category;
}
