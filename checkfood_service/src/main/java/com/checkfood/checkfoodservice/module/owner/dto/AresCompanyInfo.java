package com.checkfood.checkfoodservice.module.owner.dto;

import lombok.Builder;

import java.util.List;

@Builder
public record AresCompanyInfo(
        String ico,
        String companyName,
        List<String> statutoryPersons
) {}
