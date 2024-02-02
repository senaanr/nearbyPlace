/*import 'package:flutter/material.dart';
import '../model/place_model.dart';
import '../services/gplace_service.dart';
import 'placeDetail_page.dart';

class PlacesPage extends StatefulWidget {
  @override
  State createState() => new Placestate();
}

class Placestate extends State<PlacesPage> {
  late String _currentPlaceId;

  @override
  Widget build(BuildContext context) {
    onItemTapped = () => Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) => new PlaceDetailPage(_currentPlaceId),
      ),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Nearby places"),
        backgroundColor: Colors.green,
      ),
      body: _createContent(),
    );
  }

  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _createContent() {
    if (_places == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new ListView(
        children: _places!.map((f) {
          return new Card(
            child: new ListTile(
              title: new Text(f.name, style: _biggerFont),
              leading: new Hero(
                tag: 'place_image_${f.id}_list',  // Etkiketi burada benzersiz yapalım
                child: new Image.network(f.icon),
              ),
              subtitle: new Text(f.vicinity),
              onTap: () {
                _currentPlaceId = f.id;
                handleItemTap(f);
              },
            ),
          );
        }).toList(),
      );
    }
  }

  List<PlaceDetail>? _places;

  @override
  void initState() {
    super.initState();
    if (_places == null) {
      LocationService.get().getNearbyPlaces().then((data) {
        this.setState(() {
          _places = data;
        });
      });
    }
  }

  handleItemTap(PlaceDetail place) {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new PlaceDetailPage(place.id)));
  }

  VoidCallback? onItemTapped;
}
*/