package com.example.CheckFood.domain.restaurant;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RestaurantServiceImpl implements RestaurantService {

    private final RestaurantRepository restaurantRepository;

    @Override
    public RestaurantDto createRestaurant(RestaurantDto dto) {
        if (restaurantRepository.existsByEmail(dto.getEmail())) {
            throw new RuntimeException("Email restaurace už existuje");
        }

        Restaurant restaurant = RestaurantMapper.toEntity(dto);
        Restaurant saved = restaurantRepository.save(restaurant);
        return RestaurantMapper.toDto(saved);
    }

    @Override
    public List<RestaurantDto> getAllRestaurants() {
        return restaurantRepository.findAll()
                .stream()
                .map(RestaurantMapper::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public RestaurantDto getRestaurantById(Long id) {
        Restaurant restaurant = restaurantRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Restaurace nenalezena"));
        return RestaurantMapper.toDto(restaurant);
    }

    @Override
    public void deleteRestaurant(Long id) {
        restaurantRepository.deleteById(id);
    }
}
