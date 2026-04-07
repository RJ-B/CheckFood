package com.checkfood.checkfoodservice.module.panorama.exception;

import com.checkfood.checkfoodservice.infrastructure.exception.AppException;
import org.springframework.http.HttpStatus;

import java.util.UUID;

/**
 * Výjimka pro chyby vzniklé v panoramatickém modulu.
 * Poskytuje statické factory metody pro typické chybové scénáře.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class PanoramaException extends AppException {

    /**
     * Vytvoří výjimku s daným chybovým kódem, zprávou a HTTP statusem.
     *
     * @param errorCode chybový kód panoramatického modulu
     * @param message   popis chyby
     * @param status    HTTP status odpovědi
     */
    public PanoramaException(PanoramaErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * @param id identifikátor nenalezené session
     * @return výjimka pro případ, kdy panoramatická session nebyla nalezena
     */
    public static PanoramaException sessionNotFound(UUID id) {
        return new PanoramaException(
                PanoramaErrorCode.SESSION_NOT_FOUND,
                "Panorama session s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    /**
     * @param message popis neplatného stavu session
     * @return výjimka pro případ neplatného stavu panoramatické session
     */
    public static PanoramaException invalidState(String message) {
        return new PanoramaException(
                PanoramaErrorCode.INVALID_SESSION_STATE,
                message,
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * @param message popis systémové chyby
     * @return výjimka pro interní systémovou chybu panoramatického modulu
     */
    public static PanoramaException systemError(String message) {
        return new PanoramaException(
                PanoramaErrorCode.PANORAMA_SYSTEM_ERROR,
                "Interní chyba modulu panorama: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    /**
     * @param message popis důvodu selhání stitchingu
     * @return výjimka pro případ selhání procesu panoramatického stitchingu
     */
    public static PanoramaException stitchingFailed(String message) {
        return new PanoramaException(
                PanoramaErrorCode.STITCHING_FAILED,
                "Stitching selhal: " + message,
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    /**
     * @param message popis důvodu nedostupnosti stitcher služby
     * @return výjimka pro případ nedostupnosti stitcher mikroslužby
     */
    public static PanoramaException stitcherUnavailable(String message) {
        return new PanoramaException(
                PanoramaErrorCode.STITCHER_UNAVAILABLE,
                "Stitching služba není dostupná: " + message,
                HttpStatus.SERVICE_UNAVAILABLE
        );
    }
}
