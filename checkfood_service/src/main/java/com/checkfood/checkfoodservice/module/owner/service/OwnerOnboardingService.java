package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.owner.dto.onboarding.OnboardingHoursRequest;
import com.checkfood.checkfoodservice.module.owner.dto.onboarding.OnboardingInfoRequest;
import com.checkfood.checkfoodservice.module.owner.dto.onboarding.OnboardingStatusResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantTableRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantTableResponse;

import java.util.List;
import java.util.UUID;

public interface OwnerOnboardingService {
    RestaurantResponse getMyRestaurant(String userEmail);
    RestaurantResponse updateInfo(String userEmail, OnboardingInfoRequest request);
    RestaurantResponse updateHours(String userEmail, OnboardingHoursRequest request);
    List<RestaurantTableResponse> getTables(String userEmail);
    RestaurantTableResponse addTable(String userEmail, RestaurantTableRequest request);
    RestaurantTableResponse updateTable(String userEmail, UUID tableId, RestaurantTableRequest request);
    void deleteTable(String userEmail, UUID tableId);
    OnboardingStatusResponse getOnboardingStatus(String userEmail);
    RestaurantResponse publish(String userEmail);
}
