package com.example.CheckFood.domain.user;

import com.example.CheckFood.domain.user.dto.UserDto;
import com.example.CheckFood.domain.user.dto.UserUpdateRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final UserRepository userRepository;

    /**
     * Vytvoření uživatele (pro adminy / správce)
     */
    @PostMapping
    public UserDto createUser(@RequestBody UserDto userDto) {
        return userService.createUser(userDto);
    }

    /**
     * Získání všech uživatelů (pro adminy / správce)
     */
    @GetMapping
    public List<UserDto> getAllUsers() {
        return userService.getAllUsers();
    }

    /**
     * Získání konkrétního uživatele dle ID (pro adminy / správce)
     */
    @GetMapping("/{id}")
    public UserDto getUserById(@PathVariable Long id) {
        return userService.getUserById(id);
    }

    /**
     * Smazání uživatele (pro adminy / správce)
     */
    @DeleteMapping("/{id}")
    public void deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
    }

    /**
     * 🔒 Vrací údaje o aktuálně přihlášeném uživateli
     */
    @GetMapping("/me")
    public ResponseEntity<User> getProfile(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(user);
    }

    /**
     * ✏️ Upraví profil přihlášeného uživatele
     */
    @PutMapping("/me")
    public ResponseEntity<?> updateProfile(
            @RequestBody @Valid UserUpdateRequest userUpdateDto,
            @AuthenticationPrincipal User user
    ) {
        user.setFirstName(userUpdateDto.getFirstName());
        user.setLastName(userUpdateDto.getLastName());
        user.setPhone(userUpdateDto.getPhone());
        user.setAge(userUpdateDto.getAge());
        user.setProfileImage(userUpdateDto.getProfileImage());

        userRepository.save(user);
        return ResponseEntity.ok("Profil byl úspěšně aktualizován.");
    }
}
