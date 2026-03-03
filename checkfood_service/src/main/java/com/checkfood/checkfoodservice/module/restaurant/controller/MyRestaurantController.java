package com.checkfood.checkfoodservice.module.restaurant.controller;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.AddEmployeeRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateEmployeeRoleRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateMyRestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.EmployeeResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.service.MyRestaurantService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/my-restaurant")
@RequiredArgsConstructor
@PreAuthorize("hasAnyRole('OWNER', 'MANAGER')")
public class MyRestaurantController {

    private final MyRestaurantService myRestaurantService;

    @GetMapping
    public ResponseEntity<RestaurantResponse> getMyRestaurant(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(myRestaurantService.getMyRestaurant(userDetails.getUsername()));
    }

    @PutMapping
    public ResponseEntity<RestaurantResponse> updateMyRestaurant(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody UpdateMyRestaurantRequest request) {
        return ResponseEntity.ok(myRestaurantService.updateMyRestaurant(userDetails.getUsername(), request));
    }

    @GetMapping("/employees")
    public ResponseEntity<List<EmployeeResponse>> getEmployees(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(myRestaurantService.getEmployees(userDetails.getUsername()));
    }

    @PostMapping("/employees")
    @PreAuthorize("hasRole('OWNER')")
    public ResponseEntity<EmployeeResponse> addEmployee(
            @AuthenticationPrincipal UserDetails userDetails,
            @Valid @RequestBody AddEmployeeRequest request) {
        return new ResponseEntity<>(
                myRestaurantService.addEmployee(userDetails.getUsername(), request),
                HttpStatus.CREATED
        );
    }

    @PutMapping("/employees/{id}")
    @PreAuthorize("hasRole('OWNER')")
    public ResponseEntity<EmployeeResponse> updateEmployeeRole(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable Long id,
            @Valid @RequestBody UpdateEmployeeRoleRequest request) {
        return ResponseEntity.ok(myRestaurantService.updateEmployeeRole(userDetails.getUsername(), id, request));
    }

    @DeleteMapping("/employees/{id}")
    @PreAuthorize("hasRole('OWNER')")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removeEmployee(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable Long id) {
        myRestaurantService.removeEmployee(userDetails.getUsername(), id);
    }
}
