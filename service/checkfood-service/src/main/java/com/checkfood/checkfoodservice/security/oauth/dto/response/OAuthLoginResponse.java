package com.checkfood.checkfoodservice.security.oauth.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Odpověď po úspěšném OAuth přihlášení.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OAuthLoginResponse {

    // JWT access token
    private String accessToken;

    // Typ tokenu
    private String tokenType = "Bearer";

}
