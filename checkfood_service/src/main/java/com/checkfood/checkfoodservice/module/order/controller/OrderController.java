package com.checkfood.checkfoodservice.module.order.controller;

import com.checkfood.checkfoodservice.module.order.dto.request.CreateOrderRequest;
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

@RestController
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    @PostMapping("/api/v1/orders")
    public ResponseEntity<OrderResponse> createOrder(
            @Valid @RequestBody CreateOrderRequest request,
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        OrderResponse response = orderService.createOrder(request, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @GetMapping("/api/v1/orders/me/current")
    public ResponseEntity<List<OrderSummaryResponse>> getCurrentOrders(
            Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(orderService.getCurrentOrders(userId));
    }

    private Long extractUserId(Authentication authentication) {
        UserEntity user = (UserEntity) authentication.getPrincipal();
        return user.getId();
    }
}
