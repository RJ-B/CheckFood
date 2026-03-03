package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.AddEmployeeRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateEmployeeRoleRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateMyRestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.EmployeeResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;

import java.util.List;

public interface MyRestaurantService {

    RestaurantResponse getMyRestaurant(String userEmail);

    RestaurantResponse updateMyRestaurant(String userEmail, UpdateMyRestaurantRequest request);

    List<EmployeeResponse> getEmployees(String userEmail);

    EmployeeResponse addEmployee(String userEmail, AddEmployeeRequest request);

    EmployeeResponse updateEmployeeRole(String userEmail, Long employeeId, UpdateEmployeeRoleRequest request);

    void removeEmployee(String userEmail, Long employeeId);
}
