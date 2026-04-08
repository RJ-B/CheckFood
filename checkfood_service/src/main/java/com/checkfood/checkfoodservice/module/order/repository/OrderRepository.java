package com.checkfood.checkfoodservice.module.order.repository;

import com.checkfood.checkfoodservice.module.order.entity.Order;
import com.checkfood.checkfoodservice.module.order.entity.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
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

        /**
         * Smaže všechny objednávky daného uživatele (GDPR mazání účtu).
         *
         * @param userId ID uživatele
         */
        void deleteAllByUserId(Long userId);

        /**
         * Anonymizuje objednávky uživatele — nastaví userId na 0 (zachová data pro statistiky).
         */
        @Modifying
        @Query("UPDATE Order o SET o.userId = 0 WHERE o.userId = :userId")
        void anonymizeByUserId(@Param("userId") Long userId);

        /**
         * Smaže všechny objednávky v dané restauraci (mazání restaurace vlastníka).
         *
         * @param restaurantId UUID restaurace
         */
        void deleteAllByRestaurantId(UUID restaurantId);
}
