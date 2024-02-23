// account_page.dart
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../localization.dart';
import '../providers/language_provider.dart';
import 'edit_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        const AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('tr', ''),
      ],
      home: AccountPage(),
    ),
  );
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String firstName = 'John';
  String lastName = 'Doe';
  String email = 'john.doe@example.com';
  String password = 'password123';
  int age = 25;
  String gender = 'Male';
  String phoneNumber = '555-1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        AppLocalization.of(context).translate('account_title'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.white,
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
                  buildEditableField('Ad', firstName),
                  buildEditableField('Soyad', lastName),
                  buildEditableField('E-posta', email),
                  buildEditableField('Şifre', password, isPassword: true),
                  buildEditableField('Yaş', age.toString(), keyboardType: TextInputType.number),
                  buildEditableField('Cinsiyet', gender),
                  buildEditableField('Cep Telefonu', phoneNumber),
                  buildLanguageButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
              AppLocalization.of(context).translate(label),
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (label != 'Şifre')
                  Text(
                    value,
                    style: TextStyle(fontSize: 16),
                  ),
                if (label == 'Şifre')
                  Row(
                    children: [
                      for (int i = 0; i < password.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.4),
                          child: Text(
                            '*',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                    ],
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

  Widget buildLanguageButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => _changeLanguage(context, 'en'),
          child: Text('English'),
        ),
        ElevatedButton(
          onPressed: () => _changeLanguage(context, 'tr'),
          child: Text('Türkçe'),
        ),
        // Diğer diller için de benzer şekilde butonlar ekleyebilirsiniz.
      ],
    );
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    final container = ProviderContainer();
    LanguageProvider languageProvider = container.read<LanguageProvider>(container:container);
    languageProvider.changeLanguage(languageCode);
    container.dispose(); // ProviderContainer'ı temizle
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
          case 'Ad':
            firstName = result;
            break;
          case 'Soyad':
            lastName = result;
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
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/myDrawer.dart';
import 'edit_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AccountPage(),
  ));
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String firstName = 'John';
  String lastName = 'Doe';
  String email = 'john.doe@example.com';
  String password = 'password123';
  int age = 25;
  String gender = 'Male';
  String phoneNumber = '555-1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(),
      ),
      drawer: MyDrawer(),
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
                          color: Colors.white,
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
                  buildEditableField('şifre'.tr, password, isPassword: true),
                  buildEditableField('yaş'.tr, age.toString(), keyboardType: TextInputType.number),
                  buildEditableField('cinsiyet'.tr, gender),
                  buildEditableField('cep_telefonu'.tr, phoneNumber),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(fontSize: 16),
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
}
