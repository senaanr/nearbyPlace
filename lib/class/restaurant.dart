import 'location_response.dart';
//AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc
class Restaurant {
  final String id;
  final String name;
  final String url;
  final String currency;
  final String thumbUrl;
  final String imageUrl;
  final String cuisines;
  final String address;
  final Rating rating;
  final LocationResponse locationResponse;
  final List<String> categories; // Added categories field

  final int priceRange;

  String get priceDisplay {
    final buffer = StringBuffer();
    for (int i = 0; i < priceRange; i++) {
      buffer.write(currency);
    }
    return buffer.toString();
  }

  Restaurant({
    required this.id,
    required this.name,
    required this.url,
    required this.currency,
    required this.thumbUrl,
    required this.imageUrl,
    required this.cuisines,
    required this.address,
    required this.rating,
    required this.locationResponse,
    required this.categories,
    required this.priceRange,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    final List<dynamic> categoryList = json['types'] ?? [];
    final List<String> categories = categoryList.map((category) => category.toString()).toList();

    final Map<String, dynamic>? locationJson = json['location'];
    String address;

    if (locationJson != null && locationJson['address'] != null) {
      // 'location' alanı var ve 'address' alanı dolu ise
      address = locationJson['address'];
    } else {
      // 'location' alanı null ise veya 'address' alanı null ise
      // Varsayılan olarak "40.7128,-74.0060" koordinatlarındaki adres atanır
      address = '40.7128,-74.0060';
    }

    return Restaurant(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      locationResponse: LocationResponse.fromJson(json['location'] ?? {}),
      thumbUrl: json['thumb'],
      imageUrl: json['featured_image'],
      priceRange: json['price_range'],
      currency: json['currency'],
      cuisines: json['cuisines'],
      address: address,
      rating: Rating.fromJson(json['user_rating']),
      categories: categories,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Restaurant && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Rating {
  final String text;
  final String average;

  Rating({required this.text, required this.average});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      text: json['rating_text']?.toString() ?? '',
      average: json['aggregate_rating']?.toString() ?? '',
    );
  }
}
