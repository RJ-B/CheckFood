package com.example.CheckFood.domain.order;

import com.example.CheckFood.domain.order.dto.OrderDto;
import com.example.CheckFood.domain.user.User;
import com.example.CheckFood.domain.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.CheckFood.domain.product.Product;  // Importujeme Product třídu


import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private OrderMapper orderMapper;  // Autowire Mapper

    @Override
    public List<OrderDto> getAllOrders() {
        List<Order> orders = orderRepository.findAll();
        return orders.stream()
                .map(orderMapper::toDto)  // Používáme mapper pro převod
                .collect(Collectors.toList());
    }

    @Override
    public OrderDto getOrderById(Long id) {
        Order order = orderRepository.findById(id).orElseThrow(() -> new RuntimeException("Order not found"));
        return orderMapper.toDto(order);  // Používáme mapper pro převod
    }

    @Override
    public OrderDto createOrder(OrderDto orderDto) {
        User user = userRepository.findById(orderDto.getUserId()).orElseThrow(() -> new RuntimeException("User not found"));
        Order order = orderMapper.toEntity(orderDto);  // Používáme mapper pro převod z DTO na entitu
        order.setUser(user);  
        order.setOrderDate(LocalDateTime.now());  
        order.setTotalPrice(calculateTotalPrice(order.getProducts()));

        order = orderRepository.save(order);
        return orderMapper.toDto(order);  // Používáme mapper pro převod zpět na DTO
    }

    @Override
    public void updateOrder(Long id, OrderDto orderDto) {
        Order order = orderRepository.findById(id).orElseThrow(() -> new RuntimeException("Order not found"));
        order.setStatus(orderDto.getStatus());
        order.setPaid(orderDto.getPaid());
        order.setNotes(orderDto.getNotes());
        orderRepository.save(order);
    }

    @Override
    public void deleteOrder(Long id) {
        Order order = orderRepository.findById(id).orElseThrow(() -> new RuntimeException("Order not found"));
        orderRepository.delete(order);
    }

    // Pomocná metoda pro výpočet ceny objednávky
    private Double calculateTotalPrice(List<Product> products) {
        return products.stream()
                .mapToDouble(Product::getPrice)
                .sum();
    }
}
