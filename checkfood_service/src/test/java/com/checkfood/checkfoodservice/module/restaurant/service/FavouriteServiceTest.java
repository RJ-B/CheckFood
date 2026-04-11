package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.favourite.entity.UserFavouriteRestaurant;
import com.checkfood.checkfoodservice.module.restaurant.favourite.repository.UserFavouriteRestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.favourite.service.FavouriteServiceImpl;
import com.checkfood.checkfoodservice.module.restaurant.mapper.RestaurantMapper;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Set;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * Unit tests for FavouriteServiceImpl — pure Mockito.
 */
@ExtendWith(MockitoExtension.class)
class FavouriteServiceTest {

    @Mock
    private UserFavouriteRestaurantRepository favouriteRepository;

    @Mock
    private RestaurantRepository restaurantRepository;

    @Mock
    private RestaurantMapper restaurantMapper;

    @Mock
    private UserService userService;

    @InjectMocks
    private FavouriteServiceImpl favouriteService;

    // =========================================================================
    // addFavourite
    // =========================================================================

    @Nested
    @DisplayName("addFavourite")
    class AddFavourite {

        @Test
        @DisplayName("saves new favourite when restaurant exists and not already saved")
        void should_save_when_notAlreadyFavourite() {
            String email = "user@test.com";
            UUID restaurantId = UUID.randomUUID();
            UserEntity user = userWithId(1L);

            when(userService.findByEmail(email)).thenReturn(user);
            when(restaurantRepository.existsById(restaurantId)).thenReturn(true);
            when(favouriteRepository.existsByUserIdAndRestaurantId(1L, restaurantId)).thenReturn(false);

            favouriteService.addFavourite(email, restaurantId);

            ArgumentCaptor<UserFavouriteRestaurant> captor = ArgumentCaptor.forClass(UserFavouriteRestaurant.class);
            verify(favouriteRepository).save(captor.capture());
            assertThat(captor.getValue().getUserId()).isEqualTo(1L);
            assertThat(captor.getValue().getRestaurantId()).isEqualTo(restaurantId);
        }

        @Test
        @DisplayName("idempotent — does not save when already a favourite")
        void should_notSave_when_alreadyFavourite() {
            String email = "user@test.com";
            UUID restaurantId = UUID.randomUUID();
            UserEntity user = userWithId(1L);

            when(userService.findByEmail(email)).thenReturn(user);
            when(restaurantRepository.existsById(restaurantId)).thenReturn(true);
            when(favouriteRepository.existsByUserIdAndRestaurantId(1L, restaurantId)).thenReturn(true);

            favouriteService.addFavourite(email, restaurantId);

            verify(favouriteRepository, never()).save(any());
        }

        @Test
        @DisplayName("throws RestaurantException (404) when restaurant does not exist")
        void should_throw404_when_restaurantNotFound() {
            String email = "user@test.com";
            UUID restaurantId = UUID.randomUUID();

            when(userService.findByEmail(email)).thenReturn(userWithId(1L));
            when(restaurantRepository.existsById(restaurantId)).thenReturn(false);

            assertThatThrownBy(() -> favouriteService.addFavourite(email, restaurantId))
                    .isInstanceOf(RestaurantException.class);
        }
    }

    // =========================================================================
    // removeFavourite
    // =========================================================================

    @Test
    @DisplayName("removeFavourite — delegates to repository delete")
    void should_deleteByUserIdAndRestaurantId() {
        String email = "user@test.com";
        UUID restaurantId = UUID.randomUUID();
        UserEntity user = userWithId(2L);

        when(userService.findByEmail(email)).thenReturn(user);

        favouriteService.removeFavourite(email, restaurantId);

        verify(favouriteRepository).deleteByUserIdAndRestaurantId(2L, restaurantId);
    }

    // =========================================================================
    // getFavourites
    // =========================================================================

    @Nested
    @DisplayName("getFavourites")
    class GetFavourites {

        @Test
        @DisplayName("returns empty list when user has no favourites")
        void should_returnEmpty_when_noFavourites() {
            String email = "user@test.com";
            when(userService.findByEmail(email)).thenReturn(userWithId(3L));
            when(favouriteRepository.findAllByUserIdOrderByCreatedAtDesc(3L)).thenReturn(List.of());

            assertThat(favouriteService.getFavourites(email)).isEmpty();
            verify(restaurantRepository, never()).findAllById(any());
        }

        @Test
        @DisplayName("returns mapped restaurants when user has favourites")
        void should_returnMappedList_when_hasFavourites() {
            String email = "user@test.com";
            UUID restaurantId = UUID.randomUUID();
            UserFavouriteRestaurant fav = UserFavouriteRestaurant.builder()
                    .userId(4L)
                    .restaurantId(restaurantId)
                    .build();
            Restaurant restaurant = Restaurant.builder().id(restaurantId).build();
            RestaurantResponse response = new RestaurantResponse();

            when(userService.findByEmail(email)).thenReturn(userWithId(4L));
            when(favouriteRepository.findAllByUserIdOrderByCreatedAtDesc(4L)).thenReturn(List.of(fav));
            when(restaurantRepository.findAllById(List.of(restaurantId))).thenReturn(List.of(restaurant));
            when(restaurantMapper.toResponse(restaurant)).thenReturn(response);

            List<RestaurantResponse> result = favouriteService.getFavourites(email);

            assertThat(result).hasSize(1).containsExactly(response);
        }
    }

    // =========================================================================
    // isFavourite
    // =========================================================================

    @Test
    @DisplayName("isFavourite — returns true when exists")
    void should_returnTrue_when_isFavourite() {
        String email = "user@test.com";
        UUID restaurantId = UUID.randomUUID();
        when(userService.findByEmail(email)).thenReturn(userWithId(5L));
        when(favouriteRepository.existsByUserIdAndRestaurantId(5L, restaurantId)).thenReturn(true);

        assertThat(favouriteService.isFavourite(email, restaurantId)).isTrue();
    }

    @Test
    @DisplayName("isFavourite — returns false when does not exist")
    void should_returnFalse_when_notFavourite() {
        String email = "user@test.com";
        UUID restaurantId = UUID.randomUUID();
        when(userService.findByEmail(email)).thenReturn(userWithId(6L));
        when(favouriteRepository.existsByUserIdAndRestaurantId(6L, restaurantId)).thenReturn(false);

        assertThat(favouriteService.isFavourite(email, restaurantId)).isFalse();
    }

    // =========================================================================
    // getFavouriteIds
    // =========================================================================

    @Test
    @DisplayName("getFavouriteIds — returns set of UUIDs")
    void should_returnFavouriteIds() {
        UUID id1 = UUID.randomUUID();
        UUID id2 = UUID.randomUUID();
        UserFavouriteRestaurant f1 = UserFavouriteRestaurant.builder().userId(7L).restaurantId(id1).build();
        UserFavouriteRestaurant f2 = UserFavouriteRestaurant.builder().userId(7L).restaurantId(id2).build();

        when(favouriteRepository.findAllByUserId(7L)).thenReturn(List.of(f1, f2));

        Set<UUID> result = favouriteService.getFavouriteIds(7L);

        assertThat(result).containsExactlyInAnyOrder(id1, id2);
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private UserEntity userWithId(Long id) {
        UserEntity user = new UserEntity();
        user.setId(id);
        user.setEmail("user" + id + "@test.com");
        return user;
    }
}
