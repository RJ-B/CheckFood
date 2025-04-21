package com.example.CheckFood.domain.product;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import com.example.CheckFood.domain.restaurant.Restaurant;
import com.example.CheckFood.domain.restaurant.RestaurantRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;
    private final RestaurantRepository restaurantRepository;

    @Override
    public ProductDto createProduct(ProductDto dto) {
        Restaurant restaurant = restaurantRepository.findById(dto.getRestaurantId())
                .orElseThrow(() -> new RuntimeException("Restaurace nenalezena"));

        Product product = ProductMapper.toEntity(dto, restaurant);
        Product saved = productRepository.save(product);
        return ProductMapper.toDto(saved);
    }

    @Override
    public List<ProductDto> getAllProducts() {
        return productRepository.findAll()
                .stream()
                .map(ProductMapper::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public ProductDto getProductById(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Produkt nenalezen"));
        return ProductMapper.toDto(product);
    }

    @Override
    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }
}
