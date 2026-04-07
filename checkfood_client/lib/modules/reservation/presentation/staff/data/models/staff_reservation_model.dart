import '../../domain/entities/staff_reservation.dart';

/// API response model pro rezervaci viditelnou personálem.
class StaffReservationModel {
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

  const StaffReservationModel({
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

  factory StaffReservationModel.fromJson(Map<String, dynamic> json) {
    return StaffReservationModel(
      id: json['id'] as String,
      tableId: json['tableId'] as String,
      tableLabel: (json['tableLabel'] as String?) ?? '',
      userId: json['userId'] as int,
      userName: json['userName'] as String?,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String?,
      partySize: json['partySize'] as int,
      status: json['status'] as String,
      createdAt: (json['createdAt'] as String?) ?? '',
      canConfirm: json['canConfirm'] as bool? ?? false,
      canReject: json['canReject'] as bool? ?? false,
      canCheckIn: json['canCheckIn'] as bool? ?? false,
      canComplete: json['canComplete'] as bool? ?? false,
      canEdit: json['canEdit'] as bool? ?? false,
      canExtend: json['canExtend'] as bool? ?? false,
      hasPendingChange: json['hasPendingChange'] as bool? ?? false,
    );
  }

  StaffReservation toEntity() {
    return StaffReservation(
      id: id,
      tableId: tableId,
      tableLabel: tableLabel,
      userId: userId,
      userName: userName,
      date: date,
      startTime: startTime,
      endTime: endTime,
      partySize: partySize,
      status: status,
      createdAt: createdAt,
      canConfirm: canConfirm,
      canReject: canReject,
      canCheckIn: canCheckIn,
      canComplete: canComplete,
      canEdit: canEdit,
      canExtend: canExtend,
      hasPendingChange: hasPendingChange,
    );
  }
}
