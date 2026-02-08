package com.checkfood.checkfoodservice.application.mapper.reservation;

import com.checkfood.checkfoodservice.application.dto.request.reservation.ReservationCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.reservation.ReservationListResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.reservation.ReservationResponseDto;
import com.checkfood.checkfoodservice.application.entity.reservation.Reservation;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

/**
 * Mapper zodpovědný za převod mezi
 * Reservation entitou a DTO objekty.
 *
 * <br><br>
 * Mapper slouží výhradně k transformaci dat
 * mezi aplikační a prezentační vrstvou
 * a neobsahuje žádnou business logiku.
 */
@Mapper(componentModel = "spring")
public interface ReservationMapper {

    /**
     * Převede vstupní DTO na novou entitu rezervace.
     *
     * <br><br>
     * Vlastnosti:
     * <br>
     * - ID je ignorováno,
     * <br>
     * - stav rezervace je nastavován v service vrstvě,
     * <br>
     * - auditní pole jsou spravována JPA.
     *
     * @param request vstupní DTO
     * @return nová entita rezervace
     */
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    Reservation toEntity(ReservationCreateRequestDto request);

    /**
     * Převede entitu rezervace
     * na detailní response DTO.
     *
     * @param reservation entita rezervace
     * @return detail rezervace
     */
    ReservationResponseDto toResponse(Reservation reservation);

    /**
     * Převede entitu rezervace
     * na položku seznamu rezervací.
     *
     * @param reservation entita rezervace
     * @return list response DTO
     */
    ReservationListResponseDto toListResponse(Reservation reservation);

    /**
     * Převede seznam entit rezervací
     * na seznam response DTO.
     *
     * @param reservations seznam entit
     * @return seznam response DTO
     */
    List<ReservationListResponseDto> toListResponse(List<Reservation> reservations);
}
