package com.checkfood.checkfoodservice.application.mapper.order;

import com.checkfood.checkfoodservice.application.dto.request.order.OrderCreateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.order.OrderListResponseDto;
import com.checkfood.checkfoodservice.application.dto.response.order.OrderResponseDto;
import com.checkfood.checkfoodservice.application.entity.order.Order;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

/**
 * Mapper zodpovědný za převod mezi
 * Order entitou a DTO objekty.
 *
 * <br><br>
 * Mapper slouží výhradně k transformaci dat
 * mezi aplikační a prezentační vrstvou.
 */
@Mapper(componentModel = "spring", uses = {OrderItemMapper.class})
public interface OrderMapper {

    /**
     * Převede vstupní DTO
     * na novou entitu objednávky.
     *
     * <br><br>
     * Vlastnosti:
     * <br>
     * - ID je ignorováno,
     * <br>
     * - stav objednávky je nastavován v service vrstvě,
     * <br>
     * - auditní pole spravuje JPA.
     *
     * @param request vstupní DTO
     * @return nová entita objednávky
     */
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "items", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    Order toEntity(OrderCreateRequestDto request);

    /**
     * Převede entitu objednávky
     * na detailní response DTO.
     *
     * @param order entita objednávky
     * @return detail objednávky
     */
    OrderResponseDto toResponse(Order order);

    /**
     * Převede entitu objednávky
     * na položku seznamu objednávek.
     *
     * @param order entita objednávky
     * @return list response DTO
     */
    OrderListResponseDto toListResponse(Order order);

    /**
     * Převede seznam entit objednávek
     * na seznam response DTO.
     *
     * @param orders seznam entit
     * @return seznam response DTO
     */
    List<OrderListResponseDto> toListResponse(List<Order> orders);
}
