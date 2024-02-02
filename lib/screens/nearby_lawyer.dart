/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../model/nearby_response.dart'; // Model dosyasının yolunu doğru bir şekilde ayarlayın.

class NearByLawyersScreen extends StatefulWidget {
  @override
  _NearByLawyersScreenState createState() => _NearByLawyersScreenState();
}

class _NearByLawyersScreenState extends State<NearByLawyersScreen> {
  String apiKey =
      "AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc"; // Bu bilgiyi güvende tutun ve gizli yöntemlerle almayı düşünün.
  String radius = "30000";

  late LatLng currentLocation;
  List<Results> lawyersList = [];
  bool isLoading = true;

  late GoogleMapController mapController; // GoogleMap controller'ını ekleyin

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      isLoading = false;
    });
    _getNearbyLawyers();
  }

  void _getNearbyLawyers() async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
        currentLocation.latitude.toString() +
        ',' +
        currentLocation.longitude.toString() +
        '&radius=' +
        radius +
        '&type=lawyer' +
        '&key=' +
        apiKey);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      if (decodedData['results'] != null) {
        List<dynamic> results = decodedData['results'];
        lawyersList = results.map((e) => Results.fromJson(e)).toList();
        setState(() {});
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bir hata oluştu')));
    }
  }

  Set<Marker> _buildMarkers() {
    Set<Marker> markers = {};

    // Kullanıcının konumu için marker
    markers.add(Marker(
      markerId: MarkerId('currentLocation'),
      position: currentLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: 'Mevcut Konum'),
    ));

    // Avukatlar için markerlar
    markers.addAll(lawyersList.map((lawyer) {
      return Marker(
        markerId: MarkerId(lawyer.placeId!),
        position: LatLng(
          lawyer.geometry!.location!.lat!,
          lawyer.geometry!.location!.lng!,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {
          _onMarkerTapped(lawyer);
        },
      );
    }).toSet());

    return markers;
  }

  void _onMarkerTapped(Results lawyer) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _buildCustomInfoWindow(lawyer);
      },
    );
  }

  Widget _buildCustomInfoWindow(Results lawyer) {
    return Container(
      width: 200.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            lawyer.name!,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Puan: ${lawyer.rating.toString()}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Yorumlar: ${lawyer.userRatingsTotal.toString()}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            lawyer.vicinity!,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yakındaki Avukatlar'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Yükleniyor animasyonu
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 14.0,
        ),
        markers: _buildMarkers(),
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}
*/