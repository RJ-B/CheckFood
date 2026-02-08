package com.checkfood.checkfoodservice.application.mapper.order;

import com.checkfood.checkfoodservice.application.dto.request.order.OrderItemRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.order.OrderItemResponseDto;
import com.checkfood.checkfoodservice.application.entity.order.OrderItem;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;
import java.util.UUID;

/**
 * Mapper zodpovědný za převod mezi
 * OrderItem entitou a DTO objekty.
 *
 * <br><br>
 * Mapper neobsahuje žádnou business logiku
 * a slouží výhradně k transformaci dat.
 */
@Mapper(componentModel = "spring")
public interface OrderItemMapper {

    /**
     * Převede DTO položky objednávky
     * na novou entitu OrderItem.
     *
     * <br><br>
     * Vlastnosti:
     * <br>
     * - ID je ignorováno,
     * <br>
     * - objednávka je nastavena explicitně,
     * <br>
     * - auditní pole spravuje JPA.
     *
     * @param request vstupní DTO
     * @param orderId identifikátor objednávky
     * @return nová entita položky
     */
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "orderId", source = "orderId")
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    OrderItem toEntity(
            OrderItemRequestDto request,
            UUID orderId
    );

    /**
     * Převede entitu OrderItem
     * na response DTO.
     *
     * @param item entita položky
     * @return response DTO
     */
    OrderItemResponseDto toResponse(OrderItem item);

    /**
     * Převede seznam entit položek
     * na seznam response DTO.
     *
     * @param items seznam entit
     * @return seznam response DTO
     */
    List<OrderItemResponseDto> toResponseList(List<OrderItem> items);
}
