package com.checkfood.checkfoodservice.security.mfa.dto.request;

import jakarta.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;

/**
 * Request pro zahájení MFA challenge.
 */
@Getter
@Setter
public class MfaChallengeRequest {

    @NotNull(message = "User ID is required")
    private Long userId;

}
