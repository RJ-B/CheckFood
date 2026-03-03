package com.checkfood.checkfoodservice.security.module.auth.provider;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Enumeration of authentication providers supported v systému.
 *
 * Centrální registry všech authentication mechanisms including local
 * credentials a external OAuth providers. Used pro provider-specific
 * logic routing a user account management.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@RequiredArgsConstructor
public enum AuthProvider {

    /**
     * Local authentication pomocí email/password managed v systému.
     * Users create accounts directly v aplikaci s password storage
     * a verification handled internally.
     */
    LOCAL("local"),

    /**
     * Google OAuth2 authentication pomocí Google Identity Services.
     * Users authenticate přes Google accounts s OAuth2 flow
     * a profile data synchronized from Google APIs.
     */
    GOOGLE("google"),

    /**
     * Apple Sign-In authentication pomocí Apple Identity Services.
     * Users authenticate přes Apple ID s OAuth2-like flow
     * a limited profile data according Apple privacy policies.
     */
    APPLE("apple");

    /**
     * String identifier used v configurations a external integrations.
     */
    private final String registrationId;

    /**
     * Utility method pro provider lookup from string identifier.
     *
     * Enables dynamic provider resolution from configuration files
     * nebo external system integrations requiring string-based lookups.
     *
     * @param providerId string identifier pro provider
     * @return matching AuthProvider enum value
     * @throws IllegalArgumentException pokud provider není supported
     */
    public static AuthProvider fromString(String providerId) {
        for (AuthProvider provider : AuthProvider.values()) {
            if (provider.registrationId.equalsIgnoreCase(providerId)) {
                return provider;
            }
        }
        throw new IllegalArgumentException("Nepodporovaný poskytovatel autentizace: " + providerId);
    }
}