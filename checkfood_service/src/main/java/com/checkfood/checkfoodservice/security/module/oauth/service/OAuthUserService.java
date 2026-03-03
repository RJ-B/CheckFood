package com.checkfood.checkfoodservice.security.module.oauth.service;

import com.checkfood.checkfoodservice.security.module.oauth.provider.OAuthUserInfo;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;

/**
 * Rozhraní pro správu uživatelských entit v rámci OAuth procesu.
 * Definuje operace pro vyhledání existujících uživatelů nebo registraci nových (JIT provisioning).
 */
public interface OAuthUserService {

    /**
     * Získá existujícího uživatele z databáze nebo vytvoří nového na základě
     * ověřených informací od OAuth poskytovatele.
     *
     * @param userInfo Ověřená data uživatele (email, providerId, atd.)
     * @return Uložená nebo aktualizovaná entita uživatele
     */
    UserEntity getOrCreateUser(OAuthUserInfo userInfo);
}