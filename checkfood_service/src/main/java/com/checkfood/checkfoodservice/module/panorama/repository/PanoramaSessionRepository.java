package com.checkfood.checkfoodservice.module.panorama.repository;

import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaSession;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface PanoramaSessionRepository extends JpaRepository<PanoramaSession, UUID> {
    Optional<PanoramaSession> findByIdAndRestaurantId(UUID id, UUID restaurantId);
    List<PanoramaSession> findAllByRestaurantIdOrderByCreatedAtDesc(UUID restaurantId);
}
