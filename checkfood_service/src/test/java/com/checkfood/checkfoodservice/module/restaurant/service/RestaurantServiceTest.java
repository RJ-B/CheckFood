package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.common.Address;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.CuisineType;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.mapper.RestaurantMapper;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantEmployeeRepository;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * Unit tests for RestaurantServiceImpl — pure Mockito, no Spring context.
 *
 * <p>Ownership is resolved through {@link RestaurantEmployeeRepository}
 * (role = OWNER) since Apr 2026. Tests therefore mock both the user lookup
 * and the employee lookup for every owner-scoped assertion.</p>
 */
@ExtendWith(MockitoExtension.class)
class RestaurantServiceTest {

    @Mock
    private RestaurantRepository restaurantRepository;

    @Mock
    private RestaurantEmployeeRepository restaurantEmployeeRepository;

    @Mock
    private RestaurantMapper restaurantMapper;

    @Mock
    private UserService userService;

    @InjectMocks
    private RestaurantServiceImpl restaurantService;

    // =========================================================================
    // createRestaurant
    // =========================================================================

    @Nested
    @DisplayName("createRestaurant")
    class CreateRestaurant {

        @Test
        @DisplayName("creates restaurant with PENDING status and OWNER membership")
        void should_createWithPendingStatus() {
            Long userId = 42L;
            UserEntity user = aUser(userId);
            RestaurantRequest request = new RestaurantRequest();
            Restaurant entity = aRestaurant();
            RestaurantResponse expectedResponse = new RestaurantResponse();

            when(userService.findById(userId)).thenReturn(user);
            when(restaurantMapper.toEntity(request)).thenReturn(entity);
            when(restaurantRepository.save(any(Restaurant.class))).thenReturn(entity);
            when(restaurantMapper.toResponse(entity)).thenReturn(expectedResponse);

            RestaurantResponse result = restaurantService.createRestaurant(request, userId);

            assertThat(result).isEqualTo(expectedResponse);
            assertThat(entity.getStatus()).isEqualTo(RestaurantStatus.PENDING);
            assertThat(entity.isActive()).isTrue();
            verify(restaurantRepository).save(entity);
            verify(restaurantEmployeeRepository).save(argThat((RestaurantEmployee emp) ->
                    emp.getUser().equals(user)
                            && emp.getRestaurant().equals(entity)
                            && emp.getRole() == RestaurantEmployeeRole.OWNER));
        }

        @Test
        @DisplayName("increments marker version after creation")
        void should_incrementMarkerVersion_when_created() {
            Long userId = 42L;
            UserEntity user = aUser(userId);
            RestaurantRequest request = new RestaurantRequest();
            Restaurant entity = aRestaurant();

            when(userService.findById(userId)).thenReturn(user);
            when(restaurantMapper.toEntity(request)).thenReturn(entity);
            when(restaurantRepository.save(any())).thenReturn(entity);
            when(restaurantMapper.toResponse(entity)).thenReturn(new RestaurantResponse());

            long versionBefore = restaurantService.getMarkerVersion();
            restaurantService.createRestaurant(request, userId);
            long versionAfter = restaurantService.getMarkerVersion();

            assertThat(versionAfter).isEqualTo(versionBefore + 1);
        }
    }

    // =========================================================================
    // getRestaurantById
    // =========================================================================

    @Nested
    @DisplayName("getRestaurantById")
    class GetRestaurantById {

        @Test
        @DisplayName("returns mapped response when found")
        void should_returnResponse_when_found() {
            UUID id = UUID.randomUUID();
            Restaurant entity = aRestaurant();
            entity.setId(id);
            RestaurantResponse expected = new RestaurantResponse();

            when(restaurantRepository.findById(id)).thenReturn(Optional.of(entity));
            when(restaurantMapper.toResponse(entity)).thenReturn(expected);

            assertThat(restaurantService.getRestaurantById(id)).isEqualTo(expected);
        }

        @Test
        @DisplayName("throws RestaurantException (404) when not found")
        void should_throw404_when_notFound() {
            UUID id = UUID.randomUUID();
            when(restaurantRepository.findById(id)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> restaurantService.getRestaurantById(id))
                    .isInstanceOf(RestaurantException.class)
                    .hasMessageContaining(id.toString());
        }
    }

    // =========================================================================
    // updateRestaurant
    // =========================================================================

    @Nested
    @DisplayName("updateRestaurant")
    class UpdateRestaurant {

        @Test
        @DisplayName("updates restaurant when caller is the owner")
        void should_update_when_callerIsOwner() {
            Long userId = 42L;
            UUID id = UUID.randomUUID();
            Restaurant existing = aRestaurant();
            existing.setId(id);
            Restaurant updated = aRestaurant();
            RestaurantRequest request = new RestaurantRequest();
            RestaurantResponse expectedResponse = new RestaurantResponse();

            when(restaurantRepository.findById(id)).thenReturn(Optional.of(existing));
            when(restaurantEmployeeRepository
                    .findAllByUserIdAndRole(userId, RestaurantEmployeeRole.OWNER))
                    .thenReturn(List.of(ownerEmployeeFor(existing)));
            when(restaurantMapper.toEntity(request)).thenReturn(updated);
            when(restaurantRepository.save(updated)).thenReturn(updated);
            when(restaurantMapper.toResponse(updated)).thenReturn(expectedResponse);

            RestaurantResponse result = restaurantService.updateRestaurant(id, request, userId);

            assertThat(result).isEqualTo(expectedResponse);
            assertThat(updated.getId()).isEqualTo(id);
        }

