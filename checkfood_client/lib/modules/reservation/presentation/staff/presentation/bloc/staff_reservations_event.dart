/// Základní třída pro eventy [StaffReservationsBloc].
abstract class StaffReservationsEvent {
  const StaffReservationsEvent();
}

class LoadStaffReservations extends StaffReservationsEvent {
  final String date;
  final String? restaurantId;
  const LoadStaffReservations(this.date, {this.restaurantId});
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

class LoadTables extends StaffReservationsEvent {
  const LoadTables();
}

class ProposeChange extends StaffReservationsEvent {
  final String reservationId;
  final String? startTime;
  final String? tableId;
  const ProposeChange(this.reservationId, {this.startTime, this.tableId});
}

class ExtendReservation extends StaffReservationsEvent {
  final String reservationId;
  final String endTime;
  const ExtendReservation(this.reservationId, this.endTime);
}
