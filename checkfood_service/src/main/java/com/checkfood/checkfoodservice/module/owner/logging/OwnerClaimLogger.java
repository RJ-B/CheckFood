package com.checkfood.checkfoodservice.module.owner.logging;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class OwnerClaimLogger {

    public void logAresLookup(String ico) {
        log.info("[OwnerClaim] ARES lookup for ICO: {}", ico);
    }

    public void logBankIdVerification(Long userId) {
        log.info("[OwnerClaim] BankID verification for userId: {}", userId);
    }

    public void logIdentityMatch(Long userId, String ico) {
        log.info("[OwnerClaim] Identity MATCHED: userId={}, ICO={}", userId, ico);
    }

    public void logIdentityMismatch(Long userId, String ico) {
        log.info("[OwnerClaim] Identity MISMATCH: userId={}, ICO={}", userId, ico);
    }

    public void logEmailCodeSent(String ico, Long userId) {
        log.info("[OwnerClaim] Email verification code sent: ICO={}, userId={}", ico, userId);
    }

    public void logEmailCodeVerified(String ico, Long userId) {
        log.info("[OwnerClaim] Email code verified: ICO={}, userId={}", ico, userId);
    }

    public void logMembershipCreated(Long userId, String restaurantId) {
        log.info("[OwnerClaim] Membership created: userId={}, restaurantId={}", userId, restaurantId);
    }
}
