/*import 'package:flutter/material.dart';
import 'package:myapp/screens/current_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CurrentLocationScreen(),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/UI/location_screen.dart';
import 'package:myapp/UI/main_screen.dart';
import 'package:myapp/class/themes.dart';
import 'package:myapp/language.dart';
import 'package:myapp/providers/language_provider.dart';
import 'package:myapp/screens/category_filter_screen.dart';
import 'package:myapp/screens/coupon_screen.dart';
import 'package:myapp/screens/current_location.dart';
import 'package:myapp/screens/myProfil_screen.dart';
import 'package:myapp/screens/secim_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/favorite_bloc.dart';
import 'bloc/location_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationBloc>(
      bloc: LocationBloc(),
      child: BlocProvider<FavoriteBloc>(
        bloc: FavoriteBloc(),
        child: GetMaterialApp(
          translations : Language(),
          //supportedLocales: Language.diller,
          locale: Get.locale == null ? Get.deviceLocale : Get.locale,
          fallbackLocale: Language.varsayilan,
          title: 'Restaurant Finder',
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('tr', 'TR'), // Turkish
            const Locale('en', 'US'), // English
          ],
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          themeMode: ThemeMode.system,
          home: SplashScreen(),
        ),
      ),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) => Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => ChooseScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: 200.0,
            width: 200.0,
            child: LottieBuilder.asset('assets/animassets/mapanimation.json')),
      ),
    );
  }
}

