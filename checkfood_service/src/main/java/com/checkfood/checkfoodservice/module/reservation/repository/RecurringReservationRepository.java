package com.checkfood.checkfoodservice.module.reservation.repository;

import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservation;
import com.checkfood.checkfoodservice.module.reservation.entity.RecurringReservationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * Spring Data JPA repozitář pro správu opakovaných rezervací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface RecurringReservationRepository extends JpaRepository<RecurringReservation, UUID> {

    /**
     * Vrátí všechny opakované rezervace uživatele seřazené od nejnovějších.
     *
     * @param userId ID uživatele
     * @return seznam opakovaných rezervací seřazený sestupně podle data vytvoření
     */
    List<RecurringReservation> findAllByUserIdOrderByCreatedAtDesc(Long userId);

    /**
     * Vrátí opakované rezervace restaurace filtrované podle zadaných stavů.
     *
     * @param restaurantId UUID restaurace
     * @param statuses     seznam přijatelných stavů
     * @return seznam opakovaných rezervací splňujících podmínky
     */
    List<RecurringReservation> findAllByRestaurantIdAndStatusIn(UUID restaurantId, List<RecurringReservationStatus> statuses);
}
