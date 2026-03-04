class StaffReservation {
  final String id;
  final String tableId;
  final String tableLabel;
  final int userId;
  final String date;
  final String startTime;
  final String endTime;
  final int partySize;
  final String status;
  final String createdAt;
  final bool canConfirm;
  final bool canReject;
  final bool canCheckIn;
  final bool canComplete;

  const StaffReservation({
    required this.id,
    required this.tableId,
    required this.tableLabel,
    required this.userId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.partySize,
    required this.status,
    required this.createdAt,
    required this.canConfirm,
    required this.canReject,
    required this.canCheckIn,
    required this.canComplete,
  });
}
