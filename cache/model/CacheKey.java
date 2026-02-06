package com.checkfood.checkfoodservice.cache.model;

/**
 * Typově bezpečný obal nad klíčem cache.
 */
public class CacheKey {

    private final String value;

    private CacheKey(String value) {
        this.value = value;
    }

    public static CacheKey of(String value) {
        return new CacheKey(value);
    }

    public String getValue() {
        return value;
    }

    @Override
    public String toString() {
        return value;
    }
}
