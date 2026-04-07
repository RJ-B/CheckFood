package com.checkfood.checkfoodservice.module.reservation.dto.response;

import lombok.*;

import java.util.UUID;

/**
 * Response DTO se základními daty stolu restaurace pro personál.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class StaffTableResponse {
    private UUID id;
    private String label;
    private int capacity;
    private boolean active;
}
