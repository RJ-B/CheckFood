package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.AddressDto;
import com.checkfood.checkfoodservice.module.restaurant.dto.common.OpeningHoursDto;
import com.checkfood.checkfoodservice.module.restaurant.dto.common.SpecialDayDto;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import lombok.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * Detailní odpověď s informacemi o restauraci.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RestaurantResponse {
    private UUID id;
    private UUID ownerId;
    private String name;
    private String description;
    private CuisineType cuisineType;
    private String logoUrl;
    private String coverImageUrl;
    private String panoramaUrl;
    private List<RestaurantPhotoResponse> gallery;
    private RestaurantStatus status;
    private boolean active;
    private BigDecimal rating;
    private AddressDto address;
    private List<OpeningHoursDto> openingHours;
    private Set<String> tags;
    private boolean onboardingCompleted;
    private int defaultReservationDurationMinutes;
    private int minAdvanceMinutes;
    private int minReservationDurationMinutes;
    private int maxReservationDurationMinutes;
    private int reservationSlotIntervalMinutes;
    private List<SpecialDayDto> specialDays;
    private Boolean isFavourite;
}