package com.example.CheckFood.security;

import com.example.CheckFood.domain.user.User;
import com.example.CheckFood.domain.user.UserRepository;
import com.example.CheckFood.security.dto.AuthenticationRequest;
import com.example.CheckFood.security.dto.AuthenticationResponse;
import com.example.CheckFood.security.dto.RegisterRequest;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService { // ✅ přidáno UserDetailsService

    private static final Logger logger = LoggerFactory.getLogger(AuthServiceImpl.class);

    private final UserRepository userRepository;
    private final JwtService jwtService;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;

    @Override
    public AuthenticationResponse register(RegisterRequest request) {
        logger.info("Zahajování registrace pro uživatele: {}", request.getUsername());

        if (userRepository.existsByUsername(request.getUsername())) {
            logger.warn("Registrace selhala: uživatelské jméno {} již existuje", request.getUsername());
            throw new RuntimeException("Username already exists");
        }

        try {
            User user = User.builder()
                    .firstName(request.getFirstName())
                    .lastName(request.getLastName())
                    .email(request.getEmail())
                    .phone(request.getPhone())
                    .username(request.getUsername())
                    .password(passwordEncoder.encode(request.getPassword()))
                    .role("User")
                    .build();

            userRepository.save(user);
            String token = jwtService.generateToken(user.getUsername());

            logger.info("Registrace úspěšná pro uživatele: {}", user.getUsername());

            return new AuthenticationResponse(token, user.getFirstName(), user.getLastName(), user.getEmail());

        } catch (Exception e) {
            logger.error("Chyba při registraci: ", e);
            throw new RuntimeException("Registrace selhala: " + e.getMessage());
        }
    }

    @Override
    public AuthenticationResponse login(AuthenticationRequest request) {
        logger.info("Přihlašování uživatele: {}", request.getUsername());

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword())
        );

        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));

        String token = jwtService.generateToken(user.getUsername());

        logger.info("Přihlášení úspěšné pro uživatele: {}", user.getUsername());

        return new AuthenticationResponse(token, user.getFirstName(), user.getLastName(), user.getEmail());
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }
}
