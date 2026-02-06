package com.checkfood.checkfoodservice.security.refresh.dto;

import jakarta.validation.constraints.NotBlank;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Request pro obnovení access tokenu pomocí refresh tokenu.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RefreshRequest {

    // Refresh token (dlouhodobý)
    @NotBlank(message = "Refresh token is required")
    private String refreshToken;

}
