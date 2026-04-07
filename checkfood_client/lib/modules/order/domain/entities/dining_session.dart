import 'package:freezed_annotation/freezed_annotation.dart';

part 'dining_session.freezed.dart';

/// Aktivní skupinová stravovací session sdílená více hosty u jednoho stolu.
@freezed
class DiningSession with _$DiningSession {
  const factory DiningSession({
    required String id,
    required String restaurantId,
    required String tableId,
    required String inviteCode,
    required String status,
    @Default([]) List<SessionMember> members,
  }) = _DiningSession;
}

/// Host, který se připojil k [DiningSession].
@freezed
class SessionMember with _$SessionMember {
  const factory SessionMember({
    required int userId,
    String? firstName,
    String? lastName,
    required DateTime joinedAt,
  }) = _SessionMember;

  const SessionMember._();

  String get displayName {
    final first = firstName ?? '';
    final last = lastName?.isNotEmpty == true
        ? ' ${lastName![0]}.'
        : '';
    if (first.isEmpty && last.isEmpty) return 'Uživatel';
    return '$first$last'.trim();
  }
}
