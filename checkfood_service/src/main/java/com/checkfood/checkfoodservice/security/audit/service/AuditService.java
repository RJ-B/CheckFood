package com.checkfood.checkfoodservice.security.audit.service;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;
import com.checkfood.checkfoodservice.security.audit.entity.AuditLogEntity;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * Service interface pro správu a dotazování auditních záznamů.
 * Poskytuje metody pro persistenci nových logů, vyhledávání a údržbu auditních dat.
 *
 * @see AuditLogEntity
 * @see AuditAction
 * @see AuditStatus
 */
public interface AuditService {

    /**
     * Vytvoří a uloží nový auditní záznam do databáze.
     *
     * @param userId ID uživatele (null pro anonymní akce)
     * @param action typ provedené akce
     * @param status výsledek akce
     * @param ipAddress IP adresa klienta
     * @param userAgent user agent klienta
     */
    void log(
            Long userId,
            AuditAction action,
            AuditStatus status,
            String ipAddress,
            String userAgent
    );


    /**
     * Vyhledá auditní záznamy konkrétního uživatele.
     *
     * @param userId ID uživatele
     * @param pageable parametry stránkování a řazení
     * @return stránkovaný seznam auditních záznamů daného uživatele
     */
    Page<AuditLogEntity> findByUser(
            Long userId,
            Pageable pageable
    );


    /**
     * Vyhledá všechny auditní záznamy v systému.
     *
     * @param pageable parametry stránkování a řazení
     * @return stránkovaný seznam všech auditních záznamů
     */
    Page<AuditLogEntity> findAll(Pageable pageable);


    /**
     * Smaže auditní záznamy starší než limit definovaný retenční politikou.
     * Volá se automaticky podle plánu nebo manuálně pro údržbu databáze.
     *
     * @return počet smazaných záznamů
     */
    long cleanupOldLogs();

}