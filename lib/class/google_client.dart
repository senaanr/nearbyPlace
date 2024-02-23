import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'location.dart';
import 'restaurant.dart';

class GooglePlacesClient {
  final _apiKey = 'AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc';
  final _host = 'maps.googleapis.com';
  final _contextRoot = 'maps/api/place';

  Future<List<locationn>> fetchLocations(String query) async {
    final results = await request(
        path: 'autocomplete/json', parameters: {
      'input': query,
      'key': _apiKey,
      'types': '(cities)', // Adjust types based on your requirements
    });

    final predictions = results['predictions'];
    return predictions
        .map<locationn>((json) => locationn.fromJson(json))
        .toList(growable: false);
  }

  Future<List<Restaurant>> fetchRestaurants(
      locationn location, String query) async {
    final results = await request(path: 'textsearch/json', parameters: {
      'query': '$query near ${location.id.toString()}',
      'key': _apiKey,
    });

    final restaurants = results['results']
        .map<Restaurant>((json) => Restaurant.fromJson(json))
        .toList(growable: false);

    return restaurants;
  }

  Future<Map> request(
      {required String path, required Map<String, String> parameters}) async {
    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);
    final results = await http.get(uri);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }
}
