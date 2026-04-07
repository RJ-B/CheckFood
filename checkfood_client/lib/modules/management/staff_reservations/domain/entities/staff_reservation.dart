/// A reservation as seen by staff, including per-action capability flags.
class StaffReservation {
  final String id;
  final String tableId;
  final String tableLabel;
  final int userId;
  final String? userName;
  final String date;
  final String startTime;
  final String? endTime;
  final int partySize;
  final String status;
  final String createdAt;
  final bool canConfirm;
  final bool canReject;
  final bool canCheckIn;
  final bool canComplete;
  final bool canEdit;
  final bool canExtend;
  final bool hasPendingChange;

  const StaffReservation({
    required this.id,
    required this.tableId,
    required this.tableLabel,
    required this.userId,
    this.userName,
    required this.date,
    required this.startTime,
    this.endTime,
    required this.partySize,
    required this.status,
    required this.createdAt,
    required this.canConfirm,
    required this.canReject,
    required this.canCheckIn,
    required this.canComplete,
    this.canEdit = false,
    this.canExtend = false,
    this.hasPendingChange = false,
  });
}
