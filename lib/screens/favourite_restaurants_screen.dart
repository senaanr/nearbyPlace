import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/restaurant_list.dart';
import 'package:myapp/screens/restaurant_map_screen.dart';
import 'package:http/http.dart' as http;

import 'current_location.dart';
import 'myProfil_screen.dart';

class FavoriteRestaurants extends StatefulWidget {
  final List<Restaurant>? favoriteRestaurants;

  FavoriteRestaurants({this.favoriteRestaurants});

  @override
  State<FavoriteRestaurants> createState() => _FavoriteRestaurantsState();
}

class _FavoriteRestaurantsState extends State<FavoriteRestaurants> {
  int _selectedIndex = 0;
  late Set<String> favoriteRestaurantIds = {}; // Change type to Set<String>
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Anasayfa',
      style: optionStyle,
    ),
    Text(
      'Index 1: Favoriler',
      style: optionStyle,
    ),
    Text(
      'Index 2: Yakındakiler',
      style: optionStyle,
    ),
    Text(
      'Index 3: Hesabım', // Corrected the index number
      style: optionStyle,
    ),
  ];

  @override
  void initState() {
    super.initState();
    loadFavoriteRestaurantIdsFromFirestore();
  }

  static Future<Restaurant?> fetchRestaurantDetails(String placeId,
      double userLat, double userLng) async {
    final apiKey = 'AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc';
    final apiUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final result = responseData['result'];
        if (result != null) {
          // Extract the required information and provide it to the fromJson constructor
          print('API Response: $result');
          final double lat = result['geometry']['location']['lat'];
          final double lng = result['geometry']['location']['lng'];
          return Restaurant.fromJson(
            result,
            userLat,
            userLng,
          );
        }
      }
    } catch (e) {
      print('Error fetching restaurant details: $e');
    }

    return null;
  }

  static Future<Restaurant?> findRestaurantByIds(List<Restaurant> restaurants,
      String id) async {
    try {
      double userLat = 0.0;
      double userLng = 0.0;

      // Use firstWhere with orElse to handle the case where no matching element is found
      final restaurant = restaurants.firstWhere(
            (restaurant) => restaurant?.id == id,
        orElse: () =>
            Restaurant(
              id: id,
              name: 'Unknown Restaurant',
              rating: 0.0,
              photoReference: '',
              distance: 0,
              address: '',
              reviews: [],
              phoneNumber: '',
              website: '',
              openingHours: '',
              latitude: 0.0,
              longitude: 0.0,
            ),
      );

      if (restaurant != null) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        userLat = position.latitude;
        userLng = position.longitude;

        final details = await fetchRestaurantDetails(id, userLat, userLng);
        return details;
      } else {
        print('Info: Restaurant not found for ID $id');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error finding restaurant by ID: $e\n$stackTrace');
      return null;
    }
  }


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
            favoriteRestaurantIds =
            Set<String>.from(querySnapshot.docs.map((doc) => doc.id));
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MapScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'favori_restoranlar'.tr,
          style: TextStyle(
            color: Theme
                .of(context)
                .textTheme
                .titleLarge
                ?.color,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
            backgroundColor: CupertinoColors.destructiveRed,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoriler',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me_outlined),
            label: 'Yakındakiler',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: 'Hesabım',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // Adjust the sigma values for the blur effect
          child: Container(
            child: favoriteRestaurantIds != null && favoriteRestaurantIds.isNotEmpty
                ? FutureBuilder<List<Restaurant>>(
              future: fetchFavoriteRestaurantsDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final favoriteRestaurants = snapshot.data;
                  return ListView.builder(
                    itemCount: favoriteRestaurants?.length ?? 0,
                    itemBuilder: (context, index) {
                      final restaurant = favoriteRestaurants![index];
                      print('Photo Reference: $restaurant.photoReference');
                      return ListTile(
                        title: Text(restaurant.name ?? ''),
                        subtitle: Text(
                            "Puan:".tr + ' ${restaurant.rating?.toStringAsFixed(1) ??
                                'N/A'}/5'),
                        leading: Image.network(
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
                      );
                    },
                  );
                }
              },
            )
                : Center(
              child: Text('favori_restoranınız_bulunmamaktadır'.tr),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Restaurant>> fetchFavoriteRestaurantsDetails() async {
    final List<Restaurant> favoriteRestaurants = [];
    try {
      if (favoriteRestaurantIds != null && favoriteRestaurantIds.isNotEmpty) {
        for (final restaurantId in favoriteRestaurantIds) {
          // Fetch details for each favorite restaurant
          final restaurant = await findRestaurantByIds(
            widget.favoriteRestaurants ?? [],
            restaurantId,
          );

          if (restaurant != null) {
            final String apiKey =
                'AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc'; // Replace with your actual API key
            final apiUrl =
                'https://maps.googleapis.com/maps/api/place/details/json?place_id=$restaurantId&fields=name,rating,formatted_address,formatted_phone_number,website,opening_hours,reviews,geometry&key=$apiKey';

            final response = await http.get(Uri.parse(apiUrl));
            final Map<String, dynamic> data = json.decode(response.body);
            final Map<String, dynamic>? result = data['result'];

            final String name = result?['name'] ?? '';
            final double rating = result?['rating'] != null
                ? double.parse(result!['rating'].toString())
                : 0.0;
            final String photoReference = result?['photos'] != null &&
                result!['photos'].isNotEmpty &&
                result!['photos'][0]['photo_reference'] != null
                ? result!['photos'][0]['photo_reference']
                : '';
            final double lat = result?['geometry']['location']['lat'] ?? 0.0;
            final double lng = result?['geometry']['location']['lng'] ?? 0.0;
            final double distance = 0;
            final String address = result?['formatted_address'] ?? '';
            final List<Review> reviews = (result?['reviews'] as List<dynamic>?)
                ?.map((review) {
              return Review(
                userName: review?['author_name'] ?? '',
                rating: review?['rating'] != null
                    ? review!['rating'].toInt()
                    : 0,
                comment: review?['text'] ?? '',
              );
            }).toList() ??
                [];
            final String phoneNumber =
                result?['formatted_phone_number'] ?? '';
            final String website = result?['website'] ?? '';
            final String openingHours = result?['opening_hours'] != null
                ? result!['opening_hours']['weekday_text'].join('\n')
                : '';

            final String photoUrl = getPhotoUrl(photoReference);

            favoriteRestaurants.add(Restaurant(
              id: restaurantId,
              name: name,
              rating: rating,
              photoReference: photoReference,
              distance: distance,
              address: address,
              reviews: reviews,
              phoneNumber: phoneNumber,
              website: website,
              openingHours: openingHours,
              latitude: lat,
              longitude: lng,
            ));
          } else {
            print('Error: Restaurant details not found for ID $restaurantId');
            // You can handle the absence of details by providing a default Restaurant object if needed
            // favoriteRestaurants.add(Restaurant(id: restaurantId, name: 'Unknown Restaurant'));
          }
        }
        print("Favorite Restaurants Details: $favoriteRestaurants");
      } else {
        print('Error: No favorite restaurant IDs found');
      }
    } catch (e, stackTrace) {
      print('Error fetching favorite restaurant details: $e\n$stackTrace');
    }

    return favoriteRestaurants;
  }

  String getPhotoUrl(String photoReference) {
    if (photoReference.isNotEmpty) {
      final String apiKey = 'AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc';
      return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
    } else {
      // Provide a default image URL if no photo reference is available
      return 'https://cdn-icons-png.freepik.com/512/1996/1996055.png';
    }
  }
}
