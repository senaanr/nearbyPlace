import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/components/myBottomTab.dart';
import 'package:myapp/components/myDrawer.dart';
import 'package:myapp/screens/restaurant_detail_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myapp/screens/restaurant_map_screen.dart';

import '../constants/app_constants.dart';
import 'current_location.dart';
import 'myProfil_screen.dart';


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
  static Restaurant? findRestaurantById(List<Restaurant> restaurants, String id) {
    try {
      return restaurants.firstWhere((restaurant) => restaurant.id == id);
    } catch (e) {
      return null;
    }
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
  late String backgroundImage;
  late Future<List<Restaurant>> futureRestaurants;
  double userLat = 0.0;
  double userLng =0.0;
  String selectedSortBy = 'Puan';
  Set<String> favoriteRestaurantIds = {};

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    futureRestaurants = fetchRestaurantsByCategory(widget.categoryName);
    backgroundImage = getCategoryBackgroundImage(widget.categoryName);
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
        backgroundImage = getCategoryBackgroundImage(widget.categoryName);
        print("Selected Category: ${widget.categoryName}");
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
              image: Theme
                  .of(context)
                  .brightness == Brightness.light
                  ? AssetImage('assets/image/road3.jpg')
                  : AssetImage('assets/image/road2.jpg'),
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
                      print('Photo Reference: $restaurants.photoReference');
                      return ListView.builder(
                        itemCount: restaurants.length > 0 ? restaurants.length : 1,
                        itemBuilder: (context, index) {
                          if (restaurants.length > 0) {
                            final restaurant = restaurants[index];
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
                                              : 'https://cdn-icons-png.freepik.com/512/1996/1996055.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
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
                                            color: Theme.of(context).textTheme.titleLarge?.color,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Uzaklık:'.tr + restaurant.distance.toStringAsFixed(2) + ' km',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).textTheme.titleLarge?.color,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(
                                              'Puan:'.tr + restaurant.rating.toStringAsFixed(1),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context).textTheme.titleLarge?.color,
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
                                          favoriteRestaurantIds!.contains(restaurant.id) ? Icons.favorite : Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          favRestaurant(restaurant.id, FirebaseAuth.instance, updateFavoriteRestaurantIds);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Text('bu_kategoride_restoran_bulunamadı.'.tr ,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.titleLarge?.color,
                              ),),
                            );
                          }
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
          title: Text('sıralama'.tr, style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color,),),
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
              child: Text('kapat'.tr, style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color,),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String getCategoryBackgroundImage(String category) {
    // İlgili kategoriye göre arka plan resmini döndür
    // Eğer kategoriye özel bir resim yoksa, default bir resim döndür
    return AppConstants.categoryBackgroundImages[category] ?? AppConstants.defaultBackgroundImage;
  }


  Future<void> favRestaurant(
      String placeId, FirebaseAuth auth, Function(List<String>) updateFavoriteRestaurantIds) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      String? userEmail = auth.currentUser?.email;
      if (userEmail != null) {
        DocumentReference restaurantDocRef = firestore
            .collection('favouriteRestaurants')
            .doc(userEmail)
            .collection('favRestaurants')
            .doc(placeId);
        DocumentSnapshot restaurantDoc = await restaurantDocRef.get();

        if (restaurantDoc.exists) {
          // If the restaurant document exists, remove it
          await restaurantDocRef.delete();
        } else {
          // If the restaurant document doesn't exist, add it
          await restaurantDocRef.set({'restaurantId': placeId});
        }

        // Update favoriteRestaurantIds after modifying the Firestore data
        List<String> updatedFavoriteRestaurantIds = await fetchFavoriteRestaurantIds(userEmail, firestore);
        updateFavoriteRestaurantIds(updatedFavoriteRestaurantIds);
      } else {
        // Handle the case where the user is not authenticated or email is not available
      }
    } catch (e) {
      print('Error: $e');
      // Handle errors appropriately
    }
  }

  Future<List<String>> fetchFavoriteRestaurantIds(String? userEmail, FirebaseFirestore firestore) async {
    List<String> favoriteRestaurantIds = [];

    try {
      QuerySnapshot userDoc = await firestore.collection('favouriteRestaurants').doc(userEmail).collection('favRestaurants').get();
      userDoc.docs.forEach((doc) {
        favoriteRestaurantIds!.add(doc.id);
      });
    } catch (e) {
      print('Error fetching favorite restaurant IDs: $e');
    }

    return favoriteRestaurantIds;
  }
  void updateFavoriteRestaurantIds(List<String> updatedIds) {
    setState(() {
      favoriteRestaurantIds = updatedIds.toSet();
    });
  }

// Method to load the list of favorite restaurant IDs from Firestore
  Future<void> loadFavoriteRestaurantIdsFromFirestore() async {
    try {
      // Get the current user's email
      String? userEmail = FirebaseAuth.instance.currentUser?.email;
      if (userEmail != null) {
        // Reference to the collection of favorite restaurants for the user
        CollectionReference userFavoritesRef = FirebaseFirestore.instance
            .collection('favouriteRestaurants')
            .doc(userEmail)
            .collection('favRestaurants');

        // Get the documents inside the collection
        QuerySnapshot querySnapshot = await userFavoritesRef.get();

        // Extract restaurant IDs from the documents
        if (querySnapshot.docs.isNotEmpty) {
          setState(() {
            // Extract restaurant IDs from document names
            favoriteRestaurantIds = Set<String>.from(
                querySnapshot.docs.map((doc) => doc.id));
            print(favoriteRestaurantIds.first); // Print the first restaurant ID
          });
        } else {
          print("No favorite restaurants found");
        }
      } else {
        print("User email is null");
      }
    } catch (e) {
      print('Error loading favorite restaurant IDs from Firestore: $e');
    }
  }

// In the build method, check if each restaurant is a favorite and update the UI accordingly
  Marker createMarker(Restaurant restaurant) {
    bool isFavorite = favoriteRestaurantIds?.contains(restaurant.id) ?? false;
    IconData iconData = isFavorite ? Icons.favorite : Icons.favorite_border;
    return Marker(
      markerId: MarkerId(restaurant.name),
      position: LatLng(restaurant.latitude, restaurant.longitude),
      infoWindow: InfoWindow(title: restaurant.name),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        isFavorite ? BitmapDescriptor.hueRed : BitmapDescriptor.hueBlue,
      ),
      onTap: () {
        // You can implement toggling favorites in Firestore here
        toggleFavoriteStatusInFirestore(restaurant.id, !isFavorite);
      },
    );
  }

// Method to toggle the favorite status in Firestore
  Future<void> toggleFavoriteStatusInFirestore(String restaurantId, bool isFavorite) async {
    try {
      DocumentReference restaurantRef = FirebaseFirestore.instance.collection('favorites').doc(restaurantId);

      if (isFavorite) {
        await restaurantRef.set({'isFavorite': true});
      } else {
        await restaurantRef.delete();
      }
    } catch (e) {
      print('Error toggling favorite status in Firestore: $e');
    }
  }
}


