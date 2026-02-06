package com.checkfood.checkfoodservice.cache.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Konfigurační vlastnosti cache.
 */
@ConfigurationProperties(prefix = "cache")
public class CacheProperties {

    /**
     * Globální zapnutí / vypnutí cache.
     */
    private boolean enabled = true;

    /**
     * Výchozí TTL v sekundách.
     */
    private long defaultTtlSeconds = 300;

    /**
     * Maximální počet položek (pro lokální cache).
     */
    private long maxSize = 10_000;

    // getters / setters

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public long getDefaultTtlSeconds() {
        return defaultTtlSeconds;
    }

    public void setDefaultTtlSeconds(long defaultTtlSeconds) {
        this.defaultTtlSeconds = defaultTtlSeconds;
    }

    public long getMaxSize() {
        return maxSize;
    }

    public void setMaxSize(long maxSize) {
        this.maxSize = maxSize;
    }
}
