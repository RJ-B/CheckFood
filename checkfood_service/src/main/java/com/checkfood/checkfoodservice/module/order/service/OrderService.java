package com.checkfood.checkfoodservice.module.order.service;

import com.checkfood.checkfoodservice.module.order.dto.request.CreateOrderRequest;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderPaymentStatusResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderResponse;
import com.checkfood.checkfoodservice.module.order.dto.response.OrderSummaryResponse;

import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Servisní rozhraní pro správu objednávek zákazníků, zahrnující vytváření, dotazy a zpracování plateb.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface OrderService {

    /**
     * Vytvoří novou objednávku na základě aktivního sezení uživatele a validovaných položek menu.
     *
     * @param request datový objekt se seznamem požadovaných položek a poznámkou
     * @param userId  ID přihlášeného zákazníka
     * @return detail nově vytvořené objednávky
     */
    OrderResponse createOrder(CreateOrderRequest request, Long userId);

    /**
     * Vrátí detail objednávky, pokud patří danému uživateli.
     *
     * @param orderId UUID objednávky
     * @param userId  ID přihlášeného zákazníka
     * @return detail objednávky
     */
    OrderResponse getOrderDetail(UUID orderId, Long userId);

    /**
     * Vrátí přehled aktivních objednávek uživatele v rámci jeho aktuálního sezení.
     *
     * @param userId ID přihlášeného zákazníka
     * @return seznam shrnutí objednávek
     */
    List<OrderSummaryResponse> getCurrentOrders(Long userId);

    /**
     * Zahájí platbu přes Moone pro danou objednávku a uloží přesměrovací URL.
     *
     * @param orderId UUID objednávky
     * @param userId  ID přihlášeného zákazníka
     * @return aktualizovaná objednávka s informacemi o platbě
     */
    OrderResponse initiatePayment(UUID orderId, Long userId);

    /**
     * Vrátí aktuální stav platby objednávky pro polling frontendem.
     *
     * @param orderId UUID objednávky
     * @param userId  ID přihlášeného zákazníka
     * @return stav platby a ID transakce
     */
    OrderPaymentStatusResponse getPaymentStatus(UUID orderId, Long userId);

    /**
     * Zpracuje callback od platební brány Moone a aktualizuje stav platby objednávky.
     *
     * @param payload mapa s daty callbacku od Moone
     */
    void handlePaymentCallback(Map<String, Object> payload);

    /**
     * Vrátí všechny objednávky v rámci daného sezení (od všech členů).
     *
     * @param sessionId UUID sezení
     * @return seznam objednávek
     */
    List<OrderResponse> getSessionOrders(UUID sessionId);

    /**
     * Vrátí platební souhrn sezení — celkovou, zaplacenou a zbývající částku s detailem položek.
     *
     * @param sessionId UUID sezení
     * @return mapa s platebním souhrnem
     */
    Map<String, Object> getSessionPaymentSummary(UUID sessionId);
}
