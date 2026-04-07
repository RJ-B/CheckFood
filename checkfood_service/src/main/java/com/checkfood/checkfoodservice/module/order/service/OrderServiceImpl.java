package com.checkfood.checkfoodservice.module.order.service;

import com.checkfood.checkfoodservice.client.payment.MoonePaymentService;
import com.checkfood.checkfoodservice.module.order.dining.dto.response.DiningContextResponse;
import com.checkfood.checkfoodservice.module.order.dining.service.DiningContextService;
import com.checkfood.checkfoodservice.module.restaurant.menu.entity.MenuItem;
import com.checkfood.checkfoodservice.module.restaurant.menu.repository.MenuItemRepository;
import com.checkfood.checkfoodservice.module.order.dto.request.CreateOrderRequest;
import com.checkfood.checkfoodservice.module.order.dto.request.OrderItemRequest;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderItemResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderPaymentStatusResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderSummaryResponse;
import com.checkfood.checkfoodservice.module.order.entity.Order;
import com.checkfood.checkfoodservice.module.order.entity.OrderItem;
import com.checkfood.checkfoodservice.module.order.entity.OrderStatus;
import com.checkfood.checkfoodservice.module.order.entity.PaymentStatus;
import com.checkfood.checkfoodservice.module.order.exception.OrderException;
import com.checkfood.checkfoodservice.module.order.logging.OrderLogger;
import com.checkfood.checkfoodservice.module.order.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * Implementace {@link OrderService} zajišťující vytváření objednávek, validaci položek menu,
 * server-side výpočet cen a integraci s platební bránou Moone.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final MenuItemRepository menuItemRepository;
    private final DiningContextService diningContextService;
    private final OrderLogger orderLogger;
    private final MoonePaymentService moonePaymentService;

    @Override
    @Transactional
    public OrderResponse createOrder(CreateOrderRequest request, Long userId) {
        DiningContextResponse context = diningContextService.getActiveDiningContext(userId);

        List<UUID> menuItemIds = request.getItems().stream()
                .map(OrderItemRequest::getMenuItemId)
                .toList();

        List<MenuItem> menuItems = menuItemRepository.findAllByIdIn(menuItemIds);

        Map<UUID, MenuItem> menuItemMap = menuItems.stream()
                .collect(Collectors.toMap(MenuItem::getId, Function.identity()));

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

        Order order = Order.builder()
                .userId(userId)
                .restaurantId(context.getRestaurantId())
                .tableId(context.getTableId())
                .reservationId(context.getReservationId())
                .sessionId(context.getSessionId())
                .status(OrderStatus.CONFIRMED)
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

        Order savedOrder = orderRepository.save(order);

        orderLogger.logOrderCreated(savedOrder.getId(), userId,
                context.getRestaurantId(), totalPriceMinor);

        return toOrderResponse(savedOrder, context.getRestaurantName(), context.getTableLabel());
    }

    @Override
    @Transactional(readOnly = true)
    public OrderResponse getOrderDetail(UUID orderId, Long userId) {
        var order = orderRepository.findById(orderId)
                .orElseThrow(() -> OrderException.notFound(orderId));
        if (!order.getUserId().equals(userId)) {
            throw OrderException.notOwned(orderId);
        }
        return toOrderResponse(order, null, null);
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
                .paymentStatus(order.getPaymentStatus())
                .paymentTransactionId(order.getPaymentTransactionId())
                .paymentRedirectUrl(order.getPaymentRedirectUrl())
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

    @Override
    @Transactional
    public OrderResponse initiatePayment(UUID orderId, Long userId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> OrderException.notFound(orderId));

        if (!order.getUserId().equals(userId)) {
            throw OrderException.notOwned(orderId);
        }

        if (order.getPaymentStatus() == PaymentStatus.PAID) {
            throw OrderException.paymentNotAllowed(orderId, "objednávka je již zaplacena");
        }

        if (order.getPaymentStatus() == PaymentStatus.INITIATED
                || order.getPaymentStatus() == PaymentStatus.PROCESSING) {
                log.info("Platba pro objednávku {} již probíhá (status={}), vracím existující redirectUrl",
                    orderId, order.getPaymentStatus());
            return toOrderResponse(order, null, null);
        }

        MoonePaymentService.MooneTransactionResult result;
        try {
            result = moonePaymentService.initiateTransaction(order.getTotalPriceMinor(), order.getCurrency());
        } catch (Exception e) {
            log.error("Nelze iniciovat platbu u Moone pro objednávku {}: {}", orderId, e.getMessage());
            throw OrderException.paymentInitiationFailed(e.getMessage());
        }

        order.setPaymentStatus(PaymentStatus.INITIATED);
        order.setPaymentTransactionId(result.transactionId());
        order.setPaymentRedirectUrl(result.redirectUrl());
        orderRepository.save(order);

        log.info("Platba iniciována pro objednávku {}, transactionId={}", orderId, result.transactionId());
        return toOrderResponse(order, null, null);
    }

    @Override
    @Transactional(readOnly = true)
    public OrderPaymentStatusResponse getPaymentStatus(UUID orderId, Long userId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> OrderException.notFound(orderId));

        if (!order.getUserId().equals(userId)) {
            throw OrderException.notOwned(orderId);
        }

        return OrderPaymentStatusResponse.builder()
                .orderId(order.getId())
                .paymentStatus(order.getPaymentStatus())
                .paymentTransactionId(order.getPaymentTransactionId())
                .build();
    }

    @Override
    @Transactional
    public void handlePaymentCallback(Map<String, Object> payload) {
        log.info("Moone callback přijat: {}", payload);

        // Moone API callback formát není zdokumentován — parsujeme transactionId best-effort z více možných klíčů
        String transactionId = null;
        if (payload.containsKey("publicID")) {
            transactionId = String.valueOf(payload.get("publicID"));
        } else if (payload.containsKey("transactionId")) {
            transactionId = String.valueOf(payload.get("transactionId"));
        } else if (payload.containsKey("id")) {
            transactionId = String.valueOf(payload.get("id"));
        }

        if (transactionId == null) {
            log.warn("Moone callback neobsahuje transactionId, payload: {}", payload);
            return;
        }

        final String txId = transactionId;
        orderRepository.findByPaymentTransactionId(txId).ifPresentOrElse(order -> {
            PaymentStatus newStatus = moonePaymentService.getTransactionStatus(txId);
            order.setPaymentStatus(newStatus);
            orderRepository.save(order);
            log.info("Moone callback: objednávka {} aktualizována na paymentStatus={}", order.getId(), newStatus);
        }, () -> log.warn("Moone callback: objednávka pro transactionId={} nenalezena", txId));
    }

    @Override
    @Transactional(readOnly = true)
    public List<OrderResponse> getSessionOrders(UUID sessionId) {
        var orders = orderRepository.findAllBySessionIdAndStatusNot(sessionId, OrderStatus.CANCELLED);
        return orders.stream()
                .map(o -> toOrderResponse(o, null, null))
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> getSessionPaymentSummary(UUID sessionId) {
        var orders = orderRepository.findAllBySessionIdAndStatusNot(sessionId, OrderStatus.CANCELLED);
        int totalMinor = 0;
        int paidMinor = 0;
        var itemDetails = new java.util.ArrayList<Map<String, Object>>();

        for (var order : orders) {
            for (var item : order.getItems()) {
                int itemTotal = item.getUnitPriceMinor() * item.getQuantity();
                totalMinor += itemTotal;
                boolean isPaid = item.getItemPaymentStatus() == com.checkfood.checkfoodservice.module.order.entity.ItemPaymentStatus.PAID;
                if (isPaid) paidMinor += itemTotal;

                itemDetails.add(Map.of(
                        "id", item.getId().toString(),
                        "name", item.getItemName(),
                        "priceMinor", itemTotal,
                        "quantity", item.getQuantity(),
                        "status", item.getItemPaymentStatus().name(),
                        "orderedByUserId", item.getOrderedByUserId() != null ? item.getOrderedByUserId() : 0L,
                        "paidByUserId", item.getPaidByUserId() != null ? item.getPaidByUserId() : 0L
                ));
            }
        }

        return Map.of(
                "totalMinor", totalMinor,
                "paidMinor", paidMinor,
                "remainingMinor", totalMinor - paidMinor,
                "items", itemDetails
        );
    }
}
