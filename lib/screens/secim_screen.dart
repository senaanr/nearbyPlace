import 'package:flutter/material.dart';
import 'package:myapp/screens/user_login_screen.dart';
import 'package:myapp/screens/restaurant_login_screen.dart';

class ChooseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Arka planı transparan yapıyoruz
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/road3.jpg'), // Arka plan resmi
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserLoginScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.transparent,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.account_circle, size: 50, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Kullanıcı', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RestaurantLoginScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.transparent,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.restaurant, size: 50, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Restoran', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
