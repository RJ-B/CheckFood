package com.example.CheckFood.domain.reservation;

import com.example.CheckFood.domain.restaurant.Restaurant;
import com.example.CheckFood.domain.user.User;

public class ReservationMapper {

    public static Reservation toEntity(ReservationDto dto, User user, Restaurant restaurant) {
        return Reservation.builder()
                .date(dto.getDate())
                .time(dto.getTime())
                .tableNumber(dto.getTableNumber())
                .note(dto.getNote())
                .user(user)
                .restaurant(restaurant)
                .build();
    }

    public static ReservationDto toDto(Reservation reservation) {
        return ReservationDto.builder()
                .date(reservation.getDate())
                .time(reservation.getTime())
                .tableNumber(reservation.getTableNumber())
                .note(reservation.getNote())
                .userId(reservation.getUser().getId())
                .restaurantId(reservation.getRestaurant().getId())
                .build();
    }
}
