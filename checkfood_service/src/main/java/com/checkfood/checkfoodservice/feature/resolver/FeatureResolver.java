package com.checkfood.checkfoodservice.feature.resolver;

import com.checkfood.checkfoodservice.feature.model.FeatureFlag;

/**
 * Kontrakt pro vyhodnocení stavu feature flagu.
 * Resolver rozhoduje pouze o zapnutí nebo vypnutí funkcionality a neobsahuje business logiku.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface FeatureResolver {

    /**
     * Vyhodnotí, zda je daná feature aktivní.
     *
     * @param featureFlag feature flag k vyhodnocení
     * @return {@code true} pokud je feature aktivní
     */
    boolean isEnabled(FeatureFlag featureFlag);
}
