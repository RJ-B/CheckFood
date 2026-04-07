package com.checkfood.checkfoodservice.module.restaurant.dto.response;

import lombok.*;

import java.util.Set;

/**
 * Odpověď obsahující aktuální efektivní oprávnění zaměstnance.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmployeePermissionsResponse {
    private Set<String> permissions;
}
