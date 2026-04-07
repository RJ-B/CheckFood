/// Request payload for adding a new employee to a restaurant by email.
class AddEmployeeRequestModel {
  final String email;
  final String role;

  const AddEmployeeRequestModel({
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'role': role,
      };
}
