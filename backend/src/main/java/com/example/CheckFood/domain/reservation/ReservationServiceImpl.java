package com.example.CheckFood.domain.reservation;

import com.example.CheckFood.domain.restaurant.Restaurant;
import com.example.CheckFood.domain.restaurant.RestaurantRepository;
import com.example.CheckFood.domain.user.User;
import com.example.CheckFood.domain.user.UserRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {

    private final ReservationRepository reservationRepository;
    private final UserRepository userRepository;
    private final RestaurantRepository restaurantRepository;

    @Override
    public ReservationDto createReservation(ReservationDto dto) {
        User user = userRepository.findById(dto.getUserId())
                .orElseThrow(() -> new RuntimeException("Uživatel nenalezen"));

        Restaurant restaurant = restaurantRepository.findById(dto.getRestaurantId())
                .orElseThrow(() -> new RuntimeException("Restaurace nenalezena"));

        Reservation reservation = ReservationMapper.toEntity(dto, user, restaurant);
        Reservation saved = reservationRepository.save(reservation);
        return ReservationMapper.toDto(saved);
    }

    @Override
    public List<ReservationDto> getAllReservations() {
        return reservationRepository.findAll()
                .stream()
                .map(ReservationMapper::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public ReservationDto getReservationById(Long id) {
        Reservation reservation = reservationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Rezervace nenalezena"));
        return ReservationMapper.toDto(reservation);
    }

    @Override
    public void deleteReservation(Long id) {
        reservationRepository.deleteById(id);
    }
}
