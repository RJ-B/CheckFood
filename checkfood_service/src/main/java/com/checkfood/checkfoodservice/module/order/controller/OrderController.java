package com.checkfood.checkfoodservice.module.order.controller;

import com.checkfood.checkfoodservice.module.order.dto.request.CreateOrderRequest;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderPaymentStatusResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderSummaryResponse;
import com.checkfood.checkfoodservice.module.order.service.OrderService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * REST kontroler pro správu objednávek zákazníků a zpracování plateb přes platební bránu Moone.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    /**
     * Vytvoří novou objednávku pro přihlášeného zákazníka na základě jeho aktivního sezení u stolu.
     *
     * @param request        tělo požadavku s položkami objednávky
     * @param authentication aktuální autentizace
     * @return vytvořená objednávka s HTTP 201
     */
    @PostMapping("/api/v1/orders")
    public ResponseEntity<OrderResponse> createOrder(
            @Valid @RequestBody CreateOrderRequest request,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        OrderResponse response = orderService.createOrder(request, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    /**
     * Vrátí seznam aktivních objednávek přihlášeného zákazníka v rámci jeho aktuálního sezení.
     *
     * @param authentication aktuální autentizace
     * @return seznam shrnutí objednávek
     */
    @GetMapping("/api/v1/orders/me/current")
    public ResponseEntity<List<OrderSummaryResponse>> getCurrentOrders(
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(orderService.getCurrentOrders(userId));
    }

    /**
     * Vrátí detail konkrétní objednávky, pokud patří přihlášenému zákazníkovi.
     *
     * @param orderId        UUID požadované objednávky
     * @param authentication aktuální autentizace
     * @return detail objednávky
     */
    @GetMapping("/api/v1/orders/{orderId}")
    public ResponseEntity<OrderResponse> getOrderDetail(
            @PathVariable UUID orderId,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        OrderResponse response = orderService.getOrderDetail(orderId, userId);
        return ResponseEntity.ok(response);
    }

    /**
     * Zahájí platbu přes Moone pro danou objednávku a vrátí přesměrovací URL na platební bránu.
     *
     * @param orderId        UUID objednávky, která má být zaplacena
     * @param authentication aktuální autentizace
     * @return aktualizovaná objednávka s URL pro přesměrování na platební bránu
     */
    @PostMapping("/api/v1/orders/{orderId}/pay")
    public ResponseEntity<OrderResponse> initiatePayment(
            @PathVariable UUID orderId,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        OrderResponse response = orderService.initiatePayment(orderId, userId);
        return ResponseEntity.ok(response);
    }

    /**
     * Vrátí aktuální stav platby objednávky pro polling frontendem.
     *
     * @param orderId        UUID objednávky
     * @param authentication aktuální autentizace
     * @return stav platby a ID transakce
     */
    @GetMapping("/api/v1/orders/{orderId}/payment-status")
    public ResponseEntity<OrderPaymentStatusResponse> getPaymentStatus(
            @PathVariable UUID orderId,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(orderService.getPaymentStatus(orderId, userId));
    }

    /**
     * Veřejný callback endpoint volaný platební bránou Moone po zpracování transakce.
     * Nevyžaduje JWT autentizaci, protože Moone nemůže posílat naše tokeny.
     *
     * @param payload tělo callbacku od Moone
     * @return HTTP 200 bez těla
     */
    @PostMapping("/api/v1/payments/callback")
    public ResponseEntity<Void> paymentCallback(@RequestBody Map<String, Object> payload) {
        orderService.handlePaymentCallback(payload);
        return ResponseEntity.ok().build();
    }

    private Long extractUserId(Authentication authentication) {
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return user.getId();
    }
}
