/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../UI/image_container.dart';
import '../bloc/bloc_provider.dart';
import '../bloc/favorite_bloc.dart';
import '../class/restaurant.dart';

class Restaurant {
  final String id;
  final String name;
  final List<String> categories;

  Restaurant({required this.id, required this.name, required this.categories});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    final List<dynamic> categoryList = json['types'] ?? [];
    final List<String> categories = categoryList.map((category) => category.toString()).toList();

    return Restaurant(
      id: json['place_id'],
      name: json['name'],
      categories: categories,
    );
  }
}

class RestaurantListScreen extends StatefulWidget {
  final String categoryName;

  RestaurantListScreen({required this.categoryName});

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late Future<List<Restaurant>> futureRestaurants;

  @override
  void initState() {
    super.initState();
    futureRestaurants = fetchRestaurantsByCategory(widget.categoryName);
  }

  Future<List<Restaurant>> fetchRestaurantsByCategory(String category) async {
    final apiKey = 'AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc'; // API anahtarınızı buraya ekleyin
    final radius = 5000; // 5 km
    final type = 'restaurant'; // Sadece restoranları filtrele
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=40.7128,-74.0060&radius=$radius&type=$type&keyword=$category&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      List<Restaurant> restaurants = results.map((result) {
        return Restaurant.fromJson(result);
      }).toList();

      return restaurants;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName}'),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: futureRestaurants,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final restaurants = snapshot.data!;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailsScreen(restaurant: restaurant),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(restaurant.name),
                    subtitle: Text('ID: ${restaurant.id}\nCategories: ${restaurant.categories.join(', ')}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant? restaurant;

  const RestaurantDetailsScreen({this.restaurant});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(restaurant!.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildBanner(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  restaurant!.cuisines,
                  style: textTheme.titleMedium?.copyWith(fontSize: 18),
                ),
                Text(
                  restaurant!.address,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          _buildDetails(context),
          _buildFavoriteButton(context)
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return ImageContainer(
      height: 200,
      url: restaurant!.imageUrl,
    );
  }

  Widget _buildDetails(BuildContext context) {
    final style = TextStyle(fontSize: 16);

    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Price: ${restaurant!.priceDisplay}',
            style: style,
          ),
          SizedBox(width: 40),
          Text(
            'Rating: ${restaurant!.rating.average}',
            style: style,
          ),
        ],
      ),
    );
  }

  // 1
  Widget _buildFavoriteButton(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return StreamBuilder<List<Restaurant>>(
      stream: bloc.favoritesStream,
      initialData: bloc.favorites,
      builder: (context, snapshot) {
        List<Restaurant>? favorites =
        ((snapshot.connectionState == ConnectionState.waiting)
            ? bloc.favorites
            : snapshot.data)?.cast<Restaurant>();
        bool? isFavorite = favorites?.contains(restaurant);

        return ElevatedButton.icon(
          onPressed: () => bloc.toggleRestaurant(restaurant!),
          style: ButtonStyle(
            foregroundColor: isFavorite != null && isFavorite ? MaterialStateProperty.all(Theme.of(context).hintColor) : null,
          ),
          icon: Icon(isFavorite != null && isFavorite ? Icons.favorite : Icons.favorite_border),
          label: Text('Favorite'),
        );
      },
    );
  }
}*/
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/components/myDrawer.dart';
import 'package:myapp/screens/restaurant_detail_screen.dart';
import 'package:geolocator/geolocator.dart';


class Restaurant {
  final String id;
  final String name;
  final double rating;
  final String photoReference;
  final double distance;
  final String address;
  final List<Review> reviews;
  final String phoneNumber;
  final String website;
  final String openingHours;
  final double latitude; // New property for latitude
  final double longitude; // New property for longitude
  bool isFavorite;

