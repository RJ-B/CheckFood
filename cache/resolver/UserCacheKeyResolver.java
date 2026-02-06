package com.checkfood.checkfoodservice.cache.resolver;

import com.checkfood.checkfoodservice.cache.model.CacheKey;
import org.springframework.stereotype.Component;

/**
 * Generuje cache klíče pro uživatele.
 */
@Component
public class UserCacheKeyResolver implements CacheKeyResolver<Long> {

    @Override
    public CacheKey resolve(Long userId) {
        return CacheKey.of("user:" + userId);
    }
}
