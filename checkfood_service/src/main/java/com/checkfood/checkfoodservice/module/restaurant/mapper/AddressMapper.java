package com.checkfood.checkfoodservice.module.restaurant.mapper;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.AddressDto;
import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import org.mapstruct.*;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AddressMapper {

    // Entity -> DTO
    // Funguje automaticky, protože Address má getLatitude() a getLongitude()
    AddressDto toDto(Address address);

    // DTO -> Entity
    // MapStruct neví, jak nacpat lat/lng do "Point location", musíme mu pomoct
    @Mapping(target = "location", ignore = true) // Ignorujeme přímé mapování, vyřešíme v @AfterMapping
    Address toEntity(AddressDto addressDto);

    /**
     * Tato metoda se zavolá automaticky po vytvoření entity.
     * Vezme lat/lng z DTO a pomocí tvé metody setCoordinates vytvoří PostGIS Point.
     */
    @AfterMapping
    default void mapCoordinates(AddressDto dto, @MappingTarget Address entity) {
        if (dto.getLatitude() != null && dto.getLongitude() != null) {
            entity.setCoordinates(dto.getLatitude(), dto.getLongitude());
        }
    }
}