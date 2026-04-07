package com.checkfood.checkfoodservice.module.restaurant.mapper;

import com.checkfood.checkfoodservice.module.restaurant.dto.response.EmployeeResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.util.List;

/**
 * MapStruct mapper pro konverzi entity {@link RestaurantEmployee} na response DTO.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Mapper(
        componentModel = "spring",
        unmappedTargetPolicy = ReportingPolicy.IGNORE
)
public interface RestaurantEmployeeMapper {

    /**
     * Převede entitu zaměstnance na response DTO včetně celého jména a efektivních oprávnění.
     *
     * @param employee entita zaměstnance
     * @return response DTO
     */
    @Mapping(target = "userId", source = "user.id")
    @Mapping(target = "name", expression = "java(buildFullName(employee))")
    @Mapping(target = "email", source = "user.email")
    @Mapping(target = "permissions", expression = "java(mapPermissions(employee))")
    EmployeeResponse toResponse(RestaurantEmployee employee);

    /**
     * Hromadný převod entit zaměstnanců na seznam response DTO.
     *
     * @param employees seznam entit zaměstnanců
     * @return seznam response DTO
     */
    List<EmployeeResponse> toResponseList(List<RestaurantEmployee> employees);

    /**
     * Sestaví celé jméno uživatele ve formátu "Jméno Příjmení".
     *
     * @param employee entita zaměstnance
     * @return celé jméno, nebo prázdný řetězec pokud není uživatel k dispozici
     */
    default String buildFullName(RestaurantEmployee employee) {
        var user = employee.getUser();
        if (user == null) return "";
        String first = user.getFirstName() != null ? user.getFirstName() : "";
        String last = user.getLastName() != null ? user.getLastName() : "";
        return (first + " " + last).trim();
    }

    /**
     * Převede efektivní oprávnění zaměstnance na sadu řetězců (názvů enum konstant).
     *
     * @param employee entita zaměstnance
     * @return sada názvů oprávnění
     */
    default java.util.Set<String> mapPermissions(RestaurantEmployee employee) {
        return employee.getEffectivePermissions().stream()
                .map(Enum::name)
                .collect(java.util.stream.Collectors.toSet());
    }
}
