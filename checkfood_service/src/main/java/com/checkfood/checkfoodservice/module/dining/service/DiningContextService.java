package com.checkfood.checkfoodservice.module.dining.service;

import com.checkfood.checkfoodservice.module.dining.dto.response.DiningContextResponse;

import java.util.Optional;

public interface DiningContextService {

    DiningContextResponse getActiveDiningContext(Long userId);

    Optional<DiningContextResponse> findActiveDiningContext(Long userId);
}
