/// Request payload pro aktualizaci editovatelných polí restaurace.
class UpdateRestaurantRequestModel {
  final String name;
  final String? description;
  final Map<String, dynamic>? address;
  final String? phone;
  final String? email;
  final List<Map<String, dynamic>>? openingHours;
  final int? defaultReservationDurationMinutes;
  final List<Map<String, dynamic>>? specialDays;

  const UpdateRestaurantRequestModel({
    required this.name,
    this.description,
    this.address,
    this.phone,
    this.email,
    this.openingHours,
    this.defaultReservationDurationMinutes,
    this.specialDays,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'name': name,
    };
    if (description != null) json['description'] = description;
    if (address != null) json['address'] = address;
    if (phone != null) json['phone'] = phone;
    if (email != null) json['email'] = email;
    if (openingHours != null) json['openingHours'] = openingHours;
    if (defaultReservationDurationMinutes != null) {
      json['defaultReservationDurationMinutes'] = defaultReservationDurationMinutes;
    }
    if (specialDays != null) json['specialDays'] = specialDays;
    return json;
  }
}
