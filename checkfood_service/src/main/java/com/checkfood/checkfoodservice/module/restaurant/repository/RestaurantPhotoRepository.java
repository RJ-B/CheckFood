package com.checkfood.checkfoodservice.module.restaurant.repository;

import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.RestaurantPhoto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * JPA repository pro {@link RestaurantPhoto} (galerie fotek restaurace).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface RestaurantPhotoRepository extends JpaRepository<RestaurantPhoto, UUID> {

    List<RestaurantPhoto> findAllByRestaurantIdOrderBySortOrderAscCreatedAtAsc(UUID restaurantId);

    long countByRestaurantId(UUID restaurantId);

    void deleteAllByRestaurantId(UUID restaurantId);
}
