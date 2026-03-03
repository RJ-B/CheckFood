package com.checkfood.checkfoodservice.module.restaurant.repository;

import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployee;
import com.checkfood.checkfoodservice.module.restaurant.entity.employee.RestaurantEmployeeRole;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface RestaurantEmployeeRepository extends JpaRepository<RestaurantEmployee, Long> {

    @EntityGraph(attributePaths = {"user", "restaurant"})
    Optional<RestaurantEmployee> findByUserIdAndRestaurantId(Long userId, UUID restaurantId);

    @EntityGraph(attributePaths = {"restaurant"})
    Optional<RestaurantEmployee> findByUserId(Long userId);

    @EntityGraph(attributePaths = {"restaurant"})
    List<RestaurantEmployee> findAllByUserId(Long userId);

    @EntityGraph(attributePaths = {"user"})
    List<RestaurantEmployee> findAllByRestaurantId(UUID restaurantId);

    boolean existsByUserIdAndRestaurantId(Long userId, UUID restaurantId);

    Optional<RestaurantEmployee> findByUserIdAndRole(Long userId, RestaurantEmployeeRole role);

    void deleteByIdAndRestaurantId(Long id, UUID restaurantId);
}