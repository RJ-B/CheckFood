package com.checkfood.checkfoodservice.cache.service;

import com.checkfood.checkfoodservice.cache.model.CacheKey;
import com.checkfood.checkfoodservice.cache.model.CacheName;

/**
 * Abstrakce nad cache vrstvou.
 *
 * Application service ví CO cachovat,
 * ale neví JAK.
 */
public interface CacheService {

    <T> T get(CacheName cacheName, CacheKey key, Class<T> type);

    void put(CacheName cacheName, CacheKey key, Object value);

    void evict(CacheName cacheName, CacheKey key);

    void clear(CacheName cacheName);
}
