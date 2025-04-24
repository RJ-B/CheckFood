package com.example.CheckFood.domain.order;

import com.example.CheckFood.domain.order.dto.OrderDto;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class OrderMapper {

    private final ModelMapper modelMapper;

    public OrderMapper(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    // Mapování z Order na OrderDto
    public OrderDto toDto(Order order) {
        return modelMapper.map(order, OrderDto.class);
    }

    // Mapování z OrderDto na Order
    public Order toEntity(OrderDto orderDto) {
        return modelMapper.map(orderDto, Order.class);
    }
}
