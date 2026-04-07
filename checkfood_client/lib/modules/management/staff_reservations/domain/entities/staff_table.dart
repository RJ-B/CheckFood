/// A restaurant table as returned by the staff-management endpoint.
class StaffTable {
  final String id;
  final String label;
  final int capacity;
  final bool active;

  const StaffTable({
    required this.id,
    required this.label,
    required this.capacity,
    required this.active,
  });
}
