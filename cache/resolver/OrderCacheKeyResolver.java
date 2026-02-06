package com.checkfood.checkfoodservice.cache.resolver;

import com.checkfood.checkfoodservice.cache.model.CacheKey;
import org.springframework.stereotype.Component;

/**
 * Generuje cache klíče pro objednávky.
 */
@Component
public class OrderCacheKeyResolver implements CacheKeyResolver<Long> {

    @Override
    public CacheKey resolve(Long orderId) {
        return CacheKey.of("order:" + orderId);
    }
}
