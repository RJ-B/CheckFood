package com.checkfood.checkfoodservice.application.controller.order;

import com.checkfood.checkfoodservice.application.dto.request.order.OrderCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.order.OrderItemRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.order.OrderListResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.order.OrderResponseDto;
import com.checkfood.checkfoodservice.application.service.order.OrderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST controller pro správu objednávek.
 *
 * <br><br>
 * OrderController slouží jako HTTP adaptér
 * aplikační vrstvy pro agregát Order.
 *
 * <br><br>
 * Zodpovědnosti controlleru:
 * <br>
 * - mapování HTTP požadavků na aplikační service,
 * <br>
 * - spuštění validace vstupních DTO,
 * <br>
 * - vrácení response DTO klientovi.
 *
 * <br><br>
 * Controller:
 * <br>
 * - neobsahuje business logiku,
 * <br>
 * - nepracuje s entitami ani repository,
 * <br>
 * - neřídí transakce,
 * <br>
 * - neřeší platební ani rezervační procesy.
 *
 * <br><br>
 * Cross-cutting připravenost:
 * <br>
 * - validation: @Valid (aktivní),
 * <br>
 * - security: připraveno pro ochranu endpointů (TODO),
 * <br>
 * - audit: řešeno v service vrstvě,
 * <br>
 * - logging: řešeno globálně (filter / interceptor),
 * <br>
 * - exception handling: řešeno přes @ControllerAdvice.
 */
@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
public class OrderController {

    /**
     * Aplikační service pro práci s agregátem Order.
     *
     * Controller komunikuje výhradně
     * přes rozhraní service vrstvy.
     */
    private final OrderService orderService;

    /**
     * Vytvoří novou objednávku.
     *
     * <br><br>
     * HTTP:
     * <br>
     * POST /api/orders
     *
     * <br><br>
     * Objednávka může být vytvořena:
     * <br>
     * - na základě rezervace,
     * <br>
     * - jako okamžitá objednávka (např. takeaway).
     *
     * <br><br>
     * Controller:
     * <br>
     * - neověřuje stav rezervace,
     * <br>
     * - neřeší dostupnost položek,
     * <br>
     * - nepočítá cenu objednávky.
     *
     * @param request vstupní DTO pro vytvoření objednávky
     * @return detail nově vytvořené objednávky
     */
    @PostMapping
    public OrderResponseDto createOrder(
            @Valid @RequestBody OrderCreateRequestDto request
    ) {
        // TODO security: omezení přístupu (USER / STAFF / SYSTEM)
        return orderService.createOrder(request);
    }

    /**
     * Přidá položku do existující objednávky.
     *
     * <br><br>
     * HTTP:
     * <br>
     * POST /api/orders/{orderId}/items
     *
     * <br><br>
     * Operace pracuje s agregátem Order
     * jako celkem – položky nejsou
     * spravovány samostatně.
     *
     * <br><br>
     * Controller:
     * <br>
     * - neověřuje stav objednávky,
     * <br>
     * - neřeší cenové výpočty,
     * <br>
     * - neřeší dostupnost menu položek.
     *
     * @param orderId identifikátor objednávky
     * @param request DTO nové položky objednávky
     * @return aktualizovaný detail objednávky
     */
    @PostMapping("/{orderId}/items")
    public OrderResponseDto addOrderItem(
            @PathVariable UUID orderId,
            @Valid @RequestBody OrderItemRequestDto request
    ) {
        // TODO security: omezení přístupu (STAFF / SYSTEM)
        return orderService.addOrderItem(orderId, request);
    }

    /**
     * Odebere položku z objednávky.
     *
     * <br><br>
     * HTTP:
     * <br>
     * DELETE /api/orders/{orderId}/items/{itemId}
     *
     * <br><br>
     * Odebrání položky:
     * <br>
     * - je možné pouze v určitých stavech objednávky,
     * <br>
     * - podléhá business pravidlům.
     *
     * <br><br>
     * Veškerá pravidla jsou řešena
     * v servisní vrstvě.
     *
     * @param orderId identifikátor objednávky
     * @param itemId identifikátor položky objednávky
     * @return aktualizovaný detail objednávky
     */
    @DeleteMapping("/{orderId}/items/{itemId}")
    public OrderResponseDto removeOrderItem(
            @PathVariable UUID orderId,
            @PathVariable UUID itemId
    ) {
        // TODO security: omezení přístupu (STAFF / SYSTEM)
        return orderService.removeOrderItem(orderId, itemId);
    }

    /**
     * Vrátí detail objednávky.
     *
     * <br><br>
     * HTTP:
     * <br>
     * GET /api/orders/{orderId}
     *
     * <br><br>
     * Používá se:
     * <br>
     * - pro náhled objednávky zákazníkem,
     * <br>
     * - pro obsluhu restaurace,
     * <br>
     * - pro administrativní účely.
     *
     * @param orderId identifikátor objednávky
     * @return detail objednávky
     */
    @GetMapping("/{orderId}")
    public OrderResponseDto getOrderDetail(
            @PathVariable UUID orderId
    ) {
        // TODO security: kontrola oprávnění k zobrazení objednávky
        return orderService.getOrderDetail(orderId);
    }

    /**
     * Vrátí seznam objednávek.
     *
     * <br><br>
     * HTTP:
     * <br>
     * GET /api/orders
     *
     * <br><br>
     * Poznámka:
     * <br>
     * V budoucnu může být rozšířeno o:
     * <br>
     * - filtrování podle restaurace,
     * <br>
     * - filtrování podle stavu objednávky,
     * <br>
     * - filtrování podle data.
     *
     * @return seznam objednávek
     */
    @GetMapping
    public List<OrderListResponseDto> getOrders() {
        return orderService.getOrders();
    }
}