  Restaurant({
    required this.id,
    required this.name,
    required this.rating,
    required this.photoReference,
    required this.distance,
    required this.address,
    required this.reviews,
    required this.phoneNumber,
    required this.website,
    required this.openingHours,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json, double userLat, double userLng) {
    final String id = json['place_id'] ?? '';
    final String name = json['name'] ?? '';
    final double rating = json['rating'] != null ? double.parse(json['rating'].toString()) : 0.0;
    final String photoReference = json['photos'] != null && json['photos'].isNotEmpty
        ? json['photos'][0]['photo_reference'] ?? ''
        : 'https://cdn-icons-png.flaticon.com/512/1919/1919608.png';
    final double lat = json['geometry']['location']['lat'];
    final double lng = json['geometry']['location']['lng'];
    final double distance = calculateDistance(userLat, userLng, lat, lng);
    final String address = json['vicinity'] ?? '';

    List<Review> reviews = List.generate(
      Random().nextInt(5) + 1,
          (index) => Review(
        userName: 'User ${index + 1}',
        rating: Random().nextInt(5) + 1,
        comment: 'Comment ${index + 1}',
      ),
    );

    return Restaurant(
      id: id,
      name: name,
      rating: rating,
      photoReference: photoReference,
      distance: distance,
      address: address,
      reviews: reviews,
      phoneNumber: '+1234567890',
      website: 'https://example.com',
      openingHours: 'Mon-Fri: 9AM-9PM',
      latitude: lat,
      longitude: lng,
    );
  }

  static double calculateDistance(double userLat, double userLng, double restaurantLat, double restaurantLng) {
    const double radiusOfEarth = 6371.0;
    double latDistance = deg2rad(restaurantLat - userLat);
    double lngDistance = deg2rad(restaurantLng - userLng);
    double a = (sin(latDistance / 2) * sin(latDistance / 2)) +
        (cos(deg2rad(userLat)) * cos(deg2rad(restaurantLat)) * sin(lngDistance / 2) * sin(lngDistance / 2));
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = radiusOfEarth * c;
    return distance;
  }

  static double deg2rad(double deg) {
    return deg * (pi / 180);
  }
}

class Review {
  final String userName;
  final int rating;
  final String comment;

  Review({
    required this.userName,
    required this.rating,
    required this.comment,
  });
}

// Restaurant List Ekranı
class RestaurantListScreen extends StatefulWidget {
  final String categoryName;

  RestaurantListScreen({required this.categoryName});

  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late Future<List<Restaurant>> futureRestaurants;
  double userLat = 0.0;
  double userLng =0.0;
  String selectedSortBy = 'Puan';
  Set<String> favoriteRestaurantIds = {};

  // Map to associate categories with background images
  final Map<String, String> categoryBackgroundImages = {
    "burger":"assets/image/burger.jpg",
    "kebap_türk_mutfağı":"assets/image/burger.jpg",
    "tatlı":"assets/image/burger.jpg",
    "pizza":"assets/image/burger.jpg",
    "çiğ_köfte":"assets/image/burger.jpg",
    "kahve":"assets/image/burger.jpg",
    "tantuni":"assets/image/burger.jpg",
    "waffle":"assets/image/burger.jpg",
    "kokoreç":"assets/image/burger.jpg",
    "tavuk":"assets/image/burger.jpg",
    "kumpir":"assets/image/burger.jpg",
    "deniz_ürünleri":"assets/image/burger.jpg",
    "tost_sandviç":"assets/image/burger.jpg",
    "ev_yemekleri":"assets/image/burger.jpg",
    "kahvaltı_börek":"assets/image/burger.jpg",
    "makarna":"assets/image/burger.jpg",
    "mantı":"assets/image/burger.jpg",
    "salata":"assets/image/burger.jpg",
    "pastane_fırın":"assets/image/burger.jpg",
    "pilav":"assets/image/burger.jpg",
    "çorba":"assets/image/burger.jpg",
  };

