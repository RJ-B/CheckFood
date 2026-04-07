package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.menu.repository.MenuCategoryRepository;
import com.checkfood.checkfoodservice.module.owner.dto.onboarding.OnboardingHoursRequest;
import com.checkfood.checkfoodservice.module.owner.dto.onboarding.OnboardingInfoRequest;
import com.checkfood.checkfoodservice.module.owner.dto.onboarding.OnboardingStatusResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantTableRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantTableResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.OpeningHours;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.mapper.RestaurantMapper;
import com.checkfood.checkfoodservice.module.restaurant.mapper.RestaurantTableMapper;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.table.RestaurantTableRepository;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

/**
 * Implementace onboardingu majitele restaurace — spravuje informace, otevírací dobu, stoly a publikaci restaurace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
@Transactional
public class OwnerOnboardingServiceImpl implements OwnerOnboardingService {

    private final RestaurantRepository restaurantRepository;
    private final RestaurantEmployeeRepository employeeRepository;
    private final RestaurantTableRepository tableRepository;
    private final MenuCategoryRepository menuCategoryRepository;
    private final RestaurantMapper restaurantMapper;
    private final RestaurantTableMapper tableMapper;
    private final UserService userService;

    /**
     * {@inheritDoc}
     */
    @Override
    @Transactional(readOnly = true)
    public RestaurantResponse getMyRestaurant(String userEmail) {
        var membership = findOwnerMembership(userEmail);
        return restaurantMapper.toResponse(membership.getRestaurant());
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public RestaurantResponse updateInfo(String userEmail, OnboardingInfoRequest request) {
        var membership = findOwnerMembership(userEmail);
        var restaurant = membership.getRestaurant();

        restaurant.setName(request.getName());
        restaurant.setDescription(request.getDescription());
        restaurant.setPhone(request.getPhone());
        restaurant.setContactEmail(request.getEmail());
        if (request.getCuisineType() != null) {
            restaurant.setCuisineType(request.getCuisineType());
        }

        if (request.getAddress() != null) {
            var addr = restaurant.getAddress();
            if (addr == null) {
                addr = new Address();
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

        restaurant.setUpdatedAt(LocalDateTime.now());
        var saved = restaurantRepository.save(restaurant);
        return restaurantMapper.toResponse(saved);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public RestaurantResponse updateHours(String userEmail, OnboardingHoursRequest request) {
        var membership = findOwnerMembership(userEmail);
        var restaurant = membership.getRestaurant();

        restaurant.getOpeningHours().clear();
        request.getOpeningHours().forEach(oh -> {
            var openingHour = new OpeningHours();
            openingHour.setDayOfWeek(oh.getDayOfWeek());
            openingHour.setOpenAt(oh.getOpenAt());
            openingHour.setCloseAt(oh.getCloseAt());
            openingHour.setClosed(oh.isClosed());
            restaurant.getOpeningHours().add(openingHour);
        });

        restaurant.setUpdatedAt(LocalDateTime.now());
        var saved = restaurantRepository.save(restaurant);
        return restaurantMapper.toResponse(saved);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    @Transactional(readOnly = true)
    public List<RestaurantTableResponse> getTables(String userEmail) {
        var membership = findOwnerMembership(userEmail);
        var tables = tableRepository.findAllByRestaurantId(membership.getRestaurant().getId());
        return tables.stream().map(tableMapper::toResponse).toList();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public RestaurantTableResponse addTable(String userEmail, RestaurantTableRequest request) {
        var membership = findOwnerMembership(userEmail);
        var table = tableMapper.toEntity(request);
        table.setRestaurantId(membership.getRestaurant().getId());
        var saved = tableRepository.save(table);
        return tableMapper.toResponse(saved);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public RestaurantTableResponse updateTable(String userEmail, UUID tableId, RestaurantTableRequest request) {
        var membership = findOwnerMembership(userEmail);
        var table = tableRepository.findByIdAndRestaurantId(tableId, membership.getRestaurant().getId())
                .orElseThrow(() -> RestaurantException.tableNotFound(tableId));

        table.setLabel(request.getLabel());
        table.setCapacity(request.getCapacity());
        table.setActive(request.isActive());
        table.setYaw(request.getYaw());
        table.setPitch(request.getPitch());

        var saved = tableRepository.save(table);
        return tableMapper.toResponse(saved);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void deleteTable(String userEmail, UUID tableId) {
        var membership = findOwnerMembership(userEmail);
        var table = tableRepository.findByIdAndRestaurantId(tableId, membership.getRestaurant().getId())
                .orElseThrow(() -> RestaurantException.tableNotFound(tableId));
        tableRepository.delete(table);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    @Transactional(readOnly = true)
    public OnboardingStatusResponse getOnboardingStatus(String userEmail) {
        var membership = findOwnerMembership(userEmail);
        var restaurant = membership.getRestaurant();
        UUID restaurantId = restaurant.getId();

        boolean hasInfo = restaurant.getName() != null && !restaurant.getName().isBlank();
        boolean hasHours = restaurant.getOpeningHours() != null && !restaurant.getOpeningHours().isEmpty();
        boolean hasTables = !tableRepository.findAllByRestaurantId(restaurantId).isEmpty();
        boolean hasMenu = menuCategoryRepository.existsByRestaurantId(restaurantId);
        boolean hasPanorama = restaurant.getPanoramaUrl() != null && !restaurant.getPanoramaUrl().isBlank();

        return OnboardingStatusResponse.builder()
                .onboardingCompleted(restaurant.isOnboardingCompleted())
                .hasInfo(hasInfo)
                .hasHours(hasHours)
                .hasTables(hasTables)
                .hasMenu(hasMenu)
                .hasPanorama(hasPanorama)
                .build();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public RestaurantResponse publish(String userEmail) {
        var membership = findOwnerMembership(userEmail);
        var restaurant = membership.getRestaurant();

        if (restaurant.getName() == null || restaurant.getName().isBlank()) {
            throw RestaurantException.validationError("Název restaurace je povinný pro publikaci.");
        }
        if (restaurant.getOpeningHours() == null || restaurant.getOpeningHours().isEmpty()) {
            throw RestaurantException.validationError("Otevírací hodiny jsou povinné pro publikaci.");
        }
        if (tableRepository.findAllByRestaurantId(restaurant.getId()).isEmpty()) {
            throw RestaurantException.validationError("Alespoň jeden stůl je povinný pro publikaci.");
        }
        if (!menuCategoryRepository.existsByRestaurantId(restaurant.getId())) {
            throw RestaurantException.validationError("Menu musí obsahovat alespoň jednu kategorii pro publikaci.");
        }

        restaurant.setOnboardingCompleted(true);
        restaurant.setStatus(RestaurantStatus.ACTIVE);
        restaurant.setActive(true);
        restaurant.setUpdatedAt(LocalDateTime.now());

        var saved = restaurantRepository.save(restaurant);
        return restaurantMapper.toResponse(saved);
    }

    private RestaurantEmployee findOwnerMembership(String userEmail) {
        var user = userService.findByEmail(userEmail);
        var membership = employeeRepository.findFirstByUserIdAndRole(user.getId(), RestaurantEmployeeRole.OWNER)
                .orElseThrow(RestaurantException::noRestaurantAssigned);
        return membership;
    }
}
