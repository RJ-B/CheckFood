package com.example.CheckFood.domain.reservation;

import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReservationDto {

    @NotNull(message = "Datum je povinné")
    @Future(message = "Rezervace musí být v budoucnosti")
    private LocalDate date;

    @NotNull(message = "Čas je povinný")
    private LocalTime time;

    @NotNull(message = "Číslo stolu je povinné")
    private Integer tableNumber;

    private String note;

    @NotNull(message = "ID uživatele je povinné")
    private Long userId;

    @NotNull(message = "ID restaurace je povinné")
    private Long restaurantId;
}
