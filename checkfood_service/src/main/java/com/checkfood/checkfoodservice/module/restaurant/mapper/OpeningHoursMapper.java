package com.checkfood.checkfoodservice.module.restaurant.mapper;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.OpeningHoursDto;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface OpeningHoursMapper {
    OpeningHoursDto toDto(OpeningHours openingHours);
    OpeningHours toEntity(OpeningHoursDto openingHoursDto);
}