package com.example.CheckFood.security;

import com.example.CheckFood.security.dto.AuthenticationRequest;
import com.example.CheckFood.security.dto.AuthenticationResponse;
import com.example.CheckFood.security.dto.RegisterRequest;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface AuthService extends UserDetailsService {
    AuthenticationResponse login(AuthenticationRequest request);
    AuthenticationResponse register(RegisterRequest request);
}