package com.checkfood.checkfoodservice.module.restaurant.favourite.repository;

import com.checkfood.checkfoodservice.module.restaurant.favourite.entity.UserFavouriteRestaurant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * JPA repozitář pro entitu {@link UserFavouriteRestaurant} poskytující dotazy pro správu oblíbených
 * restaurací uživatele — přidání, odebrání, kontrola existence a načtení seznamu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface UserFavouriteRestaurantRepository extends JpaRepository<UserFavouriteRestaurant, Long> {

    List<UserFavouriteRestaurant> findAllByUserIdOrderByCreatedAtDesc(Long userId);

    Optional<UserFavouriteRestaurant> findByUserIdAndRestaurantId(Long userId, UUID restaurantId);

    boolean existsByUserIdAndRestaurantId(Long userId, UUID restaurantId);

    void deleteByUserIdAndRestaurantId(Long userId, UUID restaurantId);

    List<UserFavouriteRestaurant> findAllByUserId(Long userId);
}
