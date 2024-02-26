/*import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;
  bool showLawyersButton = false;

  static final List<Widget> _widgetOptions = <Widget>[
    CurrentLocationScreen(),
  ];

  static const CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(41.331320, 36.269208),
    zoom: 14,
  );

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konum"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () async {
              Position position = await _determinePosition();

              googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 14,
                  ),
                ),
              );

              markers.clear();
              markers.add(
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: LatLng(position.latitude, position.longitude),
                ),
              );
              setState(() {
                showLawyersButton = true;
              });
            },
            label: const Text("Konumun"),
            icon: const Icon(Icons.location_history),
          ),
        ],
      ),
    );
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:myapp/components/myBottomTab.dart';
import 'package:myapp/components/myDrawer.dart';
import 'package:myapp/screens/restaurant_list.dart';
import 'package:myapp/screens/restaurant_map_screen.dart';
import '../class/user.dart';
import 'category_filter_screen.dart';
import 'favourite_restaurants_screen.dart';
import 'myProfil_screen.dart';

class HomeScreen extends StatefulWidget {
  final User? user;

  HomeScreen({this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController? mapController; // "?" eklenmiştir
  late LatLng currentLocation = LatLng(40.7128, -74.0060);
  late String currentAddress = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    var locationService = location.Location();
    try {
      var userLocation = await locationService.getLocation();
      _updateLocation(userLocation);
    } catch (e) {
      print("Error getting location: $e");
    }

    locationService.onLocationChanged.listen((LocationData newLocation) {
      _updateLocation(newLocation);
    });
  }

  void _updateLocation(LocationData locationData) async {
    if (mounted) {
      setState(() {
        currentLocation =
            LatLng(locationData.latitude!, locationData.longitude!);
      });
    }

    List<Placemark> placemarks = await placemarkFromCoordinates(
      currentLocation.latitude,
      currentLocation.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      setState(() {
        currentAddress =
            "${placemark.street}, \n${placemark.subLocality}, ${placemark.locality}";
      });
    }

    mapController!.animateCamera(CameraUpdate.newLatLng(currentLocation));
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
  void dispose(){
    super.dispose();
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
      body: SafeArea(
        child: Theme(
          data: Theme.of(context),
          child: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: currentLocation,
                  zoom: 15.0,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: currentLocation,
                    infoWindow: InfoWindow(title: 'konumunuz'.tr),
                  ),
                },
              ),
              Positioned(
                top: 5,
                left: 40,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.transparent,
                  child: Text(
                    currentAddress,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 16,
                right: 16,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CombinedScreen(),
                              ),
                            );
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'bugün_ne_yesem'.tr,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CombinedScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
