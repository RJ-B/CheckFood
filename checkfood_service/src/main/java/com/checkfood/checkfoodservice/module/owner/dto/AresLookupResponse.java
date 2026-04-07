package com.checkfood.checkfoodservice.module.owner.dto;

import lombok.*;

import java.util.List;
import java.util.UUID;

/**
 * Odpověď na vyhledání firmy v ARES obsahující základní údaje o firmě, přidruženou restauraci a seznam statutárních osob.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
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
