/// A special operating day for a restaurant, such as a holiday, shortened hours, or full closure.
class SpecialDay {
  final DateTime date;
  final bool isClosed;
  final String? openAt;
  final String? closeAt;
  final String? note;

  const SpecialDay({
    required this.date,
    this.isClosed = true,
    this.openAt,
    this.closeAt,
    this.note,
  });

  factory SpecialDay.fromJson(Map<String, dynamic> json) {
    return SpecialDay(
      date: DateTime.parse(json['date'] as String),
      isClosed: json['closed'] as bool? ?? true,
      openAt: json['openAt'] != null
          ? (json['openAt'] as String).substring(0, 5)
          : null,
      closeAt: json['closeAt'] != null
          ? (json['closeAt'] as String).substring(0, 5)
          : null,
      note: json['note'] as String?,
    );
  }
}