  String getBackgroundImage(String category) {
    return categoryBackgroundImages[category] ?? 'assets/image/road3.jpg';
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    futureRestaurants = fetchRestaurantsByCategory(widget.categoryName);
  }


  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        userLat = position.latitude;
        userLng = position.longitude;
        futureRestaurants = fetchRestaurantsByCategory(widget.categoryName);
      });
    } catch (e) {
      print('Could not get location: $e');
    }
  }

  Future<List<Restaurant>> fetchRestaurantsByCategory(String category) async {
    final apiKey = 'AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc';
    final radius = 5000;
    final type = 'restaurant';
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$userLat,$userLng&radius=$radius&type=$type&keyword=$category&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      List<Restaurant> restaurants = results.map((result) {
        return Restaurant.fromJson(result, userLat, userLng);
      }).toList();

      switch(selectedSortBy) {
        case 'Puan':
          restaurants.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'Uzaklık':
          restaurants.sort((a, b) => a.distance.compareTo(b.distance));
          break;
        case 'Alfabetik':
          restaurants.sort((a, b) => a.name.compareTo(b.name));
          break;
      }

      return restaurants;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('${widget.categoryName}'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showSortByDialog();
            },
          ),
        ],
      ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(getBackgroundImage(widget.categoryName)),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // Adjust the sigma values for the blur effect
          child: Container(
          color: Colors.black.withOpacity(0.5), // Adjust the opacity as needed
          child: FutureBuilder<List<Restaurant>>(
                  future: futureRestaurants,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final restaurants = snapshot.data!;
                      return ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurants[index];
                          print('restoran ${restaurant.photoReference}');
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RestaurantDetails(
                                    placeId: restaurant.id,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Image.network(
                                        restaurant.photoReference.isNotEmpty
                                            ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${restaurant.photoReference}&key=AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc'
                                            : 'https://cdn-icons-png.freepik.com/512/1996/1996055.png', // Default image URL
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          // Display a default image when an error occurs
                                          return Image.network(
                                            'https://cdn-icons-png.freepik.com/512/1996/1996055.png',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),

                                      SizedBox(height: 10),
                                      Text(
                                        restaurant.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color:Theme.of(context).textTheme.titleLarge?.color,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Uzaklık:'.tr + restaurant.distance.toStringAsFixed(2) + ' km' ,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:Theme.of(context).textTheme.titleLarge?.color,

                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            'Puan:'.tr + restaurant.rating.toStringAsFixed(1),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color:Theme.of(context).textTheme.titleLarge?.color,

                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Row(
                                            children: List.generate(
                                              5,
                                                  (index) => Icon(
                                                Icons.star,
                                                color: index < restaurant.rating.round() ? Colors.yellow : Colors.grey,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: IconButton(
                                      icon: Icon(
                                        favoriteRestaurantIds.contains(restaurant.id) ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (favoriteRestaurantIds.contains(restaurant.id)) {
                                            favoriteRestaurantIds.remove(restaurant.id); // Favoriden çıkar
                                          } else {
                                            favoriteRestaurantIds.add(restaurant.id); // Favoriye ekle
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
          ),),);
  }

        void _showSortByDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('sıralama'.tr),
          content: DropdownButton<String>(
            value: selectedSortBy,
            onChanged: (String? newValue) {
              setState(() {
                selectedSortBy = newValue!;
                futureRestaurants = fetchRestaurantsByCategory(widget.categoryName);
              });
            },
            items: <String>['Puan', 'Uzaklık', 'Alfabetik'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.tr),
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('kapat'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


class FavoriteRestaurants extends StatelessWidget {
  final List<Restaurant>? favoriteRestaurants;

  FavoriteRestaurants({this.favoriteRestaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favori_restoranlar'.tr),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: favoriteRestaurants != null
          ? ListView.builder(
        itemCount: favoriteRestaurants!.length,
        itemBuilder: (context, index) {
          final restaurant = favoriteRestaurants![index];
          return ListTile(
            title: Text(restaurant.name),
            subtitle: Text(
                '${restaurant.distance.toStringAsFixed(2)} km (${restaurant.rating.toStringAsFixed(1)})'),
            leading: Image.network(
              restaurant.photoReference.isNotEmpty
                  ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${restaurant.photoReference}&key=AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc'
                  : 'https://media.istockphoto.com/id/1267161539/vector/meal-breaks-vector-line-icon-simple-thin-line-icon-premium-quality-design-element.jpg?s=612x612&w=0&k=20&c=9RNCS0uQvtbUGXqnmK1slk2y4rOOkJlE8bJ2W2qW9tY=', // Varsayılan fotoğraf URL'si
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          );
        },
      )
          : Center(
        child: Text('favori_restoranınız_bulunmamaktadır'.tr),
      ),
    );
  }
}
