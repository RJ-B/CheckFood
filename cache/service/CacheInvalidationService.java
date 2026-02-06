package com.checkfood.checkfoodservice.cache.service;

import com.checkfood.checkfoodservice.cache.model.CacheName;
import org.springframework.stereotype.Service;

/**
 * Centralizuje invalidaci cache.
 */
@Service
public class CacheInvalidationService {

    private final CacheService cacheService;

    public CacheInvalidationService(CacheService cacheService) {
        this.cacheService = cacheService;
    }

    /**
     * Invalidate veškeré cache spojené s uživateli.
     */
    public void invalidateUsers() {
        cacheService.clear(CacheName.USERS);
    }

    /**
     * Invalidate veškeré cache spojené s objednávkami.
     */
    public void invalidateOrders() {
        cacheService.clear(CacheName.ORDERS);
    }

    // TODO:
    // - jemnější invalidace (konkrétní ID)
    // - návaznost na eventy (OrderCreatedEvent, UserUpdatedEvent)
}
