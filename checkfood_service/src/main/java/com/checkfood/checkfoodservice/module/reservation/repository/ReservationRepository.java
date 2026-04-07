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

/**
 * Spring Data JPA repozitář pro správu rezervací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface ReservationRepository extends JpaRepository<Reservation, UUID> {

    /**
     * Najde všechny aktivní rezervace pro daný stůl a datum.
     * Vylučuje zrušené a zamítnuté rezervace.
     *
     * @param tableId         UUID stolu
     * @param date            datum rezervace
     * @param excludeStatuses stavy které mají být vyloučeny z výsledku
     * @return seznam rezervací splňujících podmínky
     */
    List<Reservation> findAllByTableIdAndDateAndStatusNotIn(
            UUID tableId, LocalDate date, List<ReservationStatus> excludeStatuses
    );

    /**
     * Najde všechny aktivní rezervace pro celou restauraci a datum.
     * Vylučuje zrušené a zamítnuté rezervace.
     *
     * @param restaurantId    UUID restaurace
     * @param date            datum rezervace
     * @param excludeStatuses stavy které mají být vyloučeny z výsledku
     * @return seznam rezervací splňujících podmínky
     */
    List<Reservation> findAllByRestaurantIdAndDateAndStatusNotIn(
            UUID restaurantId, LocalDate date, List<ReservationStatus> excludeStatuses
    );

    /**
     * Kontrola kolize: existuje aktivní rezervace pro daný stůl a datum,
     * která se překrývá s požadovaným časovým rozsahem [startTime, endTime)?
     *
     * @param tableId   UUID stolu
     * @param date      datum rezervace
     * @param startTime začátek požadovaného slotu
     * @param endTime   konec požadovaného slotu
     * @return {@code true} pokud existuje překrývající se rezervace
     */
    @Query("""
            SELECT COUNT(r) > 0 FROM Reservation r
            WHERE r.tableId = :tableId
              AND r.date = :date
              AND r.status NOT IN ('CANCELLED', 'REJECTED', 'COMPLETED')
              AND r.startTime < :endTime
              AND (r.endTime IS NULL OR r.endTime > :startTime)
            """)
    boolean existsOverlappingReservation(
            @Param("tableId") UUID tableId,
            @Param("date") LocalDate date,
            @Param("startTime") LocalTime startTime,
            @Param("endTime") LocalTime endTime
    );

    /**
     * Vrátí všechny rezervace uživatele seřazené od nejnovějších.
     *
     * @param userId ID uživatele
     * @return seznam rezervací seřazený sestupně podle data a času
     */
    List<Reservation> findAllByUserIdOrderByDateDescStartTimeDesc(Long userId);

    /**
     * Najde aktivní dining rezervace uživatele pro daný den a časové okno.
     * Zahrnuje pouze rezervace ve stavu {@code CHECKED_IN} — objednávky jsou přístupné
     * výhradně po check-in zákazníka.
     *
     * @param userId      ID uživatele
     * @param date        datum rezervace
     * @param windowStart začátek časového okna
     * @param windowEnd   konec časového okna
     * @return seznam aktivních dining rezervací seřazených podle začátku
     */
    @Query("""
            SELECT r FROM Reservation r
            WHERE r.userId = :userId
              AND r.date = :date
              AND r.status = 'CHECKED_IN'
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
     * Najde všechny rezervace restaurace pro daný den seřazené podle času začátku.
     *
     * @param restaurantId UUID restaurace
     * @param date         datum rezervace
     * @return seznam rezervací seřazený vzestupně podle začátku
     */
    List<Reservation> findAllByRestaurantIdAndDateOrderByStartTimeAsc(
            UUID restaurantId, LocalDate date
    );

    /**
     * Najde rezervace ve stavu {@code PENDING_CONFIRMATION} vytvořené před daným časovým bodem.
     * Slouží pro automatické potvrzení rezervací čekajících déle než je povolená lhůta.
     *
     * @param cutoff časový bod; rezervace vytvořené před ním budou vráceny
     * @return seznam čekajících rezervací po lhůtě
     */
    @Query("SELECT r FROM Reservation r WHERE r.status = 'PENDING_CONFIRMATION' AND r.createdAt < :cutoff")
    List<Reservation> findPendingOlderThan(@Param("cutoff") LocalDateTime cutoff);

    /**
     * Najde instance opakované rezervace od daného data, vylučující zadané stavy.
     * Slouží pro zrušení budoucích instancí série nebo pro počítání existujících instancí.
     *
     * @param recurringReservationId UUID opakované rezervace
     * @param fromDate               nejdřívější datum instancí (včetně)
     * @param excludeStatuses        stavy které mají být vyloučeny
     * @return seznam instancí splňujících podmínky
     */
    List<Reservation> findAllByRecurringReservationIdAndDateGreaterThanEqualAndStatusNotIn(
            UUID recurringReservationId, LocalDate fromDate, List<ReservationStatus> excludeStatuses);

    /**
     * Kontrola kolize při úpravě rezervace — stejná logika jako {@link #existsOverlappingReservation},
     * ale vylučuje právě upravovanou rezervaci ({@code excludeId}).
     *
     * @param tableId   UUID stolu
     * @param date      datum rezervace
     * @param startTime začátek požadovaného slotu
     * @param endTime   konec požadovaného slotu
     * @param excludeId UUID rezervace která má být vyloučena z porovnání
     * @return {@code true} pokud existuje jiná překrývající se rezervace
     */
    @Query("""
            SELECT COUNT(r) > 0 FROM Reservation r
            WHERE r.tableId = :tableId
              AND r.date = :date
              AND r.status NOT IN ('CANCELLED', 'REJECTED', 'COMPLETED')
              AND r.id <> :excludeId
              AND r.startTime < :endTime
              AND (r.endTime IS NULL OR r.endTime > :startTime)
            """)
    boolean existsOverlappingReservationExcluding(
            @Param("tableId") UUID tableId,
            @Param("date") LocalDate date,
            @Param("startTime") LocalTime startTime,
            @Param("endTime") LocalTime endTime,
            @Param("excludeId") UUID excludeId
    );
}
