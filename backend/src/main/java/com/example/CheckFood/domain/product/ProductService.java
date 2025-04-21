package com.example.CheckFood.domain.product;

import java.util.List;

public interface ProductService {
    ProductDto createProduct(ProductDto dto);
    List<ProductDto> getAllProducts();
    ProductDto getProductById(Long id);
    void deleteProduct(Long id);
}
