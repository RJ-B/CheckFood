package com.checkfood.checkfoodservice.module.order.dining.service;

import com.checkfood.checkfoodservice.module.order.dining.dto.response.DiningContextResponse;

import java.util.Optional;

/**
 * Service interface pro určení aktivního kontextu stravování uživatele
 * na základě platných rezervací a sezení u stolu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface DiningContextService {

    /**
     * Vrátí aktivní kontext stravování uživatele, nebo vyhodí výjimku, pokud žádný neexistuje.
     *
     * @param userId ID uživatele
     * @return aktivní dining kontext
     * @throws com.checkfood.checkfoodservice.module.order.dining.exception.DiningContextException
     *         pokud uživatel nemá aktivní rezervaci ani sezení u stolu
     */
    DiningContextResponse getActiveDiningContext(Long userId);

    /**
     * Hledá aktivní kontext stravování uživatele a vrátí jej jako Optional.
     *
     * @param userId ID uživatele
     * @return Optional s aktivním dining kontextem, nebo prázdný Optional
     */
    Optional<DiningContextResponse> findActiveDiningContext(Long userId);
}
