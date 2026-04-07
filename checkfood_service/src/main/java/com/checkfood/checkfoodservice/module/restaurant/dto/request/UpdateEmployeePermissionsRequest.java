package com.checkfood.checkfoodservice.module.restaurant.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.Set;

/**
 * Požadavek na aktualizaci granulárních oprávnění zaměstnance.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UpdateEmployeePermissionsRequest {
    @NotNull
    private Set<String> permissions;
}
