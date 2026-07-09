class TmModel {
  final String id;
  final String name;
  final String phone;
  final String city;
  final String address;
  final double latitude;
  final double longitude;
  final String status;

  /// Fixed service radius for this TM, in kilometers (e.g. 25–50 km).
  final double coverageRadiusKm;

  const TmModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.coverageRadiusKm,
  });

  factory TmModel.fromJson(Map<String, dynamic> json) {
    return TmModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      status: json['status']?.toString() ?? 'active',
      coverageRadiusKm: (json['coverageRadiusKm'] as num?)?.toDouble() ?? 25.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'city': city,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'coverageRadiusKm': coverageRadiusKm,
    };
  }
}
