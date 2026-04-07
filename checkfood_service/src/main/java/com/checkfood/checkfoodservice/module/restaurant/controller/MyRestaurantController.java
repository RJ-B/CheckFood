package com.checkfood.checkfoodservice.module.restaurant.controller;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.SpecialDayDto;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.AddEmployeeRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateEmployeePermissionsRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateEmployeeRoleRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateMyRestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.EmployeePermissionsResponse;
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
import java.util.UUID;

/**
 * REST controller pro správu vlastních restaurací, zaměstnanců a výjimečných dní.
 * Přístup vyžaduje roli OWNER, MANAGER nebo STAFF.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/my-restaurant")
@RequiredArgsConstructor
@PreAuthorize("hasAnyRole('OWNER', 'MANAGER', 'STAFF')")
public class MyRestaurantController {

    private final MyRestaurantService myRestaurantService;

    @GetMapping("/list")
    @PreAuthorize("hasAnyRole('OWNER', 'MANAGER', 'STAFF')")
    public ResponseEntity<List<RestaurantResponse>> getMyRestaurants(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(myRestaurantService.getMyRestaurants(userDetails.getUsername()));
    }

    @GetMapping
    public ResponseEntity<RestaurantResponse> getMyRestaurant(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(required = false) UUID restaurantId) {
        return ResponseEntity.ok(myRestaurantService.getMyRestaurant(userDetails.getUsername(), restaurantId));
    }

    @PutMapping
    public ResponseEntity<RestaurantResponse> updateMyRestaurant(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(required = false) UUID restaurantId,
            @Valid @RequestBody UpdateMyRestaurantRequest request) {
        return ResponseEntity.ok(myRestaurantService.updateMyRestaurant(userDetails.getUsername(), restaurantId, request));
    }

    @GetMapping("/employees")
    public ResponseEntity<List<EmployeeResponse>> getEmployees(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(required = false) UUID restaurantId) {
        return ResponseEntity.ok(myRestaurantService.getEmployees(userDetails.getUsername(), restaurantId));
    }

    @PostMapping("/employees")
    @PreAuthorize("hasRole('OWNER')")
    public ResponseEntity<EmployeeResponse> addEmployee(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(required = false) UUID restaurantId,
            @Valid @RequestBody AddEmployeeRequest request) {
        return new ResponseEntity<>(
                myRestaurantService.addEmployee(userDetails.getUsername(), restaurantId, request),
                HttpStatus.CREATED
        );
    }

    @PutMapping("/employees/{id}")
    @PreAuthorize("hasRole('OWNER')")
    public ResponseEntity<EmployeeResponse> updateEmployeeRole(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(required = false) UUID restaurantId,
            @PathVariable Long id,
            @Valid @RequestBody UpdateEmployeeRoleRequest request) {
        return ResponseEntity.ok(myRestaurantService.updateEmployeeRole(userDetails.getUsername(), restaurantId, id, request));
    }

    @GetMapping("/employees/{id}/permissions")
    @PreAuthorize("hasRole('OWNER')")
    public ResponseEntity<EmployeePermissionsResponse> getEmployeePermissions(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(required = false) UUID restaurantId,
            @PathVariable Long id) {
        return ResponseEntity.ok(myRestaurantService.getEmployeePermissions(userDetails.getUsername(), restaurantId, id));
    }

    @PutMapping("/employees/{id}/permissions")
    @PreAuthorize("hasRole('OWNER')")
    public ResponseEntity<EmployeePermissionsResponse> updateEmployeePermissions(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(required = false) UUID restaurantId,
            @PathVariable Long id,
            @Valid @RequestBody UpdateEmployeePermissionsRequest request) {
        return ResponseEntity.ok(myRestaurantService.updateEmployeePermissions(userDetails.getUsername(), restaurantId, id, request));
    }

    @DeleteMapping("/employees/{id}")
    @PreAuthorize("hasRole('OWNER')")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removeEmployee(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(required = false) UUID restaurantId,
            @PathVariable Long id) {
        myRestaurantService.removeEmployee(userDetails.getUsername(), restaurantId, id);
    }

    @GetMapping("/special-days")
    public ResponseEntity<List<SpecialDayDto>> getSpecialDays(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(required = false) UUID restaurantId) {
        return ResponseEntity.ok(myRestaurantService.getSpecialDays(userDetails.getUsername(), restaurantId));
    }

    @PutMapping("/special-days")
    public ResponseEntity<List<SpecialDayDto>> updateSpecialDays(
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam(required = false) UUID restaurantId,
            @Valid @RequestBody List<SpecialDayDto> specialDays) {
        return ResponseEntity.ok(myRestaurantService.updateSpecialDays(userDetails.getUsername(), restaurantId, specialDays));
    }
}
