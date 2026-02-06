package com.checkfood.checkfoodservice.feature.service;

import com.checkfood.checkfoodservice.feature.model.FeatureFlag;

/**
 * Veřejné API pro práci s feature flagy.
 *
 * Používá se:
 * - v application/service
 * - v controller
 * - v security
 */
public interface FeatureService {

    boolean isEnabled(FeatureFlag featureFlag);
}
