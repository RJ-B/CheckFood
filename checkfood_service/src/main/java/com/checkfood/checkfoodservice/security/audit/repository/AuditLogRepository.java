package com.checkfood.checkfoodservice.security.audit.repository;

import com.checkfood.checkfoodservice.security.audit.entity.AuditLogEntity;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.stereotype.Repository;

import java.time.Instant;

/**
 * JPA repository pro správu auditních záznamů v databázi.
 * Poskytuje metody pro dotazování a mazání auditních logů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuditLogEntity
 */
@Repository
public interface AuditLogRepository
        extends JpaRepository<AuditLogEntity, Long> {

    /**
     * Vyhledá auditní záznamy konkrétního uživatele s podporou stránkování.
     *
     * @param userId ID uživatele
     * @param pageable parametry stránkování a řazení
     * @return stránkovaný seznam auditních záznamů daného uživatele
     */
    Page<AuditLogEntity> findByUserId(
            Long userId,
            Pageable pageable
    );


    /**
     * Vyhledá auditní záznamy vytvořené po určitém datu.
     *
     * @param from minimální datum vytvoření záznamu
     * @param pageable parametry stránkování a řazení
     * @return stránkovaný seznam auditních záznamů po daném datu
     */
    Page<AuditLogEntity> findByCreatedAtAfter(
            Instant from,
            Pageable pageable
    );


    /**
     * Smaže všechny auditní záznamy starší než zadané datum.
     * Používá se pro automatický úklid v rámci retenční politiky.
     *
     * @param before maximální datum vytvoření záznamu k smazání
     * @return počet smazaných záznamů
     */
    long deleteByCreatedAtBefore(Instant before);

}