package com.checkfood.checkfoodservice.module.order.dining.service;

import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSession;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionMember;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionStatus;
import com.checkfood.checkfoodservice.module.order.dining.exception.DiningSessionException;
import com.checkfood.checkfoodservice.module.order.dining.repository.DiningSessionMemberRepository;
import com.checkfood.checkfoodservice.module.order.dining.repository.DiningSessionRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("DiningSessionService unit tests")
class DiningSessionServiceTest {

    @Mock private DiningSessionRepository sessionRepository;
    @Mock private DiningSessionMemberRepository memberRepository;

    @InjectMocks
    private DiningSessionServiceImpl diningSessionService;

    private static final Long HOST_USER_ID = 1L;
    private static final Long GUEST_USER_ID = 2L;
    private static final UUID RESTAURANT_ID = UUID.randomUUID();
    private static final UUID TABLE_ID = UUID.randomUUID();
    private static final UUID RESERVATION_ID = UUID.randomUUID();
    private static final UUID SESSION_ID = UUID.randomUUID();
    private static final String INVITE_CODE = "ABCD1234";

    private DiningSession activeSession;

    @BeforeEach
    void setUp() {
        activeSession = DiningSession.builder()
                .id(SESSION_ID)
                .restaurantId(RESTAURANT_ID)
                .tableId(TABLE_ID)
                .reservationId(RESERVATION_ID)
                .inviteCode(INVITE_CODE)
                .status(DiningSessionStatus.ACTIVE)
                .createdByUserId(HOST_USER_ID)
                .createdAt(LocalDateTime.now())
                .build();
    }

    // =========================================================================
    // createSession
    // =========================================================================

    @Nested
    @DisplayName("createSession")
    class CreateSession {

