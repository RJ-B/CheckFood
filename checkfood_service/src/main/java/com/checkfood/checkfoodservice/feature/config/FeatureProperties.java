package com.checkfood.checkfoodservice.feature.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Konfigurační vlastnosti feature flagů.
 *
 * Typicky mapované z application-*.properties.
 */
@ConfigurationProperties(prefix = "feature")
public class FeatureProperties {

    /**
     * Globální zapnutí / vypnutí feature flag systému.
     */
    private boolean enabled = true;

    // TODO:
    // - definice konkrétních flagů a jejich defaultních hodnot

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }
}
