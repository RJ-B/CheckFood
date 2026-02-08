package com.checkfood.checkfoodservice.application.entity.order;

public enum OrderType {
    TABLE_QR,     // objednávka přes QR u stolu
    WAITER,       // objednávka zadaná obsluhou
    TAKEAWAY,     // objednávka s sebou
    DELIVERY      // (do budoucna)
}

