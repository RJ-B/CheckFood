package com.checkfood.checkfoodservice.module.owner.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Globální handler pro výjimky vzniklé v procesu přiřazení restaurace majiteli.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestControllerAdvice
@RequiredArgsConstructor
@Slf4j
public class OwnerClaimExceptionHandler {

    private final ErrorResponseBuilder errorResponseBuilder;

    /**
     * Zpracuje {@link OwnerClaimException} a vrátí standardizovanou chybovou odpověď s příslušným HTTP statusem.
     *
     * @param ex zachycená výjimka procesu přiřazení
     * @return odpověď s chybovým kódem a HTTP statusem
     */
    @ExceptionHandler(OwnerClaimException.class)
    public ResponseEntity<ErrorResponse> handleOwnerClaimException(OwnerClaimException ex) {
        var code = ex.getErrorCode();
        log.warn("Owner claim error: {} - {}", code, ex.getMessage());

        ErrorResponse response = errorResponseBuilder.build(
                code,
                ex.getMessage(),
                code.getStatus()
        );

        return new ResponseEntity<>(response, code.getStatus());
    }
}
