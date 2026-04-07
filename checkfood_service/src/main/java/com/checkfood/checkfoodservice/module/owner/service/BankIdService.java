package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.owner.dto.BankIdIdentity;

/**
 * Rozhraní pro ověření identity uživatele prostřednictvím služby BankID.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface BankIdService {

    /**
     * Ověří identitu uživatele přes BankID a vrátí jeho jméno a příjmení.
     *
     * @param userId identifikátor uživatele, jehož identita má být ověřena
     * @return ověřená identita uživatele z BankID
     */
    BankIdIdentity verifyIdentity(Long userId);
}
