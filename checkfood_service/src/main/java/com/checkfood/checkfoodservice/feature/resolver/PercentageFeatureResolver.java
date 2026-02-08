package com.checkfood.checkfoodservice.feature.resolver;

import com.checkfood.checkfoodservice.feature.model.FeatureFlag;

/**
 * Resolver založený na procentech.
 *
 * Používá se pro:
 * - postupné rollouty
 * - A/B testování
 */
public class PercentageFeatureResolver implements FeatureResolver {

    @Override
    public boolean isEnabled(FeatureFlag featureFlag) {
        // TODO:
        // - deterministický výpočet na základě hash
        return false;
    }
}
