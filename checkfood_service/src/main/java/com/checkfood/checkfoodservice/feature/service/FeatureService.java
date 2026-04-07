package com.checkfood.checkfoodservice.feature.service;

import com.checkfood.checkfoodservice.feature.model.FeatureFlag;

/**
 * Veřejné API pro práci s feature flagy.
 * Používá se v application, service, controller a security vrstvách.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface FeatureService {

    /**
     * Vyhodnotí, zda je daná feature aktivní.
     *
     * @param featureFlag feature flag k vyhodnocení
     * @return {@code true} pokud je feature aktivní
     */
    boolean isEnabled(FeatureFlag featureFlag);
}
