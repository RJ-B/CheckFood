package com.checkfood.checkfoodservice.module.panorama.repository;

import com.checkfood.checkfoodservice.module.panorama.entity.PanoramaSession;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Repository pro přístup k panoramatickým session v databázi.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface PanoramaSessionRepository extends JpaRepository<PanoramaSession, UUID> {

    /**
     * Najde session podle ID a ID restaurace (kontrola vlastnictví).
     *
     * @param id           identifikátor session
     * @param restaurantId identifikátor restaurace
     * @return session pokud existuje a patří dané restauraci
     */
    Optional<PanoramaSession> findByIdAndRestaurantId(UUID id, UUID restaurantId);

    /**
     * Vrátí všechny session dané restaurace seřazené od nejnovější.
     *
     * @param restaurantId identifikátor restaurace
     * @return seznam session restaurace
     */
    List<PanoramaSession> findAllByRestaurantIdOrderByCreatedAtDesc(UUID restaurantId);

    /**
     * Smaže všechny panoramatické session dané restaurace.
     *
     * @param restaurantId identifikátor restaurace
     */
    void deleteAllByRestaurantId(UUID restaurantId);
}
