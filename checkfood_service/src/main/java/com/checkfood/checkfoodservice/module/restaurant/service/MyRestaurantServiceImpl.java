package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.common.SpecialDayDto;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.AddEmployeeRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateEmployeePermissionsRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateEmployeeRoleRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.UpdateMyRestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.EmployeePermissionsResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.EmployeeResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.EmployeePermission;
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
import java.util.EnumSet;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Implementace {@link MyRestaurantService} pro správu restaurací, zaměstnanců a výjimečných dní.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
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
    public List<RestaurantResponse> getMyRestaurants(String userEmail) {
        var user = userService.findByEmail(userEmail);
        var memberships = employeeRepository.findAllByUserId(user.getId());
        return memberships.stream()
                .map(RestaurantEmployee::getRestaurant)
                .map(restaurantMapper::toResponse)
                .toList();
    }

    @Override
    @Transactional(readOnly = true)
    public RestaurantResponse getMyRestaurant(String userEmail, UUID restaurantId) {
        var membership = findMembership(userEmail, restaurantId);
        return restaurantMapper.toResponse(membership.getRestaurant());
    }

    @Override
    public RestaurantResponse updateMyRestaurant(String userEmail, UUID restaurantId, UpdateMyRestaurantRequest request) {
        var membership = findMembership(userEmail, restaurantId);
        requireRole(membership, RestaurantEmployeeRole.MANAGER, RestaurantEmployeeRole.OWNER);
        requirePermission(membership, EmployeePermission.EDIT_RESTAURANT_INFO);

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

        if (request.getDefaultReservationDurationMinutes() != null) {
            restaurant.setDefaultReservationDurationMinutes(request.getDefaultReservationDurationMinutes());
        }
        if (request.getMinAdvanceMinutes() != null) {
            restaurant.setMinAdvanceMinutes(request.getMinAdvanceMinutes());
        }
        if (request.getMinReservationDurationMinutes() != null) {
            restaurant.setMinReservationDurationMinutes(request.getMinReservationDurationMinutes());
        }
        if (request.getMaxReservationDurationMinutes() != null) {
            restaurant.setMaxReservationDurationMinutes(request.getMaxReservationDurationMinutes());
        }
        if (request.getReservationSlotIntervalMinutes() != null) {
            restaurant.setReservationSlotIntervalMinutes(request.getReservationSlotIntervalMinutes());
        }

        if (request.getSpecialDays() != null) {
            restaurant.getSpecialDays().clear();
            for (var dto : request.getSpecialDays()) {
                var sd = new com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.SpecialDay();
                sd.setDate(dto.getDate());
                sd.setClosed(dto.isClosed());
                sd.setOpenAt(dto.getOpenAt());
                sd.setCloseAt(dto.getCloseAt());
                sd.setNote(dto.getNote());
                restaurant.getSpecialDays().add(sd);
            }
        }

        restaurant.setUpdatedAt(LocalDateTime.now());
        var saved = restaurantRepository.save(restaurant);
        return restaurantMapper.toResponse(saved);
    }

    @Override
    @Transactional(readOnly = true)
    public List<EmployeeResponse> getEmployees(String userEmail, UUID restaurantId) {
        var membership = findMembership(userEmail, restaurantId);
        requireRole(membership, RestaurantEmployeeRole.MANAGER, RestaurantEmployeeRole.OWNER);
        requirePermission(membership, EmployeePermission.MANAGE_EMPLOYEES);

        var employees = employeeRepository.findAllByRestaurantId(membership.getRestaurant().getId())
                .stream()
                .filter(e -> e.getRole() != RestaurantEmployeeRole.OWNER)
                .toList();
        return employeeMapper.toResponseList(employees);
    }

    @Override
    public EmployeeResponse addEmployee(String userEmail, UUID restaurantId, AddEmployeeRequest request) {
        var membership = findMembership(userEmail, restaurantId);
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
                .permissions(EmployeePermission.defaultsForRole(request.getRole()))
                .build();

        var saved = employeeRepository.save(employee);
        userService.assignRole(targetUser.getId(), request.getRole().name());
        return employeeMapper.toResponse(saved);
    }

    @Override
    public EmployeeResponse updateEmployeeRole(String userEmail, UUID restaurantId, Long employeeId, UpdateEmployeeRoleRequest request) {
        var membership = findMembership(userEmail, restaurantId);
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

        var oldRole = employee.getRole();
        employee.setRole(request.getRole());
        employee.setPermissions(EmployeePermission.defaultsForRole(request.getRole()));
        var saved = employeeRepository.save(employee);
        userService.removeRole(employee.getUser().getId(), oldRole.name());
        userService.assignRole(employee.getUser().getId(), request.getRole().name());
        return employeeMapper.toResponse(saved);
    }

    @Override
    public void removeEmployee(String userEmail, UUID restaurantId, Long employeeId) {
        var membership = findMembership(userEmail, restaurantId);
        requireRole(membership, RestaurantEmployeeRole.OWNER);

        var employee = employeeRepository.findById(employeeId)
                .orElseThrow(() -> RestaurantException.employeeNotFound(employeeId));

        if (!employee.getRestaurant().getId().equals(membership.getRestaurant().getId())) {
            throw RestaurantException.accessDenied();
        }

        if (employee.getRole() == RestaurantEmployeeRole.OWNER) {
            throw RestaurantException.employeeValidationError("Nelze odebrat vlastníka restaurace.");
        }

        userService.removeRole(employee.getUser().getId(), employee.getRole().name());
        employeeRepository.delete(employee);
    }

    @Override
    @Transactional(readOnly = true)
    public EmployeePermissionsResponse getEmployeePermissions(String userEmail, UUID restaurantId, Long employeeId) {
        var membership = findMembership(userEmail, restaurantId);
        requireRole(membership, RestaurantEmployeeRole.OWNER);

        var employee = employeeRepository.findById(employeeId)
                .orElseThrow(() -> RestaurantException.employeeNotFound(employeeId));

        if (!employee.getRestaurant().getId().equals(membership.getRestaurant().getId())) {
            throw RestaurantException.accessDenied();
        }

        return EmployeePermissionsResponse.builder()
                .permissions(employee.getEffectivePermissions().stream()
                        .map(Enum::name).collect(Collectors.toSet()))
                .build();
    }

    @Override
    public EmployeePermissionsResponse updateEmployeePermissions(String userEmail, UUID restaurantId, Long employeeId, UpdateEmployeePermissionsRequest request) {
        var membership = findMembership(userEmail, restaurantId);
        requireRole(membership, RestaurantEmployeeRole.OWNER);

        var employee = employeeRepository.findById(employeeId)
                .orElseThrow(() -> RestaurantException.employeeNotFound(employeeId));

        if (!employee.getRestaurant().getId().equals(membership.getRestaurant().getId())) {
            throw RestaurantException.accessDenied();
        }

        if (employee.getRole() == RestaurantEmployeeRole.OWNER) {
            throw RestaurantException.employeeValidationError("Nelze měnit oprávnění vlastníka.");
        }

        var newPermissions = EnumSet.noneOf(EmployeePermission.class);
        for (String perm : request.getPermissions()) {
            try {
                newPermissions.add(EmployeePermission.valueOf(perm));
            } catch (IllegalArgumentException e) {
                throw RestaurantException.employeeValidationError("Neplatné oprávnění: " + perm);
            }
        }

        employee.setPermissions(newPermissions);
        employeeRepository.save(employee);

        return EmployeePermissionsResponse.builder()
                .permissions(newPermissions.stream()
                        .map(Enum::name).collect(Collectors.toSet()))
                .build();
    }

    /**
     * Najde členství přihlášeného uživatele v dané restauraci.
     * Pokud je restaurantId null, vrátí první nalezené členství.
     *
     * @param userEmail    e-mail přihlášeného uživatele
     * @param restaurantId UUID restaurace, nebo null
     * @return entita členství
     */
    private RestaurantEmployee findMembership(String userEmail, UUID restaurantId) {
        var user = userService.findByEmail(userEmail);
        if (restaurantId != null) {
            return employeeRepository.findByUserIdAndRestaurantId(user.getId(), restaurantId)
                    .orElseThrow(RestaurantException::noRestaurantAssigned);
        }
        return employeeRepository.findAllByUserId(user.getId())
                .stream()
                .findFirst()
                .orElseThrow(RestaurantException::noRestaurantAssigned);
    }

    /**
     * Ověří, zda má zaměstnanec jednu z povolených rolí. Vyvolá výjimku při neshodě.
     *
     * @param membership   entita členství zaměstnance
     * @param allowedRoles povolené role
     */
    private void requireRole(RestaurantEmployee membership, RestaurantEmployeeRole... allowedRoles) {
        for (var role : allowedRoles) {
            if (membership.getRole() == role) return;
        }
        throw RestaurantException.accessDenied();
    }


    @Override
    @Transactional(readOnly = true)
    public List<SpecialDayDto> getSpecialDays(String userEmail, UUID restaurantId) {
        var membership = findMembership(userEmail, restaurantId);
        var restaurant = membership.getRestaurant();
        return restaurant.getSpecialDays().stream()
                .map(sd -> SpecialDayDto.builder()
                        .date(sd.getDate())
                        .closed(sd.isClosed())
                        .openAt(sd.getOpenAt())
                        .closeAt(sd.getCloseAt())
                        .note(sd.getNote())
                        .build())
                .toList();
    }

    @Override
    @Transactional
    public List<SpecialDayDto> updateSpecialDays(String userEmail, UUID restaurantId, List<SpecialDayDto> specialDays) {
        var membership = findMembership(userEmail, restaurantId);
        requireRole(membership, RestaurantEmployeeRole.MANAGER, RestaurantEmployeeRole.OWNER);
        requirePermission(membership, EmployeePermission.EDIT_RESTAURANT_INFO);

        var restaurant = membership.getRestaurant();
        restaurant.getSpecialDays().clear();
        for (var dto : specialDays) {
            var sd = new com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.SpecialDay();
            sd.setDate(dto.getDate());
            sd.setClosed(dto.isClosed());
            sd.setOpenAt(dto.getOpenAt());
            sd.setCloseAt(dto.getCloseAt());
            sd.setNote(dto.getNote());
            restaurant.getSpecialDays().add(sd);
        }
        restaurantRepository.save(restaurant);
        return getSpecialDays(userEmail, restaurantId);
    }

    /**
     * Ověří, zda má zaměstnanec dané granulární oprávnění. Vyvolá výjimku při neshodě.
     *
     * @param membership entita členství zaměstnance
     * @param permission požadované oprávnění
     */
    private void requirePermission(RestaurantEmployee membership, EmployeePermission permission) {
        if (!membership.hasPermission(permission)) {
            throw RestaurantException.permissionDenied(permission.name());
        }
    }
}
