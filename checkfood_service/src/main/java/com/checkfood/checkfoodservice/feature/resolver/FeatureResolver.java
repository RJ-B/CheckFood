package com.checkfood.checkfoodservice.feature.resolver;

import com.checkfood.checkfoodservice.feature.model.FeatureFlag;

/**
 * Kontrakt pro vyhodnocení stavu feature flagu.
 *
 * Resolver:
 * - rozhoduje JEN o zapnutí / vypnutí
 * - neobsahuje business logiku
 */
public interface FeatureResolver {

    boolean isEnabled(FeatureFlag featureFlag);
}
