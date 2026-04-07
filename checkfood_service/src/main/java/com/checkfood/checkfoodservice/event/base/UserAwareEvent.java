package com.checkfood.checkfoodservice.event.base;

/**
 * Základ pro doménové události, které jsou vázané na konkrétního uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public abstract class UserAwareEvent extends DomainEvent {

    private final Long userId;

    /**
     * Vytvoří událost spojenou s daným uživatelem.
     *
     * @param userId identifikátor uživatele
     */
    protected UserAwareEvent(Long userId) {
        this.userId = userId;
    }

    /**
     * Vrátí identifikátor uživatele, jehož se událost týká.
     *
     * @return ID uživatele
     */
    public Long getUserId() {
        return userId;
    }
}
