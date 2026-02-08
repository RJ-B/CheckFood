package com.checkfood.checkfoodservice.event.base;

/**
 * Základ pro události, které souvisí s konkrétním uživatelem.
 */
public abstract class UserAwareEvent extends DomainEvent {

    private final Long userId;

    protected UserAwareEvent(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }
}
