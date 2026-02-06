package com.checkfood.checkfoodservice.application.controller.restaurant;

import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantTableUpdateRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantUpdateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.restaurant.RestaurantDetailResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.restaurant.RestaurantListResponseDto;
import com.checkfood.checkfoodservice.application.service.restaurant.RestaurantService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST controller pro práci s restauracemi.
 *
 * <br><br>
 * RestaurantController slouží výhradně jako HTTP adaptér
 * aplikační vrstvy.
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
 * - neřeší audit ani autorizaci.
 *
 * <br><br>
 * Cross-cutting připravenost:
 * <br>
 * - validation: @Valid (aktivní),
 * <br>
 * - security: připraveno pro @PreAuthorize (TODO),
 * <br>
 * - logging: řešeno globálně (filter / interceptor),
 * <br>
 * - exception handling: řešeno přes @ControllerAdvice.
 */
@RestController
@RequestMapping("/api/restaurants")
@RequiredArgsConstructor
public class RestaurantController {

    /**
     * Aplikační service pro práci s agregátem Restaurant.
     *
     * Controller komunikuje výhradně
     * přes rozhraní service vrstvy.
     */
    private final RestaurantService restaurantService;

    /**
     * Vytvoří novou restauraci.
     *
     * <br><br>
     * HTTP:
     * <br>
     * POST /api/restaurants
     *
     * <br><br>
     * Cross-cutting:
     * <br>
     * - validation: automaticky spuštěna (@Valid),
     * <br>
     * - security: TODO – omezení na administrátora,
     * <br>
     * - audit: řešeno v service vrstvě,
     * <br>
     * - transaction: řešeno v service vrstvě.
     *
     * @param request vstupní DTO pro vytvoření restaurace
     * @return detail nově vytvořené restaurace
     */
    @PostMapping
    public RestaurantDetailResponseDto createRestaurant(
            @Valid @RequestBody RestaurantCreateRequestDto request
    ) {
        // TODO security: omezení přístupu (ADMIN / OWNER)
        return restaurantService.createRestaurant(request);
    }

    /**
     * Aktualizuje základní údaje restaurace.
     *
     * <br><br>
     * HTTP:
     * <br>
     * PUT /api/restaurants/{restaurantId}
     *
     * <br><br>
     * Controller:
     * <br>
     * - neověřuje existenci restaurace,
     * <br>
     * - neřeší business pravidla aktualizace.
     *
     * @param restaurantId identifikátor restaurace
     * @param request aktualizační DTO
     * @return aktualizovaný detail restaurace
     */
    @PutMapping("/{restaurantId}")
    public RestaurantDetailResponseDto updateRestaurant(
            @PathVariable UUID restaurantId,
            @Valid @RequestBody RestaurantUpdateRequestDto request
    ) {
        // TODO security: kontrola oprávnění vlastníka restaurace
        return restaurantService.updateRestaurant(restaurantId, request);
    }

    /**
     * Aktualizuje konfiguraci stolů restaurace.
     *
     * <br><br>
     * Operace pracuje s agregátem Restaurant
     * jako celkem – jednotlivé stoly
     * nejsou spravovány samostatně.
     *
     * <br><br>
     * HTTP:
     * <br>
     * PUT /api/restaurants/{restaurantId}/tables
     *
     * <br><br>
     * Cross-cutting:
     * <br>
     * - validation: validace seznamu DTO,
     * <br>
     * - audit: řešeno v service vrstvě,
     * <br>
     * - transaction: řešeno v service vrstvě.
     *
     * @param restaurantId identifikátor restaurace
     * @param tables seznam konfigurací stolů
     */
    @PutMapping("/{restaurantId}/tables")
    public void updateRestaurantTables(
            @PathVariable UUID restaurantId,
            @Valid @RequestBody List<RestaurantTableUpdateRequestDto> tables
    ) {
        // TODO security: omezení přístupu (OWNER / STAFF)
        restaurantService.updateRestaurantTables(restaurantId, tables);
    }

    /**
     * Vrátí detail restaurace.
     *
     * <br><br>
     * HTTP:
     * <br>
     * GET /api/restaurants/{restaurantId}
     *
     * <br><br>
     * Používá se:
     * <br>
     * - pro veřejný náhled restaurace,
     * <br>
     * - pro administraci.
     *
     * @param restaurantId identifikátor restaurace
     * @return detail restaurace
     */
    @GetMapping("/{restaurantId}")
    public RestaurantDetailResponseDto getRestaurantDetail(
            @PathVariable UUID restaurantId
    ) {
        return restaurantService.getRestaurantDetail(restaurantId);
    }

    /**
     * Vrátí seznam restaurací.
     *
     * <br><br>
     * HTTP:
     * <br>
     * GET /api/restaurants
     *
     * <br><br>
     * Poznámka:
     * <br>
     * Filtrování (např. pouze aktivní restaurace)
     * může být v budoucnu řešeno:
     * <br>
     * - query parametry,
     * <br>
     * - dedikovaným endpointem,
     * <br>
     * - read modelem.
     *
     * @return seznam restaurací
     */
    @GetMapping
    public List<RestaurantListResponseDto> getRestaurants() {
        return restaurantService.getRestaurants();
    }
}
