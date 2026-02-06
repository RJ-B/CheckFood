package com.checkfood.checkfoodservice.security.oauth.provider;

import com.checkfood.checkfoodservice.security.oauth.exception.OAuthProviderNotSupportedException;

import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Factory pro výběr správného OAuth klienta podle typu providera.
 */
@Component
public class OAuthClientFactory {

    private final List<OAuthClient> clients;


    public OAuthClientFactory(List<OAuthClient> clients) {
        this.clients = clients;
    }


    /**
     * Vrátí implementaci OAuthClient pro zadaný provider.
     */
    public OAuthClient getClient(OAuthProviderType providerType) {

        return clients.stream()
                .filter(client -> client.getProviderType() == providerType)
                .findFirst()
                .orElseThrow(() ->
                        new OAuthProviderNotSupportedException(
                                "OAuth provider not supported: " + providerType
                        )
                );
    }

}
