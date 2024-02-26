import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/myBottomTab.dart';
import 'package:myapp/components/myDrawer.dart';
import 'package:myapp/screens/restaurant_list.dart';
import 'package:myapp/screens/restaurant_map_screen.dart';
import 'package:myapp/screens/secim_screen.dart';
import 'current_location.dart';
import 'edit_screen.dart';
import 'favourite_restaurants_screen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}


class _AccountPageState extends State<AccountPage> {
  String firstName = '';
  String lastName = '';
  String email =  '';
  String password = '';
  int age = 0;
  String gender = '';
  String phoneNumber = '555-1234';

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
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

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
  Future<void> _fetchUserData() async {
    try {
      // Get the current user's email
      String userEmail = await getEmail();

      // Reference to the users collection in Firestore
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      // Query to get the user document with the matching email
      QuerySnapshot querySnapshot = await users.where('email', isEqualTo: userEmail).get();

      // Check if there is a matching document
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document (assuming there's only one matching document)
        var userData = querySnapshot.docs.first.data();

        // Update the state with the fetched user data
        setState(() {
          // Cast userData to Map<String, dynamic> if it's a Map
          Map<String, dynamic>? userDataMap = userData as Map<String, dynamic>?;

          // Use null-aware operators (?) to handle potential null values
          firstName = userDataMap?['name'] as String? ?? '';
          lastName = userDataMap?['surname'] as String? ?? '';
          email = userDataMap?['email'] as String? ?? '';
          age = userDataMap?['age'] as int? ?? 0;
          gender = userDataMap?['gender'] as String? ?? '';
          phoneNumber = userDataMap?['phone_number'] as String? ?? '555-1234';
        });

      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Theme.of(context).brightness == Brightness.light
                ? AssetImage('assets/image/road3.jpg')
                : AssetImage('assets/image/road2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hesabım'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                            color: Theme
                                .of(context)
                                .textTheme
                                .titleLarge
                                ?.color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 1,
                    color: Colors.white,
                  ),
                  buildEditableField('ad_soyad'.tr, '$firstName $lastName'),
                  buildEditableField('e_posta'.tr, email),
                  buildEditableField('yaş'.tr, age.toString(), keyboardType: TextInputType.number),
                  buildEditableField('cinsiyet'.tr, gender),
                  buildEditableField('cep_telefonu'.tr, phoneNumber),
                  buildClickableField('iletişim'.tr, _handleContactClick,Icons.contact_emergency),
                  buildClickableField('çıkış_yap'.tr, _handleLogoutClick, Icons.logout),
                  buildClickableField('şifre_değiştir'.tr, _changePassword, Icons.password_sharp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildClickableField(String label, VoidCallback onPressed, IconData iconData) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Container(
        height: 65,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      iconData,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    SizedBox(width: 18), // İkon ile metin arasına boşluk eklemek için
                    Text(
                      label,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, color: Theme.of(context).textTheme.titleLarge?.color),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _handleContactClick() {
    // İletişim butonuna tıklandığında yapılacak işlemler
    // Örneğin, bir iletişim sayfasına yönlendirme yapabilirsiniz.
  }

  void _handleLogoutClick() async {
    try {
      // Firebase üzerinde çıkış yapma
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChooseScreen()),
      );
    } catch (e) {
      print("Çıkış yapılırken hata oluştu: $e");
    }
  }

  Widget buildEditableField(String label, String value, {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                color: Theme
                    .of(context)
                    .textTheme
                    .titleLarge
                    ?.color,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(fontSize: 16,color: Theme
                      .of(context)
                      .textTheme
                      .titleLarge
                      ?.color,),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _openEditPage(label, value, isPassword, keyboardType);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openEditPage(String label, String initialValue, bool isPassword, TextInputType keyboardType) async {
    String? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(label: label, initialValue: initialValue, isPassword: isPassword, keyboardType: keyboardType),
      ),
    );

    if (result != null) {
      setState(() {
        switch (label) {
          case 'Ad Soyad':
            var names = result.split(' ');
            firstName = names[0];
            lastName = names.length > 1 ? names[1] : '';
            break;
          case 'E-posta':
            email = result;
            break;
          case 'Şifre':
            password = result;
            break;
          case 'Yaş':
            age = int.parse(result);
            break;
          case 'Cinsiyet':
            gender = result;
            break;
          case 'Cep Telefonu':
            phoneNumber = result;
            break;
        }
      });
    }
  }

  void _changePassword() {
  }

  static Future<String> getEmail() async {
    var email = await FirebaseAuth.instance.currentUser?.email.toString() ?? '';
    print(email);
    return email;
  }
}
