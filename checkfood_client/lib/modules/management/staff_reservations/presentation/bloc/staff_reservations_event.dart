abstract class StaffReservationsEvent {
  const StaffReservationsEvent();
}

class LoadStaffReservations extends StaffReservationsEvent {
  final String date;
  const LoadStaffReservations(this.date);
}

class ChangeDate extends StaffReservationsEvent {
  final String date;
  const ChangeDate(this.date);
}

class ConfirmReservation extends StaffReservationsEvent {
  final String id;
  const ConfirmReservation(this.id);
}

class RejectReservation extends StaffReservationsEvent {
  final String id;
  const RejectReservation(this.id);
}

class CheckInReservation extends StaffReservationsEvent {
  final String id;
  const CheckInReservation(this.id);
}

class CompleteReservation extends StaffReservationsEvent {
  final String id;
  const CompleteReservation(this.id);
}

class PollRefresh extends StaffReservationsEvent {
  const PollRefresh();
}
