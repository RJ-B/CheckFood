package com.checkfood.checkfoodservice.cache.resolver;

import com.checkfood.checkfoodservice.cache.model.CacheKey;

/**
 * Základní kontrakt pro generování cache klíčů.
 */
public interface CacheKeyResolver<T> {

    CacheKey resolve(T source);
}
