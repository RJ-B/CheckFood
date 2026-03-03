package com.checkfood.checkfoodservice.module.reservation.repository;

import com.checkfood.checkfoodservice.module.reservation.entity.Reservation;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
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
     * Kontrola kolize: existuje aktivní rezervace pro daný stůl, datum a překrývající se čas?
     * Overlap: existingStart < newEnd AND existingEnd > newStart
     * Vylučuje CANCELLED a REJECTED.
     */
    @Query("""
            SELECT COUNT(r) > 0 FROM Reservation r
            WHERE r.tableId = :tableId
              AND r.date = :date
              AND r.status NOT IN ('CANCELLED', 'REJECTED')
              AND r.startTime < :endTime
              AND r.endTime > :startTime
            """)
    boolean existsOverlappingReservation(
            @Param("tableId") UUID tableId,
            @Param("date") LocalDate date,
            @Param("startTime") LocalTime startTime,
            @Param("endTime") LocalTime endTime
    );

    /**
     * Rezervace aktuálního uživatele seřazené od nejnovějších.
     */
    List<Reservation> findAllByUserIdOrderByDateDescStartTimeDesc(Long userId);

    /**
     * Najde potvrzené rezervace uživatele v daném časovém okně (pro DiningContext).
     * Pouze CONFIRMED a RESERVED (backward compat) mohou vytvořit dining context.
     */
    @Query("""
            SELECT r FROM Reservation r
            WHERE r.userId = :userId
              AND r.date = :date
              AND r.status IN ('CONFIRMED', 'RESERVED')
              AND r.startTime <= :windowEnd
              AND r.endTime >= :windowStart
            ORDER BY r.startTime ASC
            """)
    List<Reservation> findActiveDiningReservations(
            @Param("userId") Long userId,
            @Param("date") LocalDate date,
            @Param("windowStart") LocalTime windowStart,
            @Param("windowEnd") LocalTime windowEnd
    );

    /**
     * Kontrola kolize při úpravě: stejná logika jako existsOverlappingReservation,
     * ale vylučuje aktuálně upravovanou rezervaci (excludeId).
     */
    @Query("""
            SELECT COUNT(r) > 0 FROM Reservation r
            WHERE r.tableId = :tableId
              AND r.date = :date
              AND r.status NOT IN ('CANCELLED', 'REJECTED')
              AND r.id <> :excludeId
              AND r.startTime < :endTime
              AND r.endTime > :startTime
            """)
    boolean existsOverlappingReservationExcluding(
            @Param("tableId") UUID tableId,
            @Param("date") LocalDate date,
            @Param("startTime") LocalTime startTime,
            @Param("endTime") LocalTime endTime,
            @Param("excludeId") UUID excludeId
    );
}
