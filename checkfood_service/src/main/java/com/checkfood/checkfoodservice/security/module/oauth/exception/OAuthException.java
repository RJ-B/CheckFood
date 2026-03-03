package com.checkfood.checkfoodservice.security.module.oauth.exception;

import com.checkfood.checkfoodservice.security.exception.SecurityException;
import org.springframework.http.HttpStatus;

/**
 * Výjimka pro modul OAuth.
 * Poskytuje tovární metody pro chyby při externí autentizaci.
 *
 * @see SecurityException
 * @see OAuthErrorCode
 */
public class OAuthException extends SecurityException {

    public OAuthException(OAuthErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    public OAuthException(OAuthErrorCode errorCode, String message, HttpStatus status, Throwable cause) {
        super(errorCode, message, status, cause);
    }

    /**
     * Vyvolá výjimku při neplatném nebo poškozeném tokenu od providera.
     */
    public static OAuthException invalidToken(String details) {
        return new OAuthException(
                OAuthErrorCode.OAUTH_TOKEN_INVALID,
                "Externí ověřovací token je neplatný: " + details,
                HttpStatus.UNAUTHORIZED
        );
    }

    /**
     * Vyvolá výjimku, pokud je použit nepodporovaný poskytovatel.
     */
    public static OAuthException providerNotSupported(String provider) {
        return new OAuthException(
                OAuthErrorCode.OAUTH_PROVIDER_NOT_SUPPORTED,
                "Poskytovatel '" + provider + "' není podporován.",
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * Vyvolá výjimku při technickém selhání komunikace s API poskytovatele.
     * Přijímá cause pro zachování stack trace.
     */
    public static OAuthException communicationError(String provider, String details, Throwable cause) {
        return new OAuthException(
                OAuthErrorCode.OAUTH_PROVIDER_COMMUNICATION_ERROR,
                "Chyba při komunikaci s poskytovatelem " + provider + ": " + details,
                HttpStatus.SERVICE_UNAVAILABLE,
                cause
        );
    }

    public static OAuthException userDataMissing(String provider) {
        return new OAuthException(
                OAuthErrorCode.OAUTH_USER_DATA_MISSING,
                "Od poskytovatele " + provider + " nebylo možné získat povinné údaje (email).",
                HttpStatus.BAD_REQUEST
        );
    }

    public static OAuthException internalError(String details, Throwable cause) {
        return new OAuthException(
                OAuthErrorCode.OAUTH_INTERNAL_ERROR,
                "Interní chyba OAuth modulu: " + details,
                HttpStatus.INTERNAL_SERVER_ERROR,
                cause
        );
    }

    /**
     * Vyvolá výjimku při konfliktu poskytovatelů (Account Linking Protection).
     */
    public static OAuthException accountProviderMismatch(String email, String currentProvider) {
        String msg = "LOCAL".equalsIgnoreCase(currentProvider)
                ? "Tento email je již registrován pomocí hesla. Použijte klasické přihlášení."
                : String.format("Tento email je již propojen s účtem %s. Přihlaste se přes tohoto poskytovatele.", currentProvider);

        return new OAuthException(
                OAuthErrorCode.OAUTH_PROVIDER_MISMATCH,
                msg,
                HttpStatus.CONFLICT
        );
    }
}