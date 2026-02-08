package com.checkfood.checkfoodservice.feature.resolver;

import com.checkfood.checkfoodservice.feature.model.FeatureFlag;

/**
 * Nejjednodušší resolver – vrací
 * pevně nastavený boolean.
 *
 * Typicky používaný pro:
 * - globální zapnutí/vypnutí
 */
public class BooleanFeatureResolver implements FeatureResolver {

    @Override
    public boolean isEnabled(FeatureFlag featureFlag) {
        // TODO:
        // - načíst hodnotu z FeatureProperties
        return true;
    }
}
