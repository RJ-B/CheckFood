package com.checkfood.checkfoodservice.module.restaurant.dto.common;

import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * DTO pro přenos informací o výjimečném dni (svátku nebo upravené otevírací době).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SpecialDayDto {
    @NotNull
    private LocalDate date;
    private boolean closed;
    private LocalTime openAt;
    private LocalTime closeAt;
    private String note;
}
