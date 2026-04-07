package com.checkfood.checkfoodservice.module.order.dining.repository;

import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * JPA repozitář pro entitu {@link DiningSessionMember} poskytující dotazy pro správu členů sezení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface DiningSessionMemberRepository extends JpaRepository<DiningSessionMember, Long> {

    List<DiningSessionMember> findAllBySessionId(UUID sessionId);

    boolean existsBySessionIdAndUserId(UUID sessionId, Long userId);
}
