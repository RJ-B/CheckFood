package com.example.CheckFood.domain.order;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    
    // Najít všechny objednávky pro konkrétního uživatele podle jeho ID
    List<Order> findByUserId(Long userId);

    // Najít objednávku podle jejího ID
    Optional<Order> findById(Long id);

    // Najít všechny objednávky podle stavu
    List<Order> findByStatus(String status);

    // Najít objednávky pro konkrétní restauraci
    List<Order> findByRestaurantId(Long restaurantId);

    // Najít objednávky, které mají status "zpracovávaná"
    List<Order> findByStatusAndPaid(String status, Boolean paid);

    // Najít všechny objednávky, které nebyly zaplaceny
    List<Order> findByPaidFalse();

    // Najít všechny objednávky, které byly zaplaceny
    List<Order> findByPaidTrue();

    // Seřadit objednávky podle data (od nejnovějších)
    List<Order> findByOrderDateOrderByOrderDateDesc();

    // Najít objednávky podle restaurace a stavu
    List<Order> findByRestaurantIdAndStatus(Long restaurantId, String status);
}
