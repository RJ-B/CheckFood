package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.owner.dto.BankIdIdentity;

public interface BankIdService {
    BankIdIdentity verifyIdentity(Long userId);
}
