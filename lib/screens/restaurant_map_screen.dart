import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp/components/myDrawer.dart';
import 'package:myapp/screens/restaurant_list.dart';

class RestaurantMap extends StatefulWidget {
  final List<Restaurant> restaurants;

  RestaurantMap({List<Restaurant>? restaurants}) : this.restaurants = restaurants ?? [];

  @override
  _RestaurantMapState createState() => _RestaurantMapState();
}

class _RestaurantMapState extends State<RestaurantMap> {
  late GoogleMapController mapController;
  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  void _setMarkers() {
    markers.clear();
    for (var restaurant in widget.restaurants) {
      if (restaurant.latitude != null && restaurant.longitude != null) {
        markers.add(
          Marker(
            markerId: MarkerId(restaurant.id),
            position: LatLng(
              restaurant.latitude!,
              restaurant.longitude!,
            ),
            infoWindow: InfoWindow(
              title: restaurant.name,
              snippet: 'Rating: ${restaurant.rating.toStringAsFixed(1)}',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Yakınımdaki Restoranlar'),
        ),
        drawer: MyDrawer(),
        body:GoogleMap(
          onMapCreated: (controller) {
    mapController = controller;
    },
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.restaurants.isNotEmpty ? widget.restaurants.first.latitude ?? 0.0 : 0.0,
          widget.restaurants.isNotEmpty ? widget.restaurants.first.longitude ?? 0.0 : 0.0,
        ),
        zoom: 14.0,
      ),
      markers: markers,
    ),)
    );
  }
}
