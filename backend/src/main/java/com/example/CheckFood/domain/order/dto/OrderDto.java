package com.example.CheckFood.domain.order.dto;

import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Data  // Lombok automaticky generuje gettery, settery, toString(), equals() a hashCode
@NoArgsConstructor  // Lombok generuje prázdný konstruktor
@AllArgsConstructor  // Lombok generuje konstruktor s parametry pro všechny atributy
@Builder  // Lombok generuje Builder pattern pro pohodlné vytváření objektů
public class OrderDto {

    private Long id;
    private LocalDateTime orderDate;  // Datum a čas objednávky
    private String status;  // Stav objednávky
    private Long userId;  // ID uživatele, který provedl objednávku
    private Long restaurantId;  // ID restaurace
    private List<Long> productIds;  // Seznam ID produktů v objednávce
    private Double totalPrice;  // Celková cena objednávky
    private Boolean paid;  // Stav platby (true = zaplaceno, false = nezaplaceno)
    private String deliveryAddress;  // Adresa pro doručení
    private String notes;  // Poznámky k objednávce
}
