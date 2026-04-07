package com.checkfood.checkfoodservice.scheduler.job;

import com.checkfood.checkfoodservice.module.reservation.entity.ReservationStatus;
import com.checkfood.checkfoodservice.module.reservation.repository.ReservationRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDateTime;

/**
 * Plánovaná úloha, která každou minutu automaticky potvrdí rezervace čekající déle než 15 minut.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class ReservationAutoConfirmJob {

    private static final int AUTO_CONFIRM_AFTER_MINUTES = 15;

    private final ReservationRepository reservationRepository;
    private final Clock clock;

    /**
     * Vyhledá čekající rezervace starší než {@code AUTO_CONFIRM_AFTER_MINUTES} minut
     * a změní jejich stav na CONFIRMED.
     */
    @Scheduled(fixedRate = 60_000)
    @Transactional
    public void autoConfirmPendingReservations() {
        var cutoff = LocalDateTime.now(clock).minusMinutes(AUTO_CONFIRM_AFTER_MINUTES);
        var pending = reservationRepository.findPendingOlderThan(cutoff);

        if (pending.isEmpty()) {
            return;
        }

        for (var reservation : pending) {
            reservation.setStatus(ReservationStatus.CONFIRMED);
        }
        reservationRepository.saveAll(pending);

        log.info("[AutoConfirm] Automaticky potvrzeno {} rezervací starších než {} minut.",
                pending.size(), AUTO_CONFIRM_AFTER_MINUTES);
    }
}
