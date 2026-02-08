package com.checkfood.checkfoodservice.feature.resolver;

import com.checkfood.checkfoodservice.feature.model.FeatureFlag;

/**
 * Resolver založený na uživateli.
 *
 * Rozhoduje např. podle:
 * - role
 * - userId
 * - e-mailové domény
 */
public class UserBasedFeatureResolver implements FeatureResolver {

    @Override
    public boolean isEnabled(FeatureFlag featureFlag) {
        // TODO:
        // - rozhodování podle SecurityContext
        return false;
    }
}
