import 'package:flutter/material.dart';
import 'package:myapp/screens/coupon_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/current_location.dart';
import '../screens/myProfil_screen.dart';
import '../screens/restaurant_list.dart';
import '../screens/restaurant_map_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CouponPage(),
    FavoriteRestaurants(),
    AccountPage(),
    //RestaurantMap(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'anasayfa'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_attraction),
            label: 'kuponlarım'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favoriler'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: 'hesabım'.tr,
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Yakındaki_Restoranlar'.tr,
          ),*/
        ],
      ),
    );
  }
}