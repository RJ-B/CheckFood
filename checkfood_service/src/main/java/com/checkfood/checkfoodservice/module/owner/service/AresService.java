package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.owner.dto.AresCompanyInfo;

public interface AresService {
    AresCompanyInfo lookupByIco(String ico);
}
