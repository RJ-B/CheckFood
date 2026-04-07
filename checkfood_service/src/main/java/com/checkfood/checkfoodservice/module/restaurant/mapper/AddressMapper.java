package com.checkfood.checkfoodservice.module.restaurant.mapper;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.AddressDto;
import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import org.mapstruct.*;

/**
 * MapStruct mapper pro konverzi mezi entitou {@link Address} a DTO {@link AddressDto}.
 * Po vytvoření entity automaticky nastaví PostGIS Point ze souřadnic v DTO.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AddressMapper {

    /**
     * Převede entitu adresy na DTO. Latitude a longitude jsou extrahovány z PostGIS Point.
     *
     * @param address entita adresy
     * @return DTO adresy
     */
    AddressDto toDto(Address address);

    /**
     * Převede DTO adresy na entitu. Pole {@code location} je ignorováno — nastavuje se v {@link #mapCoordinates}.
     *
     * @param addressDto DTO adresy
     * @return entita adresy bez PostGIS Point
     */
    @Mapping(target = "location", ignore = true)
    Address toEntity(AddressDto addressDto);

    /**
     * After-mapping hook: vytvoří PostGIS Point ze souřadnic v DTO a nastaví ho na entitě.
     *
     * @param dto    zdrojové DTO s latitude a longitude
     * @param entity cílová entita, na které bude nastaven PostGIS Point
     */
    @AfterMapping
    default void mapCoordinates(AddressDto dto, @MappingTarget Address entity) {
        if (dto.getLatitude() != null && dto.getLongitude() != null) {
            entity.setCoordinates(dto.getLatitude(), dto.getLongitude());
        }
    }
}