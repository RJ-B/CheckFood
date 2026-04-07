package com.checkfood.checkfoodservice.module.order.dining.repository;

import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSession;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

/**
 * JPA repozitář pro entitu {@link DiningSession} poskytující dotazy pro vyhledávání sezení
 * podle pozvánkového kódu, rezervace a aktivního členství uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface DiningSessionRepository extends JpaRepository<DiningSession, UUID> {

    Optional<DiningSession> findByInviteCodeAndStatus(String inviteCode, DiningSessionStatus status);

    Optional<DiningSession> findByReservationIdAndStatus(UUID reservationId, DiningSessionStatus status);

    @Query("SELECT ds FROM DiningSession ds JOIN DiningSessionMember m ON m.sessionId = ds.id " +
           "WHERE m.userId = :userId AND ds.status = 'ACTIVE'")
    Optional<DiningSession> findActiveByUserId(@Param("userId") Long userId);

    boolean existsByInviteCode(String inviteCode);
}
