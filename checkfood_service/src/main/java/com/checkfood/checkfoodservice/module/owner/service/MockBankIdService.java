package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.owner.dto.BankIdIdentity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class MockBankIdService implements BankIdService {

    @Override
    public BankIdIdentity verifyIdentity(Long userId) {
        log.info("[MockBankID] Verifying identity for userId: {}", userId);
        return BankIdIdentity.builder()
                .firstName("Jan")
                .lastName("Novak")
                .build();
    }
}
