import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class NearbyRestaurantsScreen extends StatefulWidget {
  @override
  _NearbyRestaurantsScreenState createState() => _NearbyRestaurantsScreenState();
}

class _NearbyRestaurantsScreenState extends State<NearbyRestaurantsScreen> {
  late GoogleMapController mapController;
  late LatLng currentLocation = LatLng(39.9366913, 32.8553441); // Default value
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
          _getNearbyRestaurants();
        },
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 15.0,
        ),
        markers: Set.from(markers),
      ),
    );
  }

  Future<void> _getNearbyRestaurants() async {
    final String apiKey = "AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc"; // Replace with your API key
    final String apiUrl =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentLocation.latitude},${currentLocation.longitude}&radius=1000&type=restaurant&key=$apiKey";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      for (var result in results) {
        final Map<String, dynamic> geometry = result['geometry'];
        final Map<String, dynamic> location = geometry['location'];

        final String name = result['name'];
        final double lat = location['lat'];
        final double lng = location['lng'];

        setState(() {
          markers.add(Marker(
            markerId: MarkerId(name),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: name),
          ));
        });
      }
    } else {
      throw Exception('Failed to load nearby restaurants');
    }
  }
}
