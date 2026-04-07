package com.checkfood.checkfoodservice.module.reservation.dto.response;

import lombok.*;

import java.util.List;

/**
 * Response DTO s přehledem rezervací zákazníka.
 * Obsahuje nadcházející rezervace, omezený náhled do historie a celkový počet historických záznamů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MyReservationsOverviewResponse {
    private List<ReservationResponse> upcoming;
    private List<ReservationResponse> history;
    private long totalHistoryCount;
}
