package com.checkfood.checkfoodservice.security.module.mfa.dto.request;

import jakarta.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;

/**
 * DTO pro zahájení MFA přihlašovací výzvy identifikující cílového uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
public class MfaChallengeRequest {

    @NotNull(message = "User ID is required")
    private Long userId;

}
