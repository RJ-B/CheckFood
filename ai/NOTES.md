# NOTES

---

2026-03-05
role: DEVELOPER
task: T-0002
action: implementace dokončena

Změny dle D-0009 (open-ended reservation model):

Backend (6 souborů):
- Reservation.java: endTime nullable=true
- ReservationServiceImpl.java: odstraněn DEFAULT_DURATION_MINUTES, nový available-slots algoritmus (stůl blokovaný od startTime dokud aktivní), createReservation/updateReservation bez endTime
- ReservationRepository.java: přepsány 3 JPQL queries (existsOverlappingReservation, existsOverlappingReservationExcluding, findActiveDiningReservations) — open-ended model
- StaffReservationServiceImpl.java: completeReservation() nastaví endTime=LocalTime.now()
- DiningContextServiceImpl.java: validTo fallback na closing time restaurace (místo reservation.endTime)
- AvailableSlotsResponse.java: odstraněno pole durationMinutes

Frontend (6 souborů):
- reservation.dart: endTime String? (nullable)
- reservation_response_model.dart: toEntity() mapuje endTime nullable
- reservation_card.dart: podmíněné zobrazení (endTime != null → rozsah, null → "od HH:mm")
- staff_reservation.dart: endTime String? (nullable)
- staff_reservation_model.dart: endTime nullable v field, constructor, fromJson
- staff_reservation_card.dart: podmíněné zobrazení timeRange

Build: backend compile OK, frontend build_runner OK (10 outputs)
Testy: 75/75 FAIL — pre-existing issue (H2/PostGIS inkompatibilita, nesouvisí s T-0002)
