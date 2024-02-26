/*import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:myapp/screens/coupon_screen.dart';
import 'package:myapp/screens/current_location.dart';
import 'package:myapp/screens/myProfil_screen.dart';
import 'package:myapp/screens/restaurant_list.dart';
import 'package:myapp/screens/restaurant_map_screen.dart';

class BottomTabNavigator extends StatefulWidget {
  @override
  _BottomTabNavigatorState createState() => _BottomTabNavigatorState();
}

class _BottomTabNavigatorState extends State<BottomTabNavigator> {
  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Anasayfa", Colors.blue),
    new TabItem(Icons.search, "Favori Restoranlar", Colors.orange),
    new TabItem(Icons.layers, "Restoran Haritası", Colors.red),
    new TabItem(Icons.library_music, "Hesabım", Colors.cyan),
  ]);

  int selectedPosition = 0;
  CircularBottomNavigationController? _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomTabNavigator(      ),
    );
  }

  Widget _bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: 60,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        if (selectedPos != null) {
          setState(() {
            selectedPosition = selectedPos;
            _navigateToPage(selectedPos);
          });
        }
      },
    );
  }

  void _navigateToPage(int selectedPos) {
    switch (selectedPos) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoriteRestaurants()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MapScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
        break;
    }
  }
}*/

/*import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

import '../screens/current_location.dart';
import '../screens/myProfil_screen.dart';
import '../screens/restaurant_list.dart';
import '../screens/restaurant_map_screen.dart';

class MyCircularBottomNavigationBar extends StatefulWidget {
  @override
  _MyCircularBottomNavigationBarState createState() =>
      _MyCircularBottomNavigationBarState();
}

class _MyCircularBottomNavigationBarState
    extends State<MyCircularBottomNavigationBar> {
  int selectedPosition = 0;
  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPosition);
  }

  void _navigateToPage(int selectedPos) {
    switch (selectedPos) {
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
    List<TabItem> tabItems = [
      new TabItem(Icons.home, "Anasayfa", Colors.blue),
      new TabItem(Icons.search, "Favoriler", Colors.orange),
      new TabItem(Icons.add_box, "Yakınımdakiler", Colors.green),
      new TabItem(Icons.favorite, "Hesabım", Colors.red),
    ];

    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: 60,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        if (selectedPos != null) {
          setState(() {
            _navigationController.value = selectedPos;
            selectedPosition = selectedPos;
            _navigateToPage(selectedPos);
          });
        }
      },
    );
  }
}*/


