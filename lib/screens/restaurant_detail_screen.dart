import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myapp/screens/restaurant_list.dart';

class RestaurantDetails extends StatelessWidget {
  final String placeId;

  RestaurantDetails({required this.placeId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
      future: fetchRestaurantDetails(placeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final restaurant = snapshot.data!;
          print('detay ${restaurant.photoReference}');
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(restaurant.name),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(), // or ClampingScrollPhysics()
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Restoranın fotoğrafı
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              restaurant.photoReference.isNotEmpty
                                  ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${restaurant.photoReference}&key=YOUR_API_KEY'
                                  : 'https://cdn-icons-png.freepik.com/512/1996/1996055.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      // Restoranın adı ve Değerlendir button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              restaurant.name,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showRatingDialog(context, placeId);
                            },
                            child: Text('Değerlendir'),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      // Adres, telefon, website ve çalışma saatleri
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                              Icons.location_on, 'adres:'.tr, restaurant.address),
                          _buildInfoRow(
                              Icons.phone, 'telefon:'.tr, restaurant.phoneNumber),
                          _buildInfoRow(
                              Icons.language, 'website:'.tr, restaurant.website),
                          _buildOpeningHours(restaurant.openingHours),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      // Yorumlar
                      Text(
                        'yorumlar'.tr,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      // Restoran yorumları
                      _buildReviewsList(restaurant.reviews),
                      SizedBox(height: 16.0),
                      // Firebase Yorumları
                      Text(
                        'değerlendirmeler'.tr,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      // Firebase yorumlarını göster
                      _buildFirebaseReviewsList(placeId),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }


Widget _buildReviewsList(List<Review> reviews) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                reviews[index].userName.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 4),
                      Text(
                        reviews[index].rating.toString().tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(reviews[index].comment.tr),
                ],
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }

  Widget _buildFirebaseReviewsList(String placeId) {
    return FutureBuilder<List<Review>>(
      future: fetchFirebaseReviews(placeId),
      builder: (context, firebaseSnapshot) {
        if (firebaseSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (firebaseSnapshot.hasError) {
          return Center(child: Text('Error: ${firebaseSnapshot.error}'));
        } else {
          List<Review>? firebaseReviews = firebaseSnapshot.data;

          if (firebaseReviews == null || firebaseReviews.isEmpty) {
            return Center(child: Text('değerlendirme_bulunmamaktadır'.tr));
          }

          return Container(
            height: 200, // Set a fixed height or use constraints based on your UI design
            child: _buildReviewsList(firebaseReviews),
          );
        }
      },
    );
  }




  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 8),
          Flexible( // Wrap the Text widget with Flexible
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.tr,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 2),
                Text(
                  value.tr,
                  overflow: TextOverflow.ellipsis, // Add this line to handle overflow
                  maxLines: 3, // You can adjust the number of lines
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Review>> fetchFirebaseReviews(String placeId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('restaurantReviews')
          .doc(placeId)
          .collection('reviews')
          .get();

      List<Review> reviews = querySnapshot.docs.map((doc) {
        return Review(
          userName: doc['author_name'] ?? '',
          rating: doc['rating'] != null ? doc['rating'].toInt() : 0,
          comment: doc['text'] ?? '',
        );
      }).toList();

      return reviews;
    } catch (e) {
      throw Exception('Failed to load reviews from Firebase: $e');
    }
  }

  Widget _buildOpeningHours(String openingHours) {
    return ExpansionTile(
      title: Text(
        'çalışma_saatleri'.tr,
        style: TextStyle(color: Colors.grey),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(openingHours.tr),
        ),
      ],
    );
  }

  Future<Restaurant> fetchRestaurantDetails(String placeId) async {
    final apiKey = 'AIzaSyCnSvScJH5ItNThRlphgqAtnk9i0W85mlc'; // Replace with your actual API key
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,rating,formatted_address,formatted_phone_number,website,opening_hours,reviews,geometry&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic> result = data['result'];

      final String id = placeId;
      final String name = result['name'] ?? '';
      final double rating = result['rating'] != null ? double.parse(result['rating'].toString()) : 0.0;
      final String photoReference = ''; // Photo reference, a separate API request can be made to get it.
      final double lat = result['geometry']['location']['lat'];
      final double lng = result['geometry']['location']['lng'];
      final double distance = 0;
      final String address = result['formatted_address'] ?? '';
      final List<Review> reviews = (result['reviews'] as List<dynamic>).map((review) {
        return Review(
          userName: review['author_name'] ?? '',
          rating: review['rating'] != null ? review['rating'].toInt() : 0,
          comment: review['text'] ?? '',
        );
      }).toList();

      final String phoneNumber = result['formatted_phone_number'] ?? '';
      final String website = result['website'] ?? '';
      final String openingHours = result['opening_hours'] != null ? result['opening_hours']['weekday_text'].join('\n') : '';

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
      throw Exception('Failed to load restaurant details');
    }
  }
Future<String> getAuthorName() async {
  try {
    var authorEmail = FirebaseAuth.instance.currentUser!.email.toString();

    var userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: authorEmail)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      var userDocument = userSnapshot.docs.first;
      var userName = userDocument['name'];
      var userSurname = userDocument['surname'];

      return '$userName $userSurname';
    } else {
      return 'User not found';
    }
  } catch (e) {
    print('Error getting author name: $e');
    return 'Error';
  }
}

void _showRatingDialog(BuildContext context, String placeId) {
  double rating = 0;
  String comment = '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Değerlendir'),
            content: Column(
              children: [
                Text('Bu restoranı değerlendir'),
                SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 40,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    setState(() {
                      rating = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Yorumunuz',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      comment = value;
                    });
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  String authorName = await getAuthorName();
                  saveFirebaseReview(placeId, rating, comment, authorName);
                  Navigator.of(context).pop();
                },
                child: Text('Gönder'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('İptal'),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> saveFirebaseReview(String placeId, double rating, String comment, String authorName) async {
  try {
    CollectionReference<
        Map<String, dynamic>> reviewsCollection = FirebaseFirestore.instance
        .collection('restaurantReviews')
        .doc(placeId)
        .collection('reviews');

    await reviewsCollection.add({
      'author_name': authorName,
      'rating': rating,
      'text': comment,
    });

    print('Review saved successfully');
  } catch (e) {
    print('Failed to save review: $e');
    // Handle the error as needed
  }
}
}
