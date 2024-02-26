import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/screens/restaurant_detail_screen.dart';
import 'package:myapp/screens/restaurant_list.dart';

class SearchScreen extends StatefulWidget {
  final String searchTerm;

  SearchScreen({required this.searchTerm});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Restaurant>> futureRestaurants; // Updated this line

  double userLat = 0.0;
  double userLng = 0.0;
  String selectedSortBy = 'Puan';
  Set<String> favoriteRestaurantIds = {};

  @override
  void initState() {
    super.initState();
    // Fetch restaurant data when the widget is initialized
    _getUserLocation();
    futureRestaurants = fetchRestaurantsByCategory(widget.searchTerm);
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        userLat = position.latitude;
        userLng = position.longitude;
        futureRestaurants = fetchRestaurantsByCategory(widget.searchTerm);
        print("Selected Category: ${widget.searchTerm}");
      });
    } catch (e) {
      print('Could not get location: $e');
    }
  }


  Future<List<Restaurant>> fetchRestaurantsByCategory(String searchTerm) async {
    final apiKey = 'AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc';
    final radius = 5000;
    final type = 'restaurant';
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$userLat,$userLng&radius=$radius&type=$type&keyword=$searchTerm&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      List<Restaurant> restaurants = results.map((result) {
        return Restaurant.fromJson(result, userLat, userLng);
      }).toList();

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
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 1.2,
              child: TextField(
                onChanged: (newSearchTerm) {
                  setState(() {
                    futureRestaurants =
                        fetchRestaurantsByCategory(newSearchTerm);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'bugün_ne_yesem'.tr,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Theme
                .of(context)
                .brightness == Brightness.light
                ? AssetImage('assets/image/road3.jpg')
                : AssetImage('assets/image/road2.jpg'),
            fit: BoxFit.cover,
          ),
          color: Theme
              .of(context)
              .brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: FutureBuilder<List<Restaurant>>(
          future: futureRestaurants,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final restaurants = snapshot.data!;
              if (restaurants.isEmpty) {
                return Center(child: Text('bu_kategoride_restoran_bulunamadı.'.tr ,
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),));
              }
              return ListView.builder(
                itemCount: restaurants.length * 2 - 1,
                itemBuilder: (context, index) {
                  if (index.isOdd) {
                    return Divider();
                  }
                  final restaurantIndex = index ~/ 2;
                  final restaurant = restaurants[restaurantIndex];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RestaurantDetails(
                                placeId: restaurant.id,
                              ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(restaurant.name),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}