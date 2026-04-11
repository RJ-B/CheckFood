package com.checkfood.checkfoodservice.module.reservation.dto.request;

import jakarta.validation.constraints.AssertTrue;
import lombok.*;

import java.time.LocalTime;
import java.util.UUID;

/**
 * Request DTO pro návrh změny rezervace iniciovaný personálem restaurace.
 * Alespoň jedno pole ({@code startTime} nebo {@code tableId}) musí být vyplněno.
 *
 * <p>Validace "at least one field" je implementována jako {@code @AssertTrue}
 * na {@link #isHasAnyChange()}. Tenhle JSR-380 hook běží v rámci standardního
 * {@code @Valid} pipeline, takže selhání produkuje
 * {@code MethodArgumentNotValidException} → HTTP 400, které umí
 * existující {@code SecurityExceptionHandler.handleValidation} mapovat.
 * Tím se vyhneme dřívějšímu {@code ResponseStatusException} hodu ze service
 * layer, který {@code ReservationExceptionHandler} neznal a nechával ho
 * propadnout jako HTTP 500.</p>
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProposeChangeRequest {
    private LocalTime startTime;
    private UUID tableId;

    /**
     * Class-level constraint: at least one of {@code startTime} or
     * {@code tableId} must be supplied. Named {@code isHasAnyChange} so
     * the error message produced by {@code MethodArgumentNotValidException}
     * stays readable ({@code "hasAnyChange: At least one field …"}).
     */
    @AssertTrue(message = "At least one of 'startTime' or 'tableId' must be provided")
    public boolean isHasAnyChange() {
        return startTime != null || tableId != null;
    }
}
