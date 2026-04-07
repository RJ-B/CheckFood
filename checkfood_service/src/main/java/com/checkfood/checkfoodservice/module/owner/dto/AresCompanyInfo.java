package com.checkfood.checkfoodservice.module.owner.dto;

import lombok.Builder;

import java.util.List;

/**
 * Informace o společnosti získané z registru ARES, včetně IČO, názvu firmy a statutárních zástupců.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Builder
public record AresCompanyInfo(
        String ico,
        String companyName,
        List<String> statutoryPersons
) {}
