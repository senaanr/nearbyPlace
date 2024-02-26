import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/coupon_screen.dart';
import 'package:myapp/screens/current_location.dart';
import 'package:myapp/screens/myProfil_screen.dart';
import 'package:myapp/screens/restaurant_list.dart';
import 'package:myapp/screens/restaurant_map_screen.dart';
import 'package:myapp/screens/secim_screen.dart';
import 'package:myapp/screens/user_login_screen.dart';

import '../screens/favourite_restaurants_screen.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person_3,
                    color: Colors.white,
                    size: 0.0,
                  ),
                  Text(
                    "Sena Nur Eren",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('anasayfa'.tr),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()), // KuponlarimScreen, gitmek istediğiniz ekranın adıdır
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_attraction),
            title: Text('kuponlarım'.tr),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CouponPage()), // KuponlarimScreen, gitmek istediğiniz ekranın adıdır
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('favoriler'.tr),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteRestaurants()), // KuponlarimScreen, gitmek istediğiniz ekranın adıdır
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined),
            title: Text('hesabım'.tr),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()), //
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text('Yakındaki_Restoranlar'.tr),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapScreen()),
              );
            },
          ),

          ExpansionTile(
            leading: Icon(Icons.perm_device_information),
            title: Text('Kurumsal'.tr),
            trailing: Icon(Icons.arrow_drop_down),
            children: <Widget>[
              ListTile(
                title: Text('biz_kimiz'.tr),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  //Navigator.pushNamed(context, "/bizkimiz");
                },
              ),
              ListTile(
                title: Text('tarihçemiz'.tr),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  //Navigator.pushNamed(context, "/tarihcemiz");
                },
              ),
              ListTile(
                title: Text('Kurumsal'.tr),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  //Navigator.pushNamed(context, "/kurumsal");
                },
              ),
            ],
          ),

          ListTile(
            leading: Icon(Icons.local_laundry_service),
            title: Text('hizmetler'.tr),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              //Navigator.pushNamed(context, "/hizmetler");
            },
          ),

          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('iletişim'.tr),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              //Navigator.pushNamed(context, "/iletisim");
            },
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('çıkış_yap'.tr),
            trailing: Icon(Icons.arrow_right),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                // Navigate to the login screen or any other screen after successful logout
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseScreen()),
                );
              } catch (e) {
                // Handle any errors that might occur during sign out
                print('Error during sign out: $e');
              }
            },
          ),

        ],
      ),
    );
  }
}