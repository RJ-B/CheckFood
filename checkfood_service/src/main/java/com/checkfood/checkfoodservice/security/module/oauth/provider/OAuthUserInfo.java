package com.checkfood.checkfoodservice.security.module.oauth.provider;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import lombok.Builder;
import lombok.Getter;

/**
 * Sjednocená přepravka pro data získaná z externích OAuth poskytovatelů.
 * Upraveno pro striktní oddělení jména a příjmení (firstName/lastName).
 */
@Getter
@Builder
public class OAuthUserInfo {

    /** Unikátní ID uživatele u poskytovatele (např. 'sub' claim). */
    private String providerUserId;

    /** E-mailová adresa získaná z externího tokenu. */
    private String email;

    /** Křestní jméno (z Google 'given_name' nebo Apple 'givenName'). */
    private String firstName; // ✅ Změna z fullName

    /** Příjmení (z Google 'family_name' nebo Apple 'familyName'). */
    private String lastName;  // ✅ Změna z fullName

    /** URL adresa profilového obrázku (typicky u Google). */
    private String profileImageUrl;

    /** Typ poskytovatele pro určení kontextu uložení v DB. */
    private AuthProvider providerType;

    // Metoda getFullName() již není potřeba, protože Service si to skládá sama nebo používá oddělené atributy.
}