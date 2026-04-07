package com.checkfood.checkfoodservice.module.order.dining.exception;

import com.checkfood.checkfoodservice.infrastructure.exception.AppException;
import org.springframework.http.HttpStatus;

import java.util.UUID;

/**
 * Výjimka pro chyby skupinového sezení u stolu poskytující factory metody
 * pro typické scénáře — nenalezené, uzavřené nebo nepřístupné sezení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class DiningSessionException extends AppException {

    /**
     * Vytvoří novou výjimku sezení s daným chybovým kódem, zprávou a HTTP statusem.
     *
     * @param errorCode chybový kód z {@link DiningContextErrorCode}
     * @param message   lidsky čitelná chybová zpráva
     * @param status    HTTP status odpovědi
     */
    public DiningSessionException(DiningContextErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Vytvoří výjimku pro případ, kdy uživatel nemá žádné aktivní sezení.
     *
     * @return výjimka s HTTP 404
     */
    public static DiningSessionException noActiveSession() {
        return new DiningSessionException(
                DiningContextErrorCode.NO_ACTIVE_CONTEXT,
                "Nemáte žádné aktivní sezení.",
                HttpStatus.NOT_FOUND);
    }

    /**
     * Vytvoří výjimku pro případ, kdy uživatel není členem požadovaného sezení.
     *
     * @param sessionId UUID sezení
     * @return výjimka s HTTP 403
     */
    public static DiningSessionException notMember(UUID sessionId) {
        return new DiningSessionException(
                DiningContextErrorCode.CONTEXT_MISMATCH,
                "Nejste členem sezení " + sessionId + ".",
                HttpStatus.FORBIDDEN);
    }

    /**
     * Vytvoří výjimku pro nenalezené sezení.
     *
     * @param sessionId UUID nenalezeného sezení
     * @return výjimka s HTTP 404
     */
    public static DiningSessionException notFound(UUID sessionId) {
        return new DiningSessionException(
                DiningContextErrorCode.NO_ACTIVE_CONTEXT,
                "Sezení s ID " + sessionId + " nebylo nalezeno.",
                HttpStatus.NOT_FOUND);
    }

    /**
     * Vytvoří výjimku pro neplatný nebo neexistující pozvánkový kód.
     *
     * @param code zadaný pozvánkový kód
     * @return výjimka s HTTP 404
     */
    public static DiningSessionException invalidCode(String code) {
        return new DiningSessionException(
                DiningContextErrorCode.NO_ACTIVE_CONTEXT,
                "Aktivní sezení s kódem '" + code + "' neexistuje.",
                HttpStatus.NOT_FOUND);
    }

    /**
     * Vytvoří výjimku pro pokus o opakované připojení k sezení, jehož je uživatel již členem.
     *
     * @param sessionId UUID sezení
     * @return výjimka s HTTP 409
     */
    public static DiningSessionException alreadyMember(UUID sessionId) {
        return new DiningSessionException(
                DiningContextErrorCode.CONTEXT_MISMATCH,
                "Již jste členem sezení " + sessionId + ".",
                HttpStatus.CONFLICT);
    }

    /**
     * Vytvoří výjimku pro pokus o uzavření sezení jiným uživatelem, než hostitelem.
     *
     * @param sessionId UUID sezení
     * @return výjimka s HTTP 403
     */
    public static DiningSessionException notHost(UUID sessionId) {
        return new DiningSessionException(
                DiningContextErrorCode.CONTEXT_MISMATCH,
                "Sezení " + sessionId + " může zavřít pouze hostitel.",
                HttpStatus.FORBIDDEN);
    }

    /**
     * Vytvoří výjimku pro pokus o uzavření již uzavřeného sezení.
     *
     * @param sessionId UUID sezení
     * @return výjimka s HTTP 409
     */
    public static DiningSessionException alreadyClosed(UUID sessionId) {
        return new DiningSessionException(
                DiningContextErrorCode.CONTEXT_MISMATCH,
                "Sezení " + sessionId + " je již uzavřeno.",
                HttpStatus.CONFLICT);
    }
}
