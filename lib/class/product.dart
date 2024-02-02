class Product {
  final String id;
  final String image;
  final List<String> images;
  final String name;
  final String miktar;
  final double fiyat;
  final double fiyatIndirimli;

  Product({
    required this.id,
    required this.image,
    required this.images,
    required this.name,
    required this.miktar,
    required this.fiyat,
    required this.fiyatIndirimli,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      image: json['image'],
      images: List<String>.from(json['images']),
      name: json['name'],
      miktar: json['miktar'],
      fiyat: json['fiyat'].toDouble(),
      fiyatIndirimli: json['fiyatIndirimli'].toDouble(),
    );
  }
}

// Usage
final Map<String, dynamic> productData = {
  "id": '1',
  "image": "https://example.com/product.jpg",
  "images": ["https://example.com/product.jpg"],
  "name": "Product Name",
  "miktar": "1 kg",
  "fiyat": 13.95,
  "fiyatIndirimli": 12.45,
};

final Product product = Product.fromJson(productData);


class Category {
  final String id;
  final String name;
  final String src;
  final List<String> subCategories;

  Category({
    required this.id,
    required this.name,
    required this.src,
    required this.subCategories,
  });
}

class Filtering {
  final String id;
  final String name;

  Filtering({
    required this.id,
    required this.name,
  });
}
