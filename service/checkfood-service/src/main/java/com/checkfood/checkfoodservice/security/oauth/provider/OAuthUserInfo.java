package com.checkfood.checkfoodservice.security.oauth.provider;

/**
 * Sjednocený model informací o uživateli z OAuth providerů.
 *
 * Slouží jako mezivrstva mezi externím providerem
 * (Google, Apple, ...) a interním UserEntity.
 */
public class OAuthUserInfo {

    // Unikátní ID u providera (sub)
    private String providerUserId;

    // Email uživatele
    private String email;

    // Zobrazované jméno
    private String fullName;

    // Typ providera (GOOGLE / APPLE)
    private OAuthProviderType providerType;


    public OAuthUserInfo() {
    }


    public OAuthUserInfo(
            String providerUserId,
            String email,
            String fullName,
            OAuthProviderType providerType
    ) {
        this.providerUserId = providerUserId;
        this.email = email;
        this.fullName = fullName;
        this.providerType = providerType;
    }


    public String getProviderUserId() {
        return providerUserId;
    }

    public void setProviderUserId(String providerUserId) {
        this.providerUserId = providerUserId;
    }


    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }


    public OAuthProviderType getProviderType() {
        return providerType;
    }

    public void setProviderType(OAuthProviderType providerType) {
        this.providerType = providerType;
    }

}
