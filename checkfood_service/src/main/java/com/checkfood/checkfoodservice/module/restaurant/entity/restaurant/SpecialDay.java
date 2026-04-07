package com.checkfood.checkfoodservice.module.restaurant.entity.restaurant;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * Výjimečný den — svátek, den volno, nebo upravená otevírací doba pro konkrétní datum.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Embeddable
public class SpecialDay {

    @Column(name = "date", nullable = false)
    private LocalDate date;

    @Column(name = "is_closed", nullable = false)
    private boolean closed;

    @Column(name = "open_at")
    private LocalTime openAt;

    @Column(name = "close_at")
    private LocalTime closeAt;

    @Column(name = "note", length = 200)
    private String note;
}
