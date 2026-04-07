package com.checkfood.checkfoodservice.module.order.repository;

import com.checkfood.checkfoodservice.module.order.entity.Order;
import com.checkfood.checkfoodservice.module.order.entity.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * JPA repozitář pro entitu {@link Order} poskytující dotazy pro vyhledávání objednávek
 * podle uživatele, rezervace, restaurace, sezení a transakce platební brány.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Repository
public interface OrderRepository extends JpaRepository<Order, UUID> {

        List<Order> findAllByUserIdAndReservationIdAndStatusNotOrderByCreatedAtDesc(
                        Long userId, UUID reservationId, OrderStatus excludeStatus);

        List<Order> findAllByUserIdAndRestaurantIdAndStatusNotOrderByCreatedAtDesc(
                        Long userId, UUID restaurantId, OrderStatus excludeStatus);

        List<Order> findAllByUserIdOrderByCreatedAtDesc(Long userId);

        Optional<Order> findByPaymentTransactionId(String paymentTransactionId);

        List<Order> findAllBySessionIdAndStatusNot(UUID sessionId, OrderStatus excludeStatus);
}
