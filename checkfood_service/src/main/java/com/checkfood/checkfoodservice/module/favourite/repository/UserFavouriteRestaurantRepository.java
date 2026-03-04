package com.checkfood.checkfoodservice.module.favourite.repository;

import com.checkfood.checkfoodservice.module.favourite.entity.UserFavouriteRestaurant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserFavouriteRestaurantRepository extends JpaRepository<UserFavouriteRestaurant, Long> {

    List<UserFavouriteRestaurant> findAllByUserIdOrderByCreatedAtDesc(Long userId);

    Optional<UserFavouriteRestaurant> findByUserIdAndRestaurantId(Long userId, UUID restaurantId);

    boolean existsByUserIdAndRestaurantId(Long userId, UUID restaurantId);

    void deleteByUserIdAndRestaurantId(Long userId, UUID restaurantId);

    List<UserFavouriteRestaurant> findAllByUserId(Long userId);
}
