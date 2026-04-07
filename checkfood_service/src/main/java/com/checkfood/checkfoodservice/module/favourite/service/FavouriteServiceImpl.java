package com.checkfood.checkfoodservice.module.favourite.service;

import com.checkfood.checkfoodservice.module.favourite.entity.UserFavouriteRestaurant;
import com.checkfood.checkfoodservice.module.favourite.repository.UserFavouriteRestaurantRepository;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.module.restaurant.exception.RestaurantException;
import com.checkfood.checkfoodservice.module.restaurant.mapper.RestaurantMapper;
import com.checkfood.checkfoodservice.module.restaurant.repository.RestaurantRepository;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Implementace {@link FavouriteService} spravující oblíbené restaurace uživatele
 * s idempotentním přidáváním a zachováním pořadí dle data přidání.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
@Transactional
public class FavouriteServiceImpl implements FavouriteService {

    private final UserFavouriteRestaurantRepository favouriteRepository;
    private final RestaurantRepository restaurantRepository;
    private final RestaurantMapper restaurantMapper;
    private final UserService userService;

    @Override
    public void addFavourite(String userEmail, UUID restaurantId) {
        UserEntity user = userService.findByEmail(userEmail);

        if (!restaurantRepository.existsById(restaurantId)) {
            throw RestaurantException.notFound(restaurantId);
        }

        if (favouriteRepository.existsByUserIdAndRestaurantId(user.getId(), restaurantId)) {
            return;
        }

        UserFavouriteRestaurant favourite = UserFavouriteRestaurant.builder()
                .userId(user.getId())
                .restaurantId(restaurantId)
                .build();
        favouriteRepository.save(favourite);
    }

    @Override
    public void removeFavourite(String userEmail, UUID restaurantId) {
        UserEntity user = userService.findByEmail(userEmail);
        favouriteRepository.deleteByUserIdAndRestaurantId(user.getId(), restaurantId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<RestaurantResponse> getFavourites(String userEmail) {
        UserEntity user = userService.findByEmail(userEmail);
        List<UserFavouriteRestaurant> favourites = favouriteRepository.findAllByUserIdOrderByCreatedAtDesc(user.getId());

        List<UUID> restaurantIds = favourites.stream()
                .map(UserFavouriteRestaurant::getRestaurantId)
                .collect(Collectors.toList());

        if (restaurantIds.isEmpty()) {
            return List.of();
        }

        List<Restaurant> restaurants = restaurantRepository.findAllById(restaurantIds);

        return restaurants.stream()
                .map(restaurantMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public boolean isFavourite(String userEmail, UUID restaurantId) {
        UserEntity user = userService.findByEmail(userEmail);
        return favouriteRepository.existsByUserIdAndRestaurantId(user.getId(), restaurantId);
    }

    @Override
    @Transactional(readOnly = true)
    public Set<UUID> getFavouriteIds(Long userId) {
        return favouriteRepository.findAllByUserId(userId).stream()
                .map(UserFavouriteRestaurant::getRestaurantId)
                .collect(Collectors.toSet());
    }
}
