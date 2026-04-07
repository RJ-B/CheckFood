package com.checkfood.checkfoodservice.security.module.oauth.provider;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import lombok.Builder;
import lombok.Getter;

/**
 * Sjednocená přepravka pro data uživatele získaná z externích OAuth poskytovatelů.
 * Normalizuje odlišné formáty odpovědí od Google a Apple do jednotné struktury.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Builder
public class OAuthUserInfo {

    /** Unikátní ID uživatele u poskytovatele (claim 'sub'). */
    private String providerUserId;

    /** E-mailová adresa získaná z externího tokenu. */
    private String email;

    /** Křestní jméno (z Google claim 'given_name'). */
    private String firstName;

    /** Příjmení (z Google claim 'family_name'). */
    private String lastName;

    /** URL adresa profilového obrázku (dostupná u Google). */
    private String profileImageUrl;

    /** Typ poskytovatele identity pro správné přiřazení uživatele v DB. */
    private AuthProvider providerType;
}