package com.checkfood.checkfoodservice.module.order.dining.service;

import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSession;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionMember;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionStatus;
import com.checkfood.checkfoodservice.module.order.dining.exception.DiningSessionException;
import com.checkfood.checkfoodservice.module.order.dining.repository.DiningSessionMemberRepository;
import com.checkfood.checkfoodservice.module.order.dining.repository.DiningSessionRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Implementace {@link DiningSessionService} spravující skupinová sezení u stolu
 * s generováním unikátních pozvánkových kódů a idempotentním připojováním členů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class DiningSessionServiceImpl implements DiningSessionService {

    private static final String INVITE_CODE_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final int INVITE_CODE_LENGTH = 8;
    private static final SecureRandom RANDOM = new SecureRandom();

    private final DiningSessionRepository sessionRepository;
    private final DiningSessionMemberRepository memberRepository;

    @Override
    @Transactional
    public DiningSession createSession(UUID restaurantId, UUID tableId, UUID reservationId, Long userId) {
        if (reservationId != null) {
            Optional<DiningSession> existing = sessionRepository
                    .findByReservationIdAndStatus(reservationId, DiningSessionStatus.ACTIVE);
            if (existing.isPresent()) {
                log.info("Aktivní sezení pro rezervaci {} již existuje: {}", reservationId, existing.get().getId());
                return existing.get();
            }
        }

        String inviteCode = generateUniqueInviteCode();

        DiningSession session = DiningSession.builder()
                .restaurantId(restaurantId)
                .tableId(tableId)
                .reservationId(reservationId)
                .inviteCode(inviteCode)
                .status(DiningSessionStatus.ACTIVE)
                .createdByUserId(userId)
                .build();

        DiningSession saved = sessionRepository.save(session);

        DiningSessionMember member = DiningSessionMember.builder()
                .sessionId(saved.getId())
                .userId(userId)
                .build();
        memberRepository.save(member);

        log.info("Sezení {} vytvořeno pro stůl {}, restaurace {}, kód={}", saved.getId(), tableId, restaurantId, inviteCode);
        return saved;
    }

    @Override
    @Transactional
    public DiningSession joinSession(String inviteCode, Long userId) {
        DiningSession session = sessionRepository
                .findByInviteCodeAndStatus(inviteCode.toUpperCase(), DiningSessionStatus.ACTIVE)
                .orElseThrow(() -> DiningSessionException.invalidCode(inviteCode));

        if (memberRepository.existsBySessionIdAndUserId(session.getId(), userId)) {
            log.debug("Uživatel {} je již členem sezení {}", userId, session.getId());
            return session;
        }

        DiningSessionMember member = DiningSessionMember.builder()
                .sessionId(session.getId())
                .userId(userId)
                .build();
        memberRepository.save(member);

        log.info("Uživatel {} se připojil k sezení {}", userId, session.getId());
        return session;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<DiningSession> findActiveSessionForUser(Long userId) {
        return sessionRepository.findActiveByUserId(userId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<DiningSessionMember> getMembers(UUID sessionId) {
        return memberRepository.findAllBySessionId(sessionId);
    }

    @Override
    @Transactional
    public void closeSession(UUID sessionId, Long userId) {
        DiningSession session = sessionRepository.findById(sessionId)
                .orElseThrow(() -> DiningSessionException.notFound(sessionId));

        if (session.getStatus() == DiningSessionStatus.CLOSED) {
            throw DiningSessionException.alreadyClosed(sessionId);
        }

        if (!session.getCreatedByUserId().equals(userId)) {
            throw DiningSessionException.notHost(sessionId);
        }

        session.setStatus(DiningSessionStatus.CLOSED);
        sessionRepository.save(session);
        log.info("Sezení {} uzavřeno uživatelem {}", sessionId, userId);
    }

    /**
     * Vygeneruje unikátní pozvánkový kód složený z písmen a číslic.
     * Při kolizi se pokusí o nový kód, maximálně 10 pokusů.
     *
     * @return unikátní 8-znakový pozvánkový kód
     * @throws IllegalStateException pokud se nepodaří vygenerovat unikátní kód po 10 pokusech
     */
    private String generateUniqueInviteCode() {
        for (int attempt = 0; attempt < 10; attempt++) {
            String code = randomCode();
            if (!sessionRepository.existsByInviteCode(code)) {
                return code;
            }
        }
        throw new IllegalStateException("Nelze vygenerovat unikátní kód pozvánky po 10 pokusech.");
    }

    private String randomCode() {
        StringBuilder sb = new StringBuilder(INVITE_CODE_LENGTH);
        for (int i = 0; i < INVITE_CODE_LENGTH; i++) {
            sb.append(INVITE_CODE_CHARS.charAt(RANDOM.nextInt(INVITE_CODE_CHARS.length())));
        }
        return sb.toString();
    }
}