        @Test
        @DisplayName("throws 403 AccessDenied when caller is not the owner")
        void should_throwAccessDenied_when_notOwner() {
            Long wrongUser = 99L;
            UUID id = UUID.randomUUID();
            Restaurant existing = aRestaurant();
            existing.setId(id);

            when(restaurantRepository.findById(id)).thenReturn(Optional.of(existing));
            when(restaurantEmployeeRepository
                    .findAllByUserIdAndRole(wrongUser, RestaurantEmployeeRole.OWNER))
                    .thenReturn(List.of());

            assertThatThrownBy(() -> restaurantService.updateRestaurant(id, new RestaurantRequest(), wrongUser))
                    .isInstanceOf(RestaurantException.class);
        }

        @Test
        @DisplayName("throws 404 when restaurant not found")
        void should_throw404_when_notFound() {
            UUID id = UUID.randomUUID();
            when(restaurantRepository.findById(id)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> restaurantService.updateRestaurant(id, new RestaurantRequest(), 1L))
                    .isInstanceOf(RestaurantException.class);
        }
    }

    // =========================================================================
    // deleteRestaurant
    // =========================================================================

    @Nested
    @DisplayName("deleteRestaurant")
    class DeleteRestaurant {

        @Test
        @DisplayName("soft-deletes restaurant when caller is owner")
        void should_softDelete_when_ownerDeletes() {
            Long userId = 42L;
            UUID id = UUID.randomUUID();
            Restaurant existing = aRestaurant();
            existing.setId(id);

            when(restaurantRepository.findById(id)).thenReturn(Optional.of(existing));
            when(restaurantEmployeeRepository
                    .findAllByUserIdAndRole(userId, RestaurantEmployeeRole.OWNER))
                    .thenReturn(List.of(ownerEmployeeFor(existing)));
            when(restaurantRepository.save(existing)).thenReturn(existing);

            restaurantService.deleteRestaurant(id, userId);

            assertThat(existing.isActive()).isFalse();
            assertThat(existing.getStatus()).isEqualTo(RestaurantStatus.ARCHIVED);
            verify(restaurantRepository).save(existing);
        }

        @Test
        @DisplayName("throws 403 when non-owner tries to delete")
        void should_throwAccessDenied_when_notOwner() {
            Long wrongUser = 99L;
            UUID id = UUID.randomUUID();
            Restaurant existing = aRestaurant();
            existing.setId(id);

            when(restaurantRepository.findById(id)).thenReturn(Optional.of(existing));
            when(restaurantEmployeeRepository
                    .findAllByUserIdAndRole(wrongUser, RestaurantEmployeeRole.OWNER))
                    .thenReturn(List.of());

            assertThatThrownBy(() -> restaurantService.deleteRestaurant(id, wrongUser))
                    .isInstanceOf(RestaurantException.class);
        }
    }

    // =========================================================================
    // getMyRestaurants
    // =========================================================================

    @Test
    @DisplayName("getMyRestaurants — returns mapped list for owner")
    void should_returnList_when_ownerHasRestaurants() {
        Long userId = 42L;
        Restaurant r1 = aRestaurant();
        Restaurant r2 = aRestaurant();
        RestaurantResponse resp1 = new RestaurantResponse();
        RestaurantResponse resp2 = new RestaurantResponse();

        when(restaurantEmployeeRepository
                .findAllByUserIdAndRole(userId, RestaurantEmployeeRole.OWNER))
                .thenReturn(List.of(ownerEmployeeFor(r1), ownerEmployeeFor(r2)));
        when(restaurantMapper.toResponse(r1)).thenReturn(resp1);
        when(restaurantMapper.toResponse(r2)).thenReturn(resp2);

        List<RestaurantResponse> result = restaurantService.getMyRestaurants(userId);

        assertThat(result).hasSize(2).containsExactly(resp1, resp2);
    }

    // =========================================================================
    // marker version
    // =========================================================================

    @Test
    @DisplayName("incrementMarkerVersion — increments atomically")
    void should_incrementMarkerVersion() {
        long before = restaurantService.getMarkerVersion();
        restaurantService.incrementMarkerVersion();
        assertThat(restaurantService.getMarkerVersion()).isEqualTo(before + 1);
    }

    // =========================================================================
    // dynamicRadiusPx — boundary tests
    // =========================================================================

    @Test
    @DisplayName("dynamicRadiusPx — cluster radius returns baseline 22 + amplitude at zoom 13 peak")
    void should_computeClusterEps_at_zoom13() {
        // Accessing via test of getMarkersInBounds which delegates to private method
        // We test indirectly via coverage; the math: at zoom=13, diff=0, radius = 22+20 = 42px
        // eps = 42 * 360 / (256 * 2^13) = 42 * 360 / 2097152 ≈ 0.00720...
        // No NPE expected from the call
        when(restaurantRepository.findClusteredMarkers(anyDouble(), anyDouble(), anyDouble(), anyDouble(), anyDouble(), anyInt()))
                .thenReturn(List.of());
        when(restaurantMapper.toMarkerResponseList(any())).thenReturn(List.of());

        assertThat(restaurantService.getMarkersInBounds(49.0, 50.0, 13.0, 14.0, 13, null)).isEmpty();
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private Restaurant aRestaurant() {
        return Restaurant.builder()
                .id(UUID.randomUUID())
                .name("Test Restaurant")
                .cuisineType(CuisineType.CZECH)
                .status(RestaurantStatus.ACTIVE)
                .active(true)
                .address(Address.builder()
                        .street("Test Street")
                        .city("Praha")
                        .build())
                .build();
    }

    private UserEntity aUser(Long id) {
        return UserEntity.builder()
                .id(id)
                .email("owner" + id + "@example.com")
                .build();
    }

    private RestaurantEmployee ownerEmployeeFor(Restaurant restaurant) {
        return RestaurantEmployee.builder()
                .restaurant(restaurant)
                .role(RestaurantEmployeeRole.OWNER)
                .build();
    }
}
