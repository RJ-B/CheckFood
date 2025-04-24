package com.example.CheckFood.domain.order;

import com.example.CheckFood.domain.order.dto.OrderDto;

import java.util.List;

public interface OrderService {

    // Metody pro práci s objednávkami
    List<OrderDto> getAllOrders();
    OrderDto getOrderById(Long id);
    OrderDto createOrder(OrderDto orderDto);
    void updateOrder(Long id, OrderDto orderDto);
    void deleteOrder(Long id);
}
