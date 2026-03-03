package com.checkfood.checkfoodservice.module.owner.dto;

import lombok.*;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AresLookupResponse {
    private String ico;
    private String companyName;
    private UUID restaurantId;
    private boolean requiresIdentityVerification;
    private List<String> statutoryPersons;
}
