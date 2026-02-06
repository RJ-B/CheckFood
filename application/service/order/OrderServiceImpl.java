package com.checkfood.checkfoodservice.application.service.order;

import com.checkfood.checkfoodservice.application.dto.request.order.OrderCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.order.OrderItemRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.order.OrderListResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.order.OrderResponseDto;
import com.checkfood.checkfoodservice.application.entity.order.Order;
import com.checkfood.checkfoodservice.application.entity.order.OrderItem;
import com.checkfood.checkfoodservice.application.entity.order.OrderStatus;
import com.checkfood.checkfoodservice.application.mapper.order.OrderItemMapper;
import com.checkfood.checkfoodservice.application.mapper.order.OrderMapper;
import com.checkfood.checkfoodservice.application.repository.order.OrderRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

/**
 * Implementace aplikační service
 * pro agregát Order.
 *
 * <br><br>
 * Třída definuje transakční hranici
 * a řídí životní cyklus objednávky
 * a jejích položek.
 */
@Service
@RequiredArgsConstructor
@Transactional
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;

    @Override
    public OrderResponseDto createOrder(OrderCreateRequestDto request) {

        // TODO validation: existence restaurace / rezervace / stolů
        // TODO security: oprávnění vytvořit objednávku

        Order order = orderMapper.toEntity(request);
        order.setStatus(OrderStatus.CREATED);

        Order saved = orderRepository.save(order);

        // TODO audit: vytvoření objednávky
        // TODO event: OrderCreatedEvent

        return orderMapper.toResponse(saved);
    }

    @Override
    public OrderResponseDto addOrderItem(
            UUID orderId,
            OrderItemRequestDto request
    ) {
        Order order = getOrderOrThrow(orderId);

        OrderItem item = orderItemMapper.toEntity(request, order.getId());
        order.getItems().add(item);

        // TODO business rule: nelze měnit uzavřenou objednávku
        // TODO audit: přidání položky

        return orderMapper.toResponse(order);
    }

    @Override
    public OrderResponseDto removeOrderItem(
            UUID orderId,
            UUID orderItemId
    ) {
        Order order = getOrderOrThrow(orderId);

        order.getItems().removeIf(i -> i.getId().equals(orderItemId));

        // TODO audit: odebrání položky

        return orderMapper.toResponse(order);
    }

    @Override
    public void changeOrderStatus(UUID orderId, String status) {
        Order order = getOrderOrThrow(orderId);

        OrderStatus newStatus = OrderStatus.valueOf(status);
        order.setStatus(newStatus);

        // TODO business rule: povolené přechody stavů
        // TODO audit: změna stavu
        // TODO event: OrderStatusChangedEvent
    }

    @Override
    @Transactional(Transactional.TxType.SUPPORTS)
    public OrderResponseDto getOrderDetail(UUID orderId) {
        return orderMapper.toResponse(getOrderOrThrow(orderId));
    }

    @Override
    @Transactional(Transactional.TxType.SUPPORTS)
    public List<OrderListResponseDto> getOrders() {
        return orderMapper.toListResponse(orderRepository.findAll());
    }

    private Order getOrderOrThrow(UUID orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() ->
                        new IllegalArgumentException("Order not found: " + orderId)
                );
    }
}
