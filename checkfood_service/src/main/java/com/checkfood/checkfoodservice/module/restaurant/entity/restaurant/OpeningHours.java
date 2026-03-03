package com.checkfood.checkfoodservice.module.restaurant.entity.restaurant;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.*;

import java.time.DayOfWeek;
import java.time.LocalTime;

/**
 * Value object reprezentující provozní dobu pro konkrétní den.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Embeddable
public class OpeningHours {

    @Enumerated(EnumType.STRING)
    @Column(name = "day_of_week", nullable = false, length = 20)
    private DayOfWeek dayOfWeek;

    @Column(name = "open_at")
    private LocalTime openAt;

    @Column(name = "close_at")
    private LocalTime closeAt;

    /**
     * Příznak, zda je v tento den restaurace úplně zavřená.
     */
    @Column(name = "is_closed", nullable = false)
    private boolean closed;
}