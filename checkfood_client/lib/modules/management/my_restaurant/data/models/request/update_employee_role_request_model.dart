/// Request payload for changing an employee's role.
class UpdateEmployeeRoleRequestModel {
  final String role;

  const UpdateEmployeeRoleRequestModel({required this.role});

  Map<String, dynamic> toJson() => {'role': role};
}
