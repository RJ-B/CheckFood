package com.checkfood.checkfoodservice.module.reservation.repository;

import com.checkfood.checkfoodservice.module.reservation.entity.ChangeRequestStatus;
import com.checkfood.checkfoodservice.module.reservation.entity.ReservationChangeRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Spring Data JPA repozitář pro správu návrhů změn rezervací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface ReservationChangeRequestRepository extends JpaRepository<ReservationChangeRequest, UUID> {

    /**
     * Ověří, zda pro danou rezervaci existuje návrh změny v zadaném stavu.
     *
     * @param reservationId UUID rezervace
     * @param status        hledaný stav návrhu
     * @return {@code true} pokud existuje alespoň jeden návrh v daném stavu
     */
    boolean existsByReservationIdAndStatus(UUID reservationId, ChangeRequestStatus status);

    /**
     * Najde návrh změny pro rezervaci v zadaném stavu.
     *
     * @param reservationId UUID rezervace
     * @param status        hledaný stav návrhu
     * @return volitelný výsledek s nalezeným návrhem
     */
    Optional<ReservationChangeRequest> findByReservationIdAndStatus(UUID reservationId, ChangeRequestStatus status);

    /**
     * Najde všechny návrhy změn rezervací daného uživatele v zadaném stavu.
     *
     * @param userId ID uživatele (vlastníka rezervace)
     * @param status hledaný stav návrhu
     * @return seznam návrhů seřazený sestupně podle data vytvoření
     */
    @Query("""
        SELECT cr FROM ReservationChangeRequest cr
        JOIN Reservation r ON cr.reservationId = r.id
        WHERE r.userId = :userId AND cr.status = :status
        ORDER BY cr.createdAt DESC
    """)
    List<ReservationChangeRequest> findAllByReservationUserIdAndStatus(
        @Param("userId") Long userId,
        @Param("status") ChangeRequestStatus status
    );

    /**
     * Vrátí UUID rezervací ze zadané kolekce, pro které existuje návrh v daném stavu.
     * Slouží pro hromadnou detekci nevyřízených návrhů bez N+1 dotazů.
     *
     * @param reservationIds kolekce UUID rezervací ke kontrole
     * @param status         hledaný stav návrhu
     * @return seznam UUID rezervací, které mají návrh v daném stavu
     */
    @Query("""
        SELECT cr.reservationId FROM ReservationChangeRequest cr
        WHERE cr.reservationId IN :reservationIds AND cr.status = :status
    """)
    List<UUID> findReservationIdsWithStatus(
        @Param("reservationIds") Collection<UUID> reservationIds,
        @Param("status") ChangeRequestStatus status
    );
}
