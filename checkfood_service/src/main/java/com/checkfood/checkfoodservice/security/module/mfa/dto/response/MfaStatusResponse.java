package com.checkfood.checkfoodservice.security.module.mfa.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

/**
 * DTO odpovědi obsahující příznak aktivace MFA na uživatelském účtu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@AllArgsConstructor
public class MfaStatusResponse {

    private boolean enabled;

}
