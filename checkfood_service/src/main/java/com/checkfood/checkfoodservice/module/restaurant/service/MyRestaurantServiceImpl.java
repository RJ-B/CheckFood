package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.AddEmployeeRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateEmployeeRoleRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateMyRestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.EmployeeResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.mapper.RestaurantEmployeeMapper;
import com.checkfood.checkfoodservice.module.restaurant.mapper.RestaurantMapper;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class MyRestaurantServiceImpl implements MyRestaurantService {

    private final RestaurantRepository restaurantRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final RestaurantMapper restaurantMapper;
    private final RestaurantEmployeeMapper employeeMapper;
    private final UserService userService;

    @Override
    @Transactional(readOnly = true)
    public RestaurantResponse getMyRestaurant(String userEmail) {
        var membership = findMembership(userEmail);
        return restaurantMapper.toResponse(membership.getRestaurant());
    }

    @Override
    public RestaurantResponse updateMyRestaurant(String userEmail, UpdateMyRestaurantRequest request) {
        var membership = findMembership(userEmail);
        requireRole(membership, RestaurantEmployeeRole.MANAGER, RestaurantEmployeeRole.OWNER);

        var restaurant = membership.getRestaurant();
        restaurant.setName(request.getName());
        restaurant.setDescription(request.getDescription());
        restaurant.setPhone(request.getPhone());
        restaurant.setContactEmail(request.getEmail());

        if (request.getAddress() != null) {
            var addr = restaurant.getAddress();
            if (addr == null) {
                addr = new com.checkfood.checkfoodservice.module.restaurant.entity.common.Address();
                restaurant.setAddress(addr);
            }
            addr.setStreet(request.getAddress().getStreet());
            addr.setStreetNumber(request.getAddress().getStreetNumber());
            addr.setCity(request.getAddress().getCity());
            addr.setPostalCode(request.getAddress().getPostalCode());
            addr.setCountry(request.getAddress().getCountry());
            if (request.getAddress().getLatitude() != null && request.getAddress().getLongitude() != null) {
                addr.setCoordinates(request.getAddress().getLatitude(), request.getAddress().getLongitude());
            }
        }

        if (request.getOpeningHours() != null) {
            restaurant.getOpeningHours().clear();
            request.getOpeningHours().forEach(oh -> {
                var openingHour = new com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours();
                openingHour.setDayOfWeek(oh.getDayOfWeek());
                openingHour.setOpenAt(oh.getOpenAt());
                openingHour.setCloseAt(oh.getCloseAt());
                openingHour.setClosed(oh.isClosed());
                restaurant.getOpeningHours().add(openingHour);
            });
        }

        restaurant.setUpdatedAt(LocalDateTime.now());
        var saved = restaurantRepository.save(restaurant);
        return restaurantMapper.toResponse(saved);
    }

    @Override
    @Transactional(readOnly = true)
    public List<EmployeeResponse> getEmployees(String userEmail) {
        var membership = findMembership(userEmail);
        requireRole(membership, RestaurantEmployeeRole.MANAGER, RestaurantEmployeeRole.OWNER);

        var employees = employeeRepository.findAllByRestaurantId(membership.getRestaurant().getId());
        return employeeMapper.toResponseList(employees);
    }

    @Override
    public EmployeeResponse addEmployee(String userEmail, AddEmployeeRequest request) {
        var membership = findMembership(userEmail);
        requireRole(membership, RestaurantEmployeeRole.OWNER);

        if (request.getRole() == RestaurantEmployeeRole.OWNER) {
            throw RestaurantException.employeeValidationError("Nelze přidat dalšího vlastníka.");
        }

        var targetUser = userService.findByEmail(request.getEmail());

        if (employeeRepository.existsByUserIdAndRestaurantId(targetUser.getId(), membership.getRestaurant().getId())) {
            throw RestaurantException.employeeAlreadyExists(request.getEmail());
        }

        var employee = RestaurantEmployee.builder()
                .user(targetUser)
                .restaurant(membership.getRestaurant())
                .role(request.getRole())
                .build();

        var saved = employeeRepository.save(employee);
        return employeeMapper.toResponse(saved);
    }

    @Override
    public EmployeeResponse updateEmployeeRole(String userEmail, Long employeeId, UpdateEmployeeRoleRequest request) {
        var membership = findMembership(userEmail);
        requireRole(membership, RestaurantEmployeeRole.OWNER);

        if (request.getRole() == RestaurantEmployeeRole.OWNER) {
            throw RestaurantException.employeeValidationError("Nelze přiřadit roli vlastníka.");
        }

        var employee = employeeRepository.findById(employeeId)
                .orElseThrow(() -> RestaurantException.employeeNotFound(employeeId));

        if (!employee.getRestaurant().getId().equals(membership.getRestaurant().getId())) {
            throw RestaurantException.accessDenied();
        }

        if (employee.getRole() == RestaurantEmployeeRole.OWNER) {
            throw RestaurantException.employeeValidationError("Nelze změnit roli vlastníka.");
        }

        employee.setRole(request.getRole());
        var saved = employeeRepository.save(employee);
        return employeeMapper.toResponse(saved);
    }

    @Override
    public void removeEmployee(String userEmail, Long employeeId) {
        var membership = findMembership(userEmail);
        requireRole(membership, RestaurantEmployeeRole.OWNER);

        var employee = employeeRepository.findById(employeeId)
                .orElseThrow(() -> RestaurantException.employeeNotFound(employeeId));

        if (!employee.getRestaurant().getId().equals(membership.getRestaurant().getId())) {
            throw RestaurantException.accessDenied();
        }

        if (employee.getRole() == RestaurantEmployeeRole.OWNER) {
            throw RestaurantException.employeeValidationError("Nelze odebrat vlastníka restaurace.");
        }

        employeeRepository.delete(employee);
    }

    // --- Private Helpers ---

    private RestaurantEmployee findMembership(String userEmail) {
        var user = userService.findByEmail(userEmail);
        return employeeRepository.findByUserId(user.getId())
                .orElseThrow(RestaurantException::noRestaurantAssigned);
    }

    private void requireRole(RestaurantEmployee membership, RestaurantEmployeeRole... allowedRoles) {
        for (var role : allowedRoles) {
            if (membership.getRole() == role) return;
        }
        throw RestaurantException.accessDenied();
    }
}
