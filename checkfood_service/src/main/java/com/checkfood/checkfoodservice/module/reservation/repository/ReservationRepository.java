package com.checkfood.checkfoodservice.module.reservation.repository;

import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, UUID> {

    /**
     * Najde všechny aktivní rezervace pro daný stůl a datum.
     * Vylučuje zrušené a zamítnuté rezervace.
     */
    List<Reservation> findAllByTableIdAndDateAndStatusNotIn(
            UUID tableId, LocalDate date, List<ReservationStatus> excludeStatuses
    );

    /**
     * Najde všechny aktivní rezervace pro celou restauraci a datum.
     * Vylučuje zrušené a zamítnuté rezervace.
     */
    List<Reservation> findAllByRestaurantIdAndDateAndStatusNotIn(
            UUID restaurantId, LocalDate date, List<ReservationStatus> excludeStatuses
    );

    /**
     * Kontrola kolize (open-ended model): existuje aktivní rezervace pro daný stůl a datum,
     * jejíž startTime <= nový startTime? Aktivní rezervace blokuje stůl do ukončení staffem.
     */
    @Query("""
            SELECT COUNT(r) > 0 FROM Reservation r
            WHERE r.tableId = :tableId
              AND r.date = :date
              AND r.status NOT IN ('CANCELLED', 'REJECTED', 'COMPLETED')
              AND r.startTime <= :startTime
            """)
    boolean existsOverlappingReservation(
            @Param("tableId") UUID tableId,
            @Param("date") LocalDate date,
            @Param("startTime") LocalTime startTime
    );

    /**
     * Rezervace aktuálního uživatele seřazené od nejnovějších.
     */
    List<Reservation> findAllByUserIdOrderByDateDescStartTimeDesc(Long userId);

    /**
     * Najde aktivní dining rezervace uživatele (open-ended model).
     * Rezervace je aktivní pokud startTime <= windowEnd a není ukončena (endTime IS NULL).
     * Ukončené rezervace (endTime IS NOT NULL) se zahrnou jen pokud endTime >= windowStart.
     */
    @Query("""
            SELECT r FROM Reservation r
            WHERE r.userId = :userId
              AND r.date = :date
              AND r.status IN ('CONFIRMED', 'RESERVED', 'CHECKED_IN')
              AND r.startTime <= :windowEnd
              AND (r.endTime IS NULL OR r.endTime >= :windowStart)
            ORDER BY r.startTime ASC
            """)
    List<Reservation> findActiveDiningReservations(
            @Param("userId") Long userId,
            @Param("date") LocalDate date,
            @Param("windowStart") LocalTime windowStart,
            @Param("windowEnd") LocalTime windowEnd
    );

    /**
     * Najde všechny rezervace pro restauraci a datum, seřazené podle času začátku.
     * Používáno staff endpointem.
     */
    List<Reservation> findAllByRestaurantIdAndDateOrderByStartTimeAsc(
            UUID restaurantId, LocalDate date
    );

    /**
     * Najde PENDING_CONFIRMATION rezervace starší než cutoff (pro auto-confirm scheduler).
     */
    @Query("SELECT r FROM Reservation r WHERE r.status = 'PENDING_CONFIRMATION' AND r.createdAt < :cutoff")
    List<Reservation> findPendingOlderThan(@Param("cutoff") LocalDateTime cutoff);

    /**
     * Kontrola kolize při úpravě (open-ended model): stejná logika jako existsOverlappingReservation,
     * ale vylučuje aktuálně upravovanou rezervaci (excludeId).
     */
    @Query("""
            SELECT COUNT(r) > 0 FROM Reservation r
            WHERE r.tableId = :tableId
              AND r.date = :date
              AND r.status NOT IN ('CANCELLED', 'REJECTED', 'COMPLETED')
              AND r.id <> :excludeId
              AND r.startTime <= :startTime
            """)
    boolean existsOverlappingReservationExcluding(
            @Param("tableId") UUID tableId,
            @Param("date") LocalDate date,
            @Param("startTime") LocalTime startTime,
            @Param("excludeId") UUID excludeId
    );
}
