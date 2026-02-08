package com.checkfood.checkfoodservice.application.service.restaurant;

import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantTableUpdateRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.restaurant.RestaurantUpdateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.restaurant.RestaurantDetailResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.restaurant.RestaurantListResponseDto;
import com.checkfood.checkfoodservice.application.entity.restaurant.Restaurant;
import com.checkfood.checkfoodservice.application.entity.restaurant.RestaurantStatus;
import com.checkfood.checkfoodservice.application.entity.restaurant.table.RestaurantTable;
import com.checkfood.checkfoodservice.application.mapper.restaurant.RestaurantMapper;
import com.checkfood.checkfoodservice.application.mapper.restaurant.RestaurantTableMapper;
import com.checkfood.checkfoodservice.application.repository.restaurant.RestaurantRepository;
import com.checkfood.checkfoodservice.application.repository.restaurant.RestaurantTableRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

/**
 * Implementace aplikační service pro agregát Restaurant.
 *
 * <br><br>
 * Třída představuje transakční hranici
 * pro veškeré operace nad restaurací
 * a jejími vnitřními entitami.
 *
 * <br><br>
 * Cross-cutting připravenost:
 * <br>
 * - transakce,
 * <br>
 * - auditní záznamy,
 * <br>
 * - bezpečnostní kontroly,
 * <br>
 * - doménové události.
 */
@Service
@RequiredArgsConstructor
@Transactional
public class RestaurantServiceImpl implements RestaurantService {

    private final RestaurantRepository restaurantRepository;
    private final RestaurantTableRepository restaurantTableRepository;
    private final RestaurantMapper restaurantMapper;
    private final RestaurantTableMapper restaurantTableMapper;

    @Override
    public RestaurantDetailResponseDto createRestaurant(RestaurantCreateRequestDto request) {

        Restaurant restaurant = restaurantMapper.toEntity(request);

        restaurant.setStatus(RestaurantStatus.ACTIVE);
        restaurant.setActive(true);

        // TODO security: ověření oprávnění vytvořit restauraci
        // TODO audit: zaznamenat vytvoření restaurace
        // TODO event: publikovat RestaurantCreatedEvent

        Restaurant saved = restaurantRepository.save(restaurant);
        return restaurantMapper.toDetailResponse(saved);
    }

    @Override
    public RestaurantDetailResponseDto updateRestaurant(
            UUID restaurantId,
            RestaurantUpdateRequestDto request
    ) {
        Restaurant restaurant = getRestaurantOrThrow(restaurantId);

        restaurantMapper.updateEntity(restaurant, request);

        // TODO audit: zaznamenat změnu údajů restaurace
        // TODO event: publikovat RestaurantUpdatedEvent

        return restaurantMapper.toDetailResponse(restaurant);
    }

    @Override
    public void changeRestaurantActiveState(UUID restaurantId, boolean active) {
        Restaurant restaurant = getRestaurantOrThrow(restaurantId);

        restaurant.setActive(active);

        // TODO business rule: deaktivace může ovlivnit rezervace
        // TODO audit: změna aktivního stavu
        // TODO event: RestaurantDeactivatedEvent / ActivatedEvent
    }

    @Override
    public void updateRestaurantTables(
            UUID restaurantId,
            List<RestaurantTableUpdateRequestDto> tables
    ) {
        // 1. Ověření existence restaurace
        getRestaurantOrThrow(restaurantId);

        // 2. Přemapování DTO → entity
        List<RestaurantTable> updatedTables =
                restaurantTableMapper.toEntities(tables, restaurantId);

        // 3. Smazání starých stolů (explicitně)
        restaurantTableRepository.deleteByRestaurantId(restaurantId);

        // 4. Uložení nových stolů
        restaurantTableRepository.saveAll(updatedTables);

        // TODO validation: duplicitní labely
        // TODO audit: změna konfigurace stolů
        // TODO event: RestaurantTablesUpdatedEvent
    }

    @Override
    @Transactional(Transactional.TxType.SUPPORTS)
    public RestaurantDetailResponseDto getRestaurantDetail(UUID restaurantId) {
        return restaurantMapper.toDetailResponse(getRestaurantOrThrow(restaurantId));
    }

    @Override
    @Transactional(Transactional.TxType.SUPPORTS)
    public List<RestaurantListResponseDto> getRestaurants() {
        return restaurantMapper.toListResponse(restaurantRepository.findAll());
    }

    private Restaurant getRestaurantOrThrow(UUID restaurantId) {
        return restaurantRepository.findById(restaurantId)
                .orElseThrow(() ->
                        new IllegalArgumentException("Restaurant not found: " + restaurantId)
                );
    }
}
