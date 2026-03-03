package com.checkfood.checkfoodservice.module.owner.dto;

import lombok.*;

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
