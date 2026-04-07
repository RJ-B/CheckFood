package com.checkfood.checkfoodservice.module.owner.dto;

import lombok.*;

/**
 * Výsledek procesu přiřazení restaurace majiteli, informující o úspěchu, shodě identity a dostupnosti e-mailového fallbacku.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ClaimResultResponse {
    private boolean success;
    private boolean matched;
    private boolean membershipCreated;
    private boolean emailFallbackAvailable;
    private String emailHint;
}
