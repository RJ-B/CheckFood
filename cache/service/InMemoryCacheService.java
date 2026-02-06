package com.checkfood.checkfoodservice.cache.service;

import com.checkfood.checkfoodservice.cache.model.CacheKey;
import com.checkfood.checkfoodservice.cache.model.CacheName;
import com.checkfood.checkfoodservice.cache.service.CacheService;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Jednoduchá in-memory cache pro LOCAL profil.
 *
 * Používá se pouze pro vývoj.
 * V produkci bude nahrazena Redis implementací.
 */
@Service
@Profile("local")
public class InMemoryCacheService implements CacheService {

    /**
     * cacheName -> (key -> value)
     */
    private final Map<CacheName, Map<String, Object>> store =
            new ConcurrentHashMap<>();


    @Override
    @SuppressWarnings("unchecked")
    public <T> T get(CacheName cacheName, CacheKey key, Class<T> type) {

        Map<String, Object> cache = store.get(cacheName);

        if (cache == null) {
            return null;
        }

        Object value = cache.get(key.value());

        if (value == null) {
            return null;
        }

        return type.cast(value);
    }


    @Override
    public void put(CacheName cacheName, CacheKey key, Object value) {

        store
                .computeIfAbsent(cacheName, c -> new ConcurrentHashMap<>())
                .put(key.value(), value);
    }


    @Override
    public void evict(CacheName cacheName, CacheKey key) {

        Map<String, Object> cache = store.get(cacheName);

        if (cache != null) {
            cache.remove(key.value());
        }
    }


    @Override
    public void clear(CacheName cacheName) {

        Map<String, Object> cache = store.get(cacheName);

        if (cache != null) {
            cache.clear();
        }
    }
}
