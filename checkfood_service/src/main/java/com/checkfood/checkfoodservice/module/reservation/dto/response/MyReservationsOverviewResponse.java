package com.checkfood.checkfoodservice.module.reservation.dto.response;

import lombok.*;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MyReservationsOverviewResponse {
    private List<ReservationResponse> upcoming;
    private List<ReservationResponse> history;
    private long totalHistoryCount;
}
