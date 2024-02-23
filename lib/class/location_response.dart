class LocationResponse {
  final String address;
  final String locality;
  final String city;
  final String latitude;
  final String longitude;
  final String zipcode;

  LocationResponse({
    required this.address,
    required this.locality,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.zipcode,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      address: json['address'] ?? '', // Null kontrolü ekleniyor
      locality: json['locality'] ?? '',
      city: json['city'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      zipcode: json['zipcode'] ?? '',
    );
  }
}
