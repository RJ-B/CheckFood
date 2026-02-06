package com.checkfood.checkfoodservice.application.mapper.payment;

import com.checkfood.checkfoodservice.application.dto.request.payment.PaymentInitiateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.payment.PaymentResponseDto;
import com.checkfood.checkfoodservice.application.entity.payment.Payment;

import org.mapstruct.Mapper;

/**
 * Mapper pro Payment agregát.
 *
 * Používá se v:
 * - PaymentService
 * - PaymentController
 */
@Mapper(componentModel = "spring")
public interface PaymentMapper {

    // TODO: Payment <- PaymentInitiateRequestDto
    Payment toEntity(PaymentInitiateRequestDto dto);

    // TODO: Payment -> PaymentResponseDto
    PaymentResponseDto toResponse(Payment payment);
}
