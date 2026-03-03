package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.owner.dto.AresLookupResponse;
import com.checkfood.checkfoodservice.module.owner.dto.ClaimResultResponse;

public interface OwnerClaimService {
    AresLookupResponse lookupAres(String ico, Long userId);
    ClaimResultResponse verifyBankId(String ico, Long userId);
    ClaimResultResponse startEmailClaim(String ico, Long userId);
    ClaimResultResponse confirmEmailClaim(String ico, String code, Long userId);
}
