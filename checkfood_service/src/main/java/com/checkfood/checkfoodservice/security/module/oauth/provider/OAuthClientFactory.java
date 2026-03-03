package com.checkfood.checkfoodservice.security.module.oauth.provider;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException;
import org.springframework.stereotype.Component;

import java.util.EnumMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

/**
 * Továrna pro dynamický výběr OAuth klientů.
 * Automaticky registruje všechny implementace rozhraní OAuthClient dostupné v kontextu aplikace.
 */
@Component
public class OAuthClientFactory {

    private final Map<AuthProvider, OAuthClient> clients = new EnumMap<>(AuthProvider.class);

    /**
     * Konstruktor využívající Spring Dependency Injection k získání všech instancí OAuthClient.
     *
     * @param oauthClients seznam všech dostupných implementací (GoogleOAuthClient, AppleOAuthClient atd.)
     */
    public OAuthClientFactory(List<OAuthClient> oauthClients) {
        oauthClients.forEach(client -> clients.put(client.getProviderType(), client));
    }

    /**
     * Vrátí konkrétního klienta pro daného poskytovatele.
     *
     * @param provider typ poskytovatele (GOOGLE, APPLE)
     * @return implementace OAuthClient
     * @throws OAuthException pokud pro daného providera neexistuje klient
     */
    public OAuthClient getClient(AuthProvider provider) {
        return Optional.ofNullable(clients.get(provider))
                .orElseThrow(() -> OAuthException.providerNotSupported(provider.name()));
    }
}