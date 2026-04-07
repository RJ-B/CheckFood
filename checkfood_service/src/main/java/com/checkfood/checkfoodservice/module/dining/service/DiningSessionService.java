package com.checkfood.checkfoodservice.module.dining.service;

import com.checkfood.checkfoodservice.module.dining.entity.DiningSession;
import com.checkfood.checkfoodservice.module.dining.entity.DiningSessionMember;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Service interface pro správu skupinových sezení u stolu — vytváření, připojování a uzavírání sezení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface DiningSessionService {

    /**
     * Vytvoří nové skupinové sezení u stolu a zaregistruje hostitele jako prvního člena.
     * Pokud pro danou rezervaci již aktivní sezení existuje, vrátí jej.
     *
     * @param restaurantId UUID restaurace
     * @param tableId      UUID stolu
     * @param reservationId UUID rezervace, nebo {@code null} pro walk-in
     * @param userId       ID uživatele — hostitele sezení
     * @return vytvořené nebo existující aktivní sezení
     */
    DiningSession createSession(UUID restaurantId, UUID tableId, UUID reservationId, Long userId);

    /**
     * Připojí uživatele k existujícímu aktivnímu sezení pomocí pozvánkového kódu.
     * Operace je idempotentní — pokud je uživatel již členem, vrátí sezení bez chyby.
     *
     * @param inviteCode pozvánkový kód sezení
     * @param userId     ID uživatele, který se připojuje
     * @return sezení, ke kterému se uživatel připojil
     */
    DiningSession joinSession(String inviteCode, Long userId);

    /**
     * Vyhledá aktivní sezení, jehož je uživatel členem.
     *
     * @param userId ID uživatele
     * @return Optional s aktivním sezením, nebo prázdný Optional
     */
    Optional<DiningSession> findActiveSessionForUser(Long userId);

    /**
     * Vrátí seznam členů daného sezení.
     *
     * @param sessionId UUID sezení
     * @return seznam členů sezení
     */
    List<DiningSessionMember> getMembers(UUID sessionId);

    /**
     * Uzavře sezení. Operaci může provést pouze hostitel (tvůrce) sezení.
     *
     * @param sessionId UUID sezení
     * @param userId    ID uživatele provádějícího uzavření
     */
    void closeSession(UUID sessionId, Long userId);
}
