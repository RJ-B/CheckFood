package com.checkfood.checkfoodservice.module.restaurant.dto.common;

import java.time.DayOfWeek;
import java.time.LocalTime;
import lombok.*;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OpeningHoursDto {
    private DayOfWeek dayOfWeek;
    private LocalTime openAt;
    private LocalTime closeAt;
    private boolean closed;
}