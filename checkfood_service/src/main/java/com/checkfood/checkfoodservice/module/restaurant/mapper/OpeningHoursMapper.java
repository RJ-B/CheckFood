package com.checkfood.checkfoodservice.module.restaurant.mapper;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.OpeningHoursDto;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

/**
 * MapStruct mapper pro konverzi mezi entitou {@link OpeningHours} a DTO {@link OpeningHoursDto}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface OpeningHoursMapper {

    /**
     * Převede entitu provozní doby na DTO.
     *
     * @param openingHours entita provozní doby
     * @return DTO provozní doby
     */
    OpeningHoursDto toDto(OpeningHours openingHours);

    /**
     * Převede DTO provozní doby na entitu.
     *
     * @param openingHoursDto DTO provozní doby
     * @return entita provozní doby
     */
    OpeningHours toEntity(OpeningHoursDto openingHoursDto);
}