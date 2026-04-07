package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.owner.dto.AresCompanyInfo;

/**
 * Rozhraní pro komunikaci s registrem ARES pro vyhledávání informací o firmách podle IČO.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface AresService {

    /**
     * Vyhledá informace o firmě v registru ARES podle zadaného IČO.
     *
     * @param ico identifikační číslo osoby (IČO) hledané firmy
     * @return informace o firmě z ARES včetně názvu a statutárních osob
     */
    AresCompanyInfo lookupByIco(String ico);
}
