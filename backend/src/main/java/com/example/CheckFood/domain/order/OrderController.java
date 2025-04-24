package com.example.CheckFood.domain.order;

import com.example.CheckFood.domain.order.dto.OrderDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    // Získat všechny objednávky
    @GetMapping
    public List<OrderDto> getAllOrders() {
        return orderService.getAllOrders();
    }

    // Získat objednávku podle ID
    @GetMapping("/{id}")
    public OrderDto getOrderById(@PathVariable Long id) {
        return orderService.getOrderById(id);
    }

    // Vytvořit novou objednávku
    @PostMapping
    public OrderDto createOrder(@RequestBody OrderDto orderDto) {
        return orderService.createOrder(orderDto);
    }

    // Aktualizovat objednávku podle ID
    @PutMapping("/{id}")
    public void updateOrder(@PathVariable Long id, @RequestBody OrderDto orderDto) {
        orderService.updateOrder(id, orderDto);
    }

    // Smazat objednávku podle ID
    @DeleteMapping("/{id}")
    public void deleteOrder(@PathVariable Long id) {
        orderService.deleteOrder(id);
    }
}
