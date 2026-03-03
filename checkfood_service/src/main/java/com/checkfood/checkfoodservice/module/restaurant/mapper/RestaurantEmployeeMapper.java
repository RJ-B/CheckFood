package com.checkfood.checkfoodservice.module.restaurant.mapper;

import com.checkfood.checkfoodservice.module.restaurant.dto.response.EmployeeResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;

import java.util.List;

@Mapper(
        componentModel = "spring",
        unmappedTargetPolicy = ReportingPolicy.IGNORE
)
public interface RestaurantEmployeeMapper {

    @Mapping(target = "userId", source = "user.id")
    @Mapping(target = "name", expression = "java(buildFullName(employee))")
    @Mapping(target = "email", source = "user.email")
    EmployeeResponse toResponse(RestaurantEmployee employee);

    List<EmployeeResponse> toResponseList(List<RestaurantEmployee> employees);

    default String buildFullName(RestaurantEmployee employee) {
        var user = employee.getUser();
        if (user == null) return "";
        String first = user.getFirstName() != null ? user.getFirstName() : "";
        String last = user.getLastName() != null ? user.getLastName() : "";
        return (first + " " + last).trim();
    }
}
