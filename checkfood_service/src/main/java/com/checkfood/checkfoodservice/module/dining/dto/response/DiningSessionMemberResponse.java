package com.checkfood.checkfoodservice.module.dining.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Response DTO reprezentující jednoho člena skupinového sezení u stolu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DiningSessionMemberResponse {

    private Long userId;
    private String firstName;
    private String lastName;
    private LocalDateTime joinedAt;
}