        @Test
        @DisplayName("creates new session and registers host as member")
        void should_createSessionAndAddHost() {
            given(sessionRepository.findByReservationIdAndStatus(RESERVATION_ID, DiningSessionStatus.ACTIVE))
                    .willReturn(Optional.empty());
            given(sessionRepository.existsByInviteCode(any())).willReturn(false);
            given(sessionRepository.save(any())).willReturn(activeSession);
            given(memberRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            DiningSession result = diningSessionService.createSession(RESTAURANT_ID, TABLE_ID, RESERVATION_ID, HOST_USER_ID);

            assertThat(result).isNotNull();
            verify(memberRepository).save(argThat(m -> m.getUserId().equals(HOST_USER_ID)));
        }

        @Test
        @DisplayName("returns existing active session for same reservation — idempotent")
        void should_returnExisting_when_activeSessionExistsForReservation() {
            given(sessionRepository.findByReservationIdAndStatus(RESERVATION_ID, DiningSessionStatus.ACTIVE))
                    .willReturn(Optional.of(activeSession));

            DiningSession result = diningSessionService.createSession(RESTAURANT_ID, TABLE_ID, RESERVATION_ID, HOST_USER_ID);

            assertThat(result.getId()).isEqualTo(SESSION_ID);
            verify(sessionRepository, never()).save(any());
            verify(memberRepository, never()).save(any());
        }

        @Test
        @DisplayName("creates new session when reservationId is null (walk-in)")
        void should_createNewSession_when_walkinNoReservation() {
            given(sessionRepository.existsByInviteCode(any())).willReturn(false);
            DiningSession walkinSession = DiningSession.builder()
                    .id(UUID.randomUUID())
                    .restaurantId(RESTAURANT_ID)
                    .tableId(TABLE_ID)
                    .reservationId(null)
                    .inviteCode("WALKIN01")
                    .status(DiningSessionStatus.ACTIVE)
                    .createdByUserId(HOST_USER_ID)
                    .build();
            given(sessionRepository.save(any())).willReturn(walkinSession);
            given(memberRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            DiningSession result = diningSessionService.createSession(RESTAURANT_ID, TABLE_ID, null, HOST_USER_ID);

            assertThat(result).isNotNull();
        }

        @Test
        @DisplayName("invite code is exactly 8 uppercase alphanumeric characters")
        void should_generateEightCharCode() {
            given(sessionRepository.existsByInviteCode(any())).willReturn(false);

            ArgumentCaptor<DiningSession> captor = ArgumentCaptor.forClass(DiningSession.class);
            given(sessionRepository.save(captor.capture())).willReturn(activeSession);
            given(memberRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            diningSessionService.createSession(RESTAURANT_ID, TABLE_ID, null, HOST_USER_ID);

            String code = captor.getValue().getInviteCode();
            assertThat(code).hasSize(8).matches("[A-Z0-9]+");
        }

        @Test
        @DisplayName("retries invite code generation on collision")
        void should_retryCodeGeneration_on_collision() {
            // first call returns collision, second returns false
            given(sessionRepository.existsByInviteCode(any()))
                    .willReturn(true)
                    .willReturn(false);
            given(sessionRepository.save(any())).willReturn(activeSession);
            given(memberRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            diningSessionService.createSession(RESTAURANT_ID, TABLE_ID, null, HOST_USER_ID);

            verify(sessionRepository, atLeast(2)).existsByInviteCode(any());
        }

        @Test
        @DisplayName("throws IllegalStateException after 10 code collisions")
        void should_throwIllegalState_when_tenCodeCollisions() {
            given(sessionRepository.existsByInviteCode(any())).willReturn(true); // always collision

            assertThatThrownBy(() ->
                    diningSessionService.createSession(RESTAURANT_ID, TABLE_ID, null, HOST_USER_ID))
                    .isInstanceOf(IllegalStateException.class);
        }
    }

    // =========================================================================
    // joinSession
    // =========================================================================

    @Nested
    @DisplayName("joinSession")
    class JoinSession {

        @Test
        @DisplayName("happy path — new member added to session")
        void should_addMember_when_validCode() {
            given(sessionRepository.findByInviteCodeAndStatus(INVITE_CODE, DiningSessionStatus.ACTIVE))
                    .willReturn(Optional.of(activeSession));
            given(memberRepository.existsBySessionIdAndUserId(SESSION_ID, GUEST_USER_ID)).willReturn(false);
            given(memberRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            DiningSession result = diningSessionService.joinSession(INVITE_CODE, GUEST_USER_ID);

            assertThat(result.getId()).isEqualTo(SESSION_ID);
            verify(memberRepository).save(argThat(m -> m.getUserId().equals(GUEST_USER_ID)));
        }

        @Test
        @DisplayName("idempotent — no duplicate member row if already member")
        void should_notAddDuplicateMember_when_alreadyMember() {
            given(sessionRepository.findByInviteCodeAndStatus(INVITE_CODE, DiningSessionStatus.ACTIVE))
                    .willReturn(Optional.of(activeSession));
            given(memberRepository.existsBySessionIdAndUserId(SESSION_ID, GUEST_USER_ID)).willReturn(true);

            DiningSession result = diningSessionService.joinSession(INVITE_CODE, GUEST_USER_ID);

            assertThat(result.getId()).isEqualTo(SESSION_ID);
            verify(memberRepository, never()).save(any());
        }

        @Test
        @DisplayName("throws 404 when invite code invalid or session closed")
        void should_throw404_when_invalidCode() {
            given(sessionRepository.findByInviteCodeAndStatus("BADCODE1", DiningSessionStatus.ACTIVE))
                    .willReturn(Optional.empty());

            assertThatThrownBy(() -> diningSessionService.joinSession("BADCODE1", GUEST_USER_ID))
                    .isInstanceOf(DiningSessionException.class)
                    .satisfies(ex -> assertThat(((DiningSessionException) ex).getStatus())
                            .isEqualTo(HttpStatus.NOT_FOUND));
        }

        @Test
        @DisplayName("invite code is uppercased before lookup")
        void should_uppercaseCode_before_lookup() {
            given(sessionRepository.findByInviteCodeAndStatus("ABCD1234", DiningSessionStatus.ACTIVE))
                    .willReturn(Optional.of(activeSession));
            given(memberRepository.existsBySessionIdAndUserId(SESSION_ID, GUEST_USER_ID)).willReturn(false);
            given(memberRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            diningSessionService.joinSession("abcd1234", GUEST_USER_ID); // lowercase input

            verify(sessionRepository).findByInviteCodeAndStatus("ABCD1234", DiningSessionStatus.ACTIVE);
        }
    }

    // =========================================================================
    // closeSession
    // =========================================================================

    @Nested
    @DisplayName("closeSession")
    class CloseSession {

        @Test
        @DisplayName("host can close active session")
        void should_closeSession_when_hostRequests() {
            given(sessionRepository.findById(SESSION_ID)).willReturn(Optional.of(activeSession));
            given(sessionRepository.save(any())).willAnswer(inv -> inv.getArgument(0));

            diningSessionService.closeSession(SESSION_ID, HOST_USER_ID);

            ArgumentCaptor<DiningSession> captor = ArgumentCaptor.forClass(DiningSession.class);
            verify(sessionRepository).save(captor.capture());
            assertThat(captor.getValue().getStatus()).isEqualTo(DiningSessionStatus.CLOSED);
        }

        @Test
        @DisplayName("throws 403 when non-host tries to close session")
        void should_throw403_when_nonHostTriesToClose() {
            given(sessionRepository.findById(SESSION_ID)).willReturn(Optional.of(activeSession));

            assertThatThrownBy(() -> diningSessionService.closeSession(SESSION_ID, GUEST_USER_ID))
                    .isInstanceOf(DiningSessionException.class)
                    .satisfies(ex -> assertThat(((DiningSessionException) ex).getStatus())
                            .isEqualTo(HttpStatus.FORBIDDEN));
        }

        @Test
        @DisplayName("throws 409 when session already closed")
        void should_throw409_when_sessionAlreadyClosed() {
            DiningSession closed = DiningSession.builder()
                    .id(SESSION_ID)
                    .status(DiningSessionStatus.CLOSED)
                    .createdByUserId(HOST_USER_ID)
                    .build();
            given(sessionRepository.findById(SESSION_ID)).willReturn(Optional.of(closed));

            assertThatThrownBy(() -> diningSessionService.closeSession(SESSION_ID, HOST_USER_ID))
                    .isInstanceOf(DiningSessionException.class)
                    .satisfies(ex -> assertThat(((DiningSessionException) ex).getStatus())
                            .isEqualTo(HttpStatus.CONFLICT));
        }

        @Test
        @DisplayName("throws 404 when session not found")
        void should_throw404_when_sessionNotFound() {
            given(sessionRepository.findById(SESSION_ID)).willReturn(Optional.empty());

            assertThatThrownBy(() -> diningSessionService.closeSession(SESSION_ID, HOST_USER_ID))
                    .isInstanceOf(DiningSessionException.class)
                    .satisfies(ex -> assertThat(((DiningSessionException) ex).getStatus())
                            .isEqualTo(HttpStatus.NOT_FOUND));
        }

        @Test
        @DisplayName("idempotency: second call to close an already-closed session should not silently succeed")
        void should_throw_when_closedSessionClosedAgain() {
            // GAP: closeSession on an already-closed session throws 409. Verify this is also idempotent from API perspective.
            DiningSession closed = DiningSession.builder()
                    .id(SESSION_ID)
                    .status(DiningSessionStatus.CLOSED)
                    .createdByUserId(HOST_USER_ID)
                    .build();
            given(sessionRepository.findById(SESSION_ID)).willReturn(Optional.of(closed));

            assertThatThrownBy(() -> diningSessionService.closeSession(SESSION_ID, HOST_USER_ID))
                    .isInstanceOf(DiningSessionException.class);
        }
    }

    // =========================================================================
    // findActiveSessionForUser
    // =========================================================================

    @Nested
    @DisplayName("findActiveSessionForUser")
    class FindActiveSession {

        @Test
        @DisplayName("returns active session when user is member")
        void should_returnSession_when_userIsMember() {
            given(sessionRepository.findActiveByUserId(HOST_USER_ID)).willReturn(Optional.of(activeSession));

            Optional<DiningSession> result = diningSessionService.findActiveSessionForUser(HOST_USER_ID);

            assertThat(result).isPresent().contains(activeSession);
        }

        @Test
        @DisplayName("returns empty when user has no active session")
        void should_returnEmpty_when_noActiveSession() {
            given(sessionRepository.findActiveByUserId(HOST_USER_ID)).willReturn(Optional.empty());

            Optional<DiningSession> result = diningSessionService.findActiveSessionForUser(HOST_USER_ID);

            assertThat(result).isEmpty();
        }
    }

    // =========================================================================
    // getMembers
    // =========================================================================

    @Nested
    @DisplayName("getMembers")
    class GetMembers {

        @Test
        @DisplayName("returns all members of session")
        void should_returnMembers() {
            List<DiningSessionMember> members = List.of(
                    buildMember(HOST_USER_ID),
                    buildMember(GUEST_USER_ID)
            );
            given(memberRepository.findAllBySessionId(SESSION_ID)).willReturn(members);

            List<DiningSessionMember> result = diningSessionService.getMembers(SESSION_ID);

            assertThat(result).hasSize(2);
        }

        @Test
        @DisplayName("returns empty list for session with no members")
        void should_returnEmpty_when_noMembers() {
            given(memberRepository.findAllBySessionId(SESSION_ID)).willReturn(List.of());

            List<DiningSessionMember> result = diningSessionService.getMembers(SESSION_ID);

            assertThat(result).isEmpty();
        }
    }

    // =========================================================================
    // Helpers
    // =========================================================================

    private DiningSessionMember buildMember(Long userId) {
        return DiningSessionMember.builder()
                .sessionId(SESSION_ID)
                .userId(userId)
                .joinedAt(LocalDateTime.now())
                .build();
    }
}
