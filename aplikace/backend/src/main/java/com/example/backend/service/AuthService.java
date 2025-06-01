package com.example.backend.service;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.backend.auth.*;
import com.example.backend.config.JwtService;
import com.example.backend.model.*;
import com.example.backend.repository.UserRepository;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;

    public AuthenticationResponse register(RegisterRequest request) {
        var user = User.builder()
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .role(Role.USER)
                .build();
        userRepository.save(user);
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder()
                .token(jwtToken)
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .build();
    }

public AuthenticationResponse authenticate(LoginRequest request) {
    System.out.println("Login attempt: " + request.getEmail());

    User user = userRepository.findByEmail(request.getEmail())
            .orElseThrow(() -> {
                System.out.println("User not found");
                return new RuntimeException("User not found");
            });

    if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
        System.out.println("Invalid password");
        throw new RuntimeException("Invalid password");
    }

    String token = jwtService.generateToken(user);
    return new AuthenticationResponse(token, user.getFirstName(), user.getLastName());
}

}
