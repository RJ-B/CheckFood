package com.checkfood.checkfoodservice.application.service.payment;

import com.checkfood.checkfoodservice.application.dto.request.payment.PaymentCallbackRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.payment.PaymentInitiateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.payment.PaymentResponseDto;
import com.checkfood.checkfoodservice.application.entity.payment.Payment;
import com.checkfood.checkfoodservice.application.entity.payment.PaymentStatus;
import com.checkfood.checkfoodservice.application.mapper.payment.PaymentMapper;
import com.checkfood.checkfoodservice.application.repository.payment.PaymentRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Implementace aplikační service pro agregát Payment.
 *
 * <br><br>
 * Service spravuje životní cyklus platby
 * a reaguje na callbacky externí platební brány.
 *
 * <br><br>
 * Payment je samostatný agregát a
 * service:
 * <br>
 * - nemění objednávku,
 * <br>
 * - pouze aktualizuje stav platby.
 */
@Service
@RequiredArgsConstructor
@Transactional
public class PaymentServiceImpl implements PaymentService {

    private final PaymentRepository paymentRepository;
    private final PaymentMapper paymentMapper;

    @Override
    public PaymentResponseDto initiatePayment(PaymentInitiateRequestDto request) {

        // TODO validation: existence objednávky
        // TODO validation: objednávka ještě není zaplacená
        // TODO security: oprávnění zahájit platbu

        Payment payment = paymentMapper.toEntity(request);

        payment.setStatus(PaymentStatus.CREATED);

        Payment saved = paymentRepository.save(payment);

        // TODO integration: vytvoření platby u platební brány / QR
        // TODO audit: vytvoření platby
        // TODO event: PaymentCreatedEvent

        return paymentMapper.toResponse(saved);
    }

    @Override
    public void handlePaymentCallback(PaymentCallbackRequestDto request) {

        // TODO security: ověření podpisu callbacku
        // TODO security: idempotence callbacku

        Payment payment = paymentRepository
                .findByExternalPaymentId(request.transactionId())
                .orElseThrow(() ->
                        new IllegalArgumentException(
                                "Payment not found for transaction: " + request.transactionId()
                        )
                );

        // TODO business rule:
        // callback je povolen pouze pro CREATED / PENDING

        PaymentStatus newStatus = mapCallbackStatus(request.status());
        payment.setStatus(newStatus);

        // případný failure reason
        if (newStatus == PaymentStatus.FAILED && request.message() != null) {
            payment.setFailureReason(request.message());
        }

        // updatedAt se nastaví automaticky přes @PreUpdate

        // TODO audit: změna stavu platby
        // TODO event: PaymentStatusChangedEvent
    }

    @Override
    @Transactional(Transactional.TxType.SUPPORTS)
    public PaymentResponseDto getPaymentDetail(UUID paymentId) {
        return paymentMapper.toResponse(
                paymentRepository.findById(paymentId)
                        .orElseThrow(() ->
                                new IllegalArgumentException("Payment not found: " + paymentId)
                        )
        );
    }

    /**
     * Mapuje stav vrácený externí
     * platební bránou na interní
     * doménový PaymentStatus.
     */
    private PaymentStatus mapCallbackStatus(String callbackStatus) {

        if (callbackStatus == null) {
            throw new IllegalArgumentException("Payment callback status is null");
        }

        return switch (callbackStatus.toUpperCase()) {
            case "SUCCESS" -> PaymentStatus.PAID;
            case "FAILED" -> PaymentStatus.FAILED;
            case "CANCELLED" -> PaymentStatus.CANCELLED;
            default -> throw new IllegalArgumentException(
                    "Unknown payment callback status: " + callbackStatus
            );
        };
    }
}
