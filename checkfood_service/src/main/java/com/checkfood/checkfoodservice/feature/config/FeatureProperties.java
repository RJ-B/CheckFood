package com.checkfood.checkfoodservice.feature.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Konfigurační vlastnosti feature flagů mapované z application-*.properties.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@ConfigurationProperties(prefix = "feature")
public class FeatureProperties {

    /**
     * Globální zapnutí / vypnutí feature flag systému.
     */
    private boolean enabled = true;

    // TODO: definice konkrétních flagů a jejich defaultních hodnot

    /**
     * Vrátí příznak globálního zapnutí feature flag systému.
     *
     * @return {@code true} pokud je feature flag systém aktivní
     */
    public boolean isEnabled() {
        return enabled;
    }

    /**
     * Nastaví příznak globálního zapnutí feature flag systému.
     *
     * @param enabled {@code true} pro aktivaci
     */
    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }
}
