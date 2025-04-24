package com.example.CheckFood.domain.order;

import com.example.CheckFood.domain.restaurant.Restaurant;
import com.example.CheckFood.domain.product.Product;
import com.example.CheckFood.domain.user.User;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data  // Lombok automaticky generuje gettery, settery, toString(), equals() a hashCode()
@NoArgsConstructor  // Lombok automaticky generuje prázdný konstruktor
@AllArgsConstructor // Lombok generuje konstruktor s parametry pro všechny atributy
@Builder  // Umožňuje použít Builder pattern pro vytváření objednávky
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime orderDate;  // Datum a čas objednávky

    private String status; // Stav objednávky (např. "nová", "zpracovávaná", "dokončená")

    @ManyToOne
    private User user; // Uživatel, který provedl objednávku

    @ManyToOne
    private Restaurant restaurant; // Restaurace, která objednávku zpracovává

    @ManyToMany
    private List<Product> products; // Produkty v objednávce

    private Double totalPrice; // Celková cena objednávky

    private Boolean paid; // Stav platby (zaplatil/neplatil)

    private String deliveryAddress; // Adresa pro doručení (pokud je relevantní)

    private String notes; // Poznámky k objednávce (např. speciální požadavky)
}
