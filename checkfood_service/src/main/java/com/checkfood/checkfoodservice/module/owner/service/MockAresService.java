package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.owner.dto.AresCompanyInfo;
import com.checkfood.checkfoodservice.module.owner.exception.OwnerClaimException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class MockAresService implements AresService {

    @Override
    public AresCompanyInfo lookupByIco(String ico) {
        log.info("[MockARES] Lookup ICO: {}", ico);

        if ("12345678".equals(ico)) {
            return AresCompanyInfo.builder()
                    .ico("12345678")
                    .companyName("Test Restaurant s.r.o.")
                    .statutoryPersons(List.of("Jan Novak"))
                    .build();
        }

        throw OwnerClaimException.companyNotFound();
    }
}
