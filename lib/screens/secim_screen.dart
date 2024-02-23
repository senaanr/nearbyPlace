import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
            image: Theme.of(context).brightness == Brightness.light
                ? AssetImage('assets/image/road3.jpg')
                : AssetImage('assets/image/road2.jpg'),
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
                            MaterialPageRoute(
                                builder: (context) => UserLoginScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.transparent,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.account_circle,
                                size: 50, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('kullanıcı'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestaurantLoginScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.transparent,
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.restaurant,
                                size: 50, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('restoran'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 125,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      child: Text(
                        'EN',
                        style: GoogleFonts.quicksand(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueAccent,
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                    onTap: () {
                      Get.updateLocale(Locale('en','US'),);
                    },
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'TR',
                        style: GoogleFonts.quicksand(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.redAccent,
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                    onTap: () {
                      Get.updateLocale(Locale('tr','TR'),);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
