package com.checkfood.checkfoodservice.module.dining.exception;

import com.checkfood.checkfoodservice.module.exception.AppException;
import org.springframework.http.HttpStatus;

/**
 * Výjimka pro chyby dining context poskytující factory metody pro typické scénáře chybějícího
 * nebo neodpovídajícího kontextu stravování.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class DiningContextException extends AppException {

    /**
     * Vytvoří novou výjimku dining context s daným chybovým kódem, zprávou a HTTP statusem.
     *
     * @param errorCode chybový kód z {@link DiningContextErrorCode}
     * @param message   lidsky čitelná chybová zpráva
     * @param status    HTTP status odpovědi
     */
    public DiningContextException(DiningContextErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Vytvoří výjimku pro případ, kdy uživatel nemá aktivní rezervaci ani sezení u stolu.
     *
     * @return výjimka s HTTP 404
     */
    public static DiningContextException noActiveContext() {
        return new DiningContextException(
                DiningContextErrorCode.NO_ACTIVE_CONTEXT,
                "Nemáte aktivní rezervaci ani sezení u stolu.",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * Vytvoří výjimku pro nesoulad objednávky s aktuálním sezením uživatele.
     *
     * @return výjimka s HTTP 409
     */
    public static DiningContextException contextMismatch() {
        return new DiningContextException(
                DiningContextErrorCode.CONTEXT_MISMATCH,
                "Objednávka neodpovídá vašemu aktuálnímu sezení.",
                HttpStatus.CONFLICT
        );
    }

    /**
     * Vytvoří výjimku pro systémovou chybu modulu dining context.
     *
     * @param message popis systémové chyby
     * @return výjimka s HTTP 500
     */
    public static DiningContextException systemError(String message) {
        return new DiningContextException(
                DiningContextErrorCode.DINING_SYSTEM_ERROR,
                "Interní chyba modulu sezení: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }
}
