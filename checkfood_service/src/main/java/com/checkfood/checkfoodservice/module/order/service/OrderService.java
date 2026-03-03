package com.checkfood.checkfoodservice.module.order.service;

import com.checkfood.checkfoodservice.module.order.dto.request.CreateOrderRequest;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderSummaryResponse;

import java.util.List;

public interface OrderService {

    OrderResponse createOrder(CreateOrderRequest request, Long userId);

    List<OrderSummaryResponse> getCurrentOrders(Long userId);
}
