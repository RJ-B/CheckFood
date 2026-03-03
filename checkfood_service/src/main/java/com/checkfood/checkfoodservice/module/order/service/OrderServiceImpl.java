package com.checkfood.checkfoodservice.module.order.service;

import com.checkfood.checkfoodservice.module.dining.dto.response.DiningContextResponse;
import com.checkfood.checkfoodservice.module.dining.service.DiningContextService;
import com.checkfood.checkfoodservice.module.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.order.dto.request.CreateOrderRequest;
import com.checkfood.checkfoodservice.module.order.dto.request.OrderItemRequest;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderItemResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderSummaryResponse;
import com.checkfood.checkfoodservice.module.order.entity.Order;
import com.checkfood.checkfoodservice.module.order.entity.OrderItem;
import com.checkfood.checkfoodservice.module.order.entity.OrderStatus;
import com.checkfood.checkfoodservice.module.order.exception.OrderException;
import com.checkfood.checkfoodservice.module.order.logging.OrderLogger;
import com.checkfood.checkfoodservice.module.order.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final MenuItemRepository menuItemRepository;
    private final DiningContextService diningContextService;
    private final OrderLogger orderLogger;

    @Override
    @Transactional
    public OrderResponse createOrder(CreateOrderRequest request, Long userId) {
        // 1. Resolve dining context server-side
        DiningContextResponse context = diningContextService.getActiveDiningContext(userId);

        // 2. Fetch all requested menu items in batch
        List<UUID> menuItemIds = request.getItems().stream()
                .map(OrderItemRequest::getMenuItemId)
                .toList();

        List<MenuItem> menuItems = menuItemRepository.findAllByIdIn(menuItemIds);

        Map<UUID, MenuItem> menuItemMap = menuItems.stream()
                .collect(Collectors.toMap(MenuItem::getId, Function.identity()));

        // 3. Validate each requested item
        for (OrderItemRequest itemReq : request.getItems()) {
            MenuItem menuItem = menuItemMap.get(itemReq.getMenuItemId());

            if (menuItem == null) {
                throw OrderException.itemNotFound(itemReq.getMenuItemId());
            }

            if (!menuItem.isAvailable()) {
                orderLogger.logItemValidationFailed(menuItem.getId(), "unavailable");
                throw OrderException.itemUnavailable(menuItem.getName());
            }

            if (!menuItem.getRestaurantId().equals(context.getRestaurantId())) {
                orderLogger.logItemValidationFailed(menuItem.getId(), "wrong restaurant");
                throw OrderException.itemWrongRestaurant(menuItem.getId());
            }
        }

        // 4. Build Order entity with server-side price calculation
        Order order = Order.builder()
                .userId(userId)
                .restaurantId(context.getRestaurantId())
                .tableId(context.getTableId())
                .reservationId(context.getReservationId())
                .sessionId(context.getSessionId())
                .status(OrderStatus.PENDING)
                .currency("CZK")
                .note(request.getNote())
                .build();

        int totalPriceMinor = 0;

        for (OrderItemRequest itemReq : request.getItems()) {
            MenuItem menuItem = menuItemMap.get(itemReq.getMenuItemId());

            OrderItem orderItem = OrderItem.builder()
                    .menuItemId(menuItem.getId())
                    .itemName(menuItem.getName())
                    .unitPriceMinor(menuItem.getPriceMinor())
                    .quantity(itemReq.getQuantity())
                    .build();

            order.addItem(orderItem);
            totalPriceMinor += menuItem.getPriceMinor() * itemReq.getQuantity();
        }

        order.setTotalPriceMinor(totalPriceMinor);

        // 5. Save
        Order savedOrder = orderRepository.save(order);

        orderLogger.logOrderCreated(savedOrder.getId(), userId,
                context.getRestaurantId(), totalPriceMinor);

        // 6. Build response
        return toOrderResponse(savedOrder, context.getRestaurantName(), context.getTableLabel());
    }

    @Override
    @Transactional(readOnly = true)
    public List<OrderSummaryResponse> getCurrentOrders(Long userId) {
        return diningContextService.findActiveDiningContext(userId)
                .map(context -> {
                    List<Order> orders;
                    if (context.getReservationId() != null) {
                        orders = orderRepository
                                .findAllByUserIdAndReservationIdAndStatusNotOrderByCreatedAtDesc(
                                        userId, context.getReservationId(), OrderStatus.CANCELLED);
                    } else {
                        orders = orderRepository
                                .findAllByUserIdAndRestaurantIdAndStatusNotOrderByCreatedAtDesc(
                                        userId, context.getRestaurantId(), OrderStatus.CANCELLED);
                    }
                    return orders.stream().map(this::toSummaryResponse).toList();
                })
                .orElse(List.of());
    }

    private OrderResponse toOrderResponse(Order order, String restaurantName, String tableLabel) {
        List<OrderItemResponse> itemResponses = order.getItems().stream()
                .map(item -> OrderItemResponse.builder()
                        .id(item.getId())
                        .menuItemId(item.getMenuItemId())
                        .itemName(item.getItemName())
                        .unitPriceMinor(item.getUnitPriceMinor())
                        .quantity(item.getQuantity())
                        .totalPriceMinor(item.getUnitPriceMinor() * item.getQuantity())
                        .build())
                .toList();

        return OrderResponse.builder()
                .id(order.getId())
                .restaurantId(order.getRestaurantId())
                .tableId(order.getTableId())
                .restaurantName(restaurantName)
                .tableLabel(tableLabel)
                .status(order.getStatus())
                .totalPriceMinor(order.getTotalPriceMinor())
                .currency(order.getCurrency())
                .note(order.getNote())
                .createdAt(order.getCreatedAt())
                .items(itemResponses)
                .build();
    }

    private OrderSummaryResponse toSummaryResponse(Order order) {
        return OrderSummaryResponse.builder()
                .id(order.getId())
                .status(order.getStatus())
                .totalPriceMinor(order.getTotalPriceMinor())
                .currency(order.getCurrency())
                .itemCount(order.getItems().size())
                .createdAt(order.getCreatedAt())
                .build();
    }
}
