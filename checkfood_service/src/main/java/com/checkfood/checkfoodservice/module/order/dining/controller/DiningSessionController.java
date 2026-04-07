package com.checkfood.checkfoodservice.module.order.dining.controller;

import com.checkfood.checkfoodservice.module.order.dining.dto.request.JoinSessionRequest;
import com.checkfood.checkfoodservice.module.order.dining.dto.response.DiningSessionMemberResponse;
import com.checkfood.checkfoodservice.module.order.dining.dto.response.DiningSessionResponse;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSession;
import com.checkfood.checkfoodservice.module.order.dining.entity.DiningSessionMember;
import com.checkfood.checkfoodservice.module.order.dining.exception.DiningSessionException;
import com.checkfood.checkfoodservice.module.order.dining.repository.DiningSessionMemberRepository;
import com.checkfood.checkfoodservice.module.order.dining.service.DiningSessionService;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderResponse;
import com.checkfood.checkfoodservice.module.order.service.OrderService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * REST kontroler pro správu skupinových sezení u stolu — připojování, dotazy, uzavírání sezení
 * a přehled plateb v rámci sezení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/v1/sessions")
@RequiredArgsConstructor
public class DiningSessionController {

    private final DiningSessionService diningSessionService;
    private final DiningSessionMemberRepository memberRepository;
    private final OrderService orderService;
    private final UserService userService;

    /**
     * Připojí přihlášeného uživatele k existujícímu aktivnímu sezení pomocí pozvánkového kódu.
     *
     * @param request        tělo požadavku s pozvánkovým kódem
     * @param authentication aktuální autentizace
     * @return detail sezení se seznamem členů
     */
    @PostMapping("/join")
    public ResponseEntity<DiningSessionResponse> joinSession(
            @Valid @RequestBody JoinSessionRequest request,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        DiningSession session = diningSessionService.joinSession(request.getInviteCode(), userId);
        return ResponseEntity.ok(toResponse(session));
    }

    /**
     * Vrátí aktivní sezení přihlášeného uživatele se seznamem členů.
     *
     * @param authentication aktuální autentizace
     * @return detail aktuálního sezení
     */
    @GetMapping("/me")
    public ResponseEntity<DiningSessionResponse> getMySession(Authentication authentication) {
        Long userId = extractUserId(authentication);
        DiningSession session = diningSessionService.findActiveSessionForUser(userId)
                .orElseThrow(DiningSessionException::noActiveSession);
        return ResponseEntity.ok(toResponse(session));
    }

    /**
     * Vrátí všechny objednávky v rámci sezení od všech jeho členů.
     *
     * @param id             UUID sezení
     * @param authentication aktuální autentizace
     * @return seznam objednávek sezení
     */
    @GetMapping("/{id}/orders")
    public ResponseEntity<List<OrderResponse>> getSessionOrders(
            @PathVariable UUID id,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        if (!memberRepository.existsBySessionIdAndUserId(id, userId)) {
            throw DiningSessionException.notMember(id);
        }
        List<OrderResponse> orders = orderService.getSessionOrders(id);
        return ResponseEntity.ok(orders);
    }

    /**
     * Vrátí pozvánkový kód sezení pro generování QR kódu.
     *
     * @param id             UUID sezení
     * @param authentication aktuální autentizace
     * @return mapa s klíčem {@code inviteCode}
     */
    @GetMapping("/{id}/qr")
    public ResponseEntity<Map<String, String>> getQrCode(
            @PathVariable UUID id,
            Authentication authentication) {
        extractUserId(authentication);
        DiningSession session = diningSessionService.findActiveSessionForUser(extractUserId(authentication))
                .filter(s -> s.getId().equals(id))
                .orElseGet(() -> diningSessionService.findActiveSessionForUser(extractUserId(authentication))
                        .orElseThrow(() -> DiningSessionException.notFound(id)));
        return ResponseEntity.ok(Map.of("inviteCode", session.getInviteCode()));
    }

    /**
     * Uzavře sezení. Operaci může provést pouze hostitel sezení.
     *
     * @param id             UUID sezení
     * @param authentication aktuální autentizace
     * @return HTTP 200 bez těla
     */
    @PostMapping("/{id}/close")
    public ResponseEntity<Void> closeSession(
            @PathVariable UUID id,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        diningSessionService.closeSession(id, userId);
        return ResponseEntity.ok().build();
    }

    /**
     * Vrátí platební souhrn sezení — kdo co zaplatil a kolik zbývá.
     *
     * @param id             UUID sezení
     * @param authentication aktuální autentizace
     * @return mapa s platebním souhrnem
     */
    @GetMapping("/{id}/payment-summary")
    public ResponseEntity<Map<String, Object>> getPaymentSummary(
            @PathVariable UUID id,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        if (!memberRepository.existsBySessionIdAndUserId(id, userId)) {
            throw DiningSessionException.notMember(id);
        }
        return ResponseEntity.ok(orderService.getSessionPaymentSummary(id));
    }

    /**
     * Sestaví response DTO pro sezení včetně obohacených informací o členech (jméno a příjmení).
     *
     * @param session entita sezení
     * @return response DTO sezení se členy
     */
    private DiningSessionResponse toResponse(DiningSession session) {
        List<DiningSessionMember> members = diningSessionService.getMembers(session.getId());
        List<DiningSessionMemberResponse> memberResponses = members.stream()
                .map(m -> {
                    String firstName = null;
                    String lastName = null;
                    try {
                        UserEntity user = userService.findById(m.getUserId());
                        firstName = user.getFirstName();
                        lastName = user.getLastName();
                    } catch (Exception ignored) {
                        // uživatel mohl být smazán
                    }
                    return DiningSessionMemberResponse.builder()
                            .userId(m.getUserId())
                            .firstName(firstName)
                            .lastName(lastName)
                            .joinedAt(m.getJoinedAt())
                            .build();
                })
                .toList();

        return DiningSessionResponse.builder()
                .id(session.getId())
                .restaurantId(session.getRestaurantId())
                .tableId(session.getTableId())
                .reservationId(session.getReservationId())
                .inviteCode(session.getInviteCode())
                .status(session.getStatus())
                .members(memberResponses)
                .createdAt(session.getCreatedAt())
                .createdByUserId(session.getCreatedByUserId())
                .build();
    }

    private Long extractUserId(Authentication authentication) {
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return user.getId();
    }
}
