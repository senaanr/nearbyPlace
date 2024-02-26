import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/components/myBottomTab.dart';
import 'package:myapp/screens/restaurant_list.dart';

import 'current_location.dart';
import 'favourite_restaurants_screen.dart';
import 'myProfil_screen.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _loadNearbyRestaurants();
      });
    } catch (e) {
      print('Could not get location: $e');
    }
  }

  Future<void> _loadNearbyRestaurants() async {
    try {
      final apiKey =
          'AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc'; // OpenWeatherMap API key
      final radius = 5000; // 5 km radius
      final url =
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentPosition!.latitude},${_currentPosition!.longitude}&radius=$radius&type=restaurant&key=$apiKey';

      final response = await http.get(Uri.parse(url));

      print('API Response: ${response.body}'); // Debugging line

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic>? results = data['results'];

        if (results != null && results is List) {
          final List<Restaurant> nearbyRestaurants = results.map((result) {
            if (result is Map<String, dynamic>) {
              final String id = result["id"] ?? '';
              final String name = result['name'] ?? '';
              final double rating = result['rating'] != null
                  ? double.parse(result['rating'].toString())
                  : 0.0;
              final String photoReference =
                  ''; // Photo reference, a separate API request can be made to get it.
              final double lat = result['geometry']['location']['lat'];
              final double lng = result['geometry']['location']['lng'];
              final double distance = 0;
              final String address = result['formatted_address'] ?? '';
              final List<Review> reviews = (result['reviews'] as List<dynamic>?)
                  ?.map<Review>((review) {
                if (review is Map<String, dynamic>) {
                  return Review(
                    userName: review['author_name'] ?? '',
                    rating: review['rating'] != null ? review['rating'].toInt() : 0,
                    comment: review['text'] ?? '',
                  );
                } else {
                  return Review(userName: '', rating: 0, comment: '');
                }
              })
                  .toList() ?? [];


              final String phoneNumber = result['formatted_phone_number'] ?? '';
              final String website = result['website'] ?? '';
              final String openingHours = result['opening_hours'] != null
                  ? (result['opening_hours']['weekday_text'] as List<dynamic>?)
                  ?.join('\n') ?? ''
                  : '';


              return Restaurant(
                id: id,
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
              );
            } else {
              print('Invalid result format: $result');
              return null; // veya uygun bir hata işleme stratejisi
            }
          }).whereType<Restaurant>().toList();

          setState(() {
            _markers = nearbyRestaurants.map((restaurant) {
              return Marker(
                markerId: MarkerId(restaurant.name),
                position: LatLng(restaurant.latitude, restaurant.longitude),
                infoWindow: InfoWindow(title: restaurant.name),
              );
            }).toSet();
          });
        } else {
          print('Results are null or not a List');
        }
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      print('Error loading restaurants: $e');
    }
  }

  int _selectedIndex = 0;
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
      'Index 2: Hesabım',
      style: optionStyle,
    ),
  ];

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
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoriteRestaurants()),
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

      appBar: AppBar(
        title: Text('Nearby Restaurants'),
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _markers.add(
              Marker(
                markerId: MarkerId("user_location"),
                position: LatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Mavi renkte bir marker
                infoWindow: InfoWindow(title: "Your Location"),
              ),
            );
          });
        },
        child: Icon(Icons.add_location),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

