package com.checkfood.checkfoodservice.application.service.order;

import com.checkfood.checkfoodservice.application.dto.request.order.OrderCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.order.OrderItemRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.order.OrderListResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.order.OrderResponseDto;

import java.util.List;
import java.util.UUID;

/**
 * Aplikační service pro práci s agregátem Order.
 *
 * <br><br>
 * Order reprezentuje objednávku v restauraci
 * a obsahuje jednu nebo více položek.
 *
 * <br><br>
 * Service zodpovídá za:
 * <br>
 * - vytvoření objednávky,
 * <br>
 * - správu položek objednávky,
 * <br>
 * - změnu stavu objednávky,
 * <br>
 * - čtení objednávek.
 */
public interface OrderService {

    /**
     * Vytvoří novou objednávku.
     *
     * @param request vstupní data objednávky
     * @return detail objednávky
     */
    OrderResponseDto createOrder(OrderCreateRequestDto request);

    /**
     * Přidá položku do objednávky.
     *
     * @param orderId identifikátor objednávky
     * @param request položka objednávky
     * @return aktualizovaný detail objednávky
     */
    OrderResponseDto addOrderItem(
            UUID orderId,
            OrderItemRequestDto request
    );

    /**
     * Odebere položku z objednávky.
     *
     * @param orderId identifikátor objednávky
     * @param orderItemId identifikátor položky
     * @return aktualizovaný detail objednávky
     */
    OrderResponseDto removeOrderItem(
            UUID orderId,
            UUID orderItemId
    );

    /**
     * Změní stav objednávky.
     *
     * @param orderId identifikátor objednávky
     * @param status nový stav
     */
    void changeOrderStatus(UUID orderId, String status);

    /**
     * Vrátí detail objednávky.
     *
     * @param orderId identifikátor objednávky
     * @return detail objednávky
     */
    OrderResponseDto getOrderDetail(UUID orderId);

    /**
     * Vrátí seznam objednávek.
     *
     * @return seznam objednávek
     */
    List<OrderListResponseDto> getOrders();
}
