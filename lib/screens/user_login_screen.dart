import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/current_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserLoginScreen extends StatelessWidget {
  UserLoginScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String routeName = '/login';

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _loginUser(LoginData data) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
      return null; // Successful login
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message for unsuccessful login
    }
  }

  Future<String> _signupUser(SignupData data) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: data.name ?? '',
        password: data.password ?? '',
      );

      // Access additional form field values
      String name = data.additionalSignupData?['Ad'] ?? '';
      String surname = data.additionalSignupData?['Soyad'] ?? '';
      String phoneNumber = data.additionalSignupData?['phone_number'] ?? '';

      // Store additional user information in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': data.name ?? '',
        'name': name,
        'surname': surname,
        'phone_number': phoneNumber,
      });

      return 'başarılı kayıt';
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'An error occurred'; // Return error message for unsuccessful signup
    }
  }

  Future<String?> _recoverPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null; // Password reset email sent successfully
    } on FirebaseAuthException catch (e) {
      // Handle different Firebase Authentication exceptions
      if (e.code == 'user-not-found') {
        return 'User not found';
      } else {
        return 'Password reset failed. Please try again later.';
      }
    }
  }

  Future<String?> _signupConfirm(String error, LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

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
        child: FlutterLogin(
          theme: LoginTheme(
            pageColorLight: Colors.indigo,
            inputTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Color.fromRGBO(57, 190, 246, 1)),
              filled: true,
              fillColor: Color.fromRGBO(237, 249, 254, 1),
            ),
            textFieldStyle: const TextStyle(color: Color.fromRGBO(57, 190, 246, 1)),
            switchAuthTextColor: const Color.fromRGBO(185, 169, 169, 1),
            primaryColor: Colors.transparent,
            bodyStyle: const TextStyle(color: Color.fromRGBO(185, 169, 169, 1)),
            buttonTheme: const LoginButtonTheme(
              backgroundColor: Color.fromRGBO(237, 249, 254, 1),
            ),
            accentColor: Colors.transparent,
            buttonStyle: const TextStyle(color: Color.fromRGBO(57, 190, 246, 1)),
            cardTheme: const CardTheme(
              elevation: 0,
              color: Colors.white,
            ),
          ),
          additionalSignupFields: [
            UserFormField(
              keyName: 'Ad',
              displayName: 'ad'.tr,
              icon: const Icon(FontAwesomeIcons.person),
            ),
            UserFormField(
              keyName: 'Soyad',
              displayName: 'soyad'.tr,
              icon: const Icon(FontAwesomeIcons.person),
            ),
            UserFormField(
              keyName: 'phone_number',
              displayName: 'cep_telefonu'.tr,
              userType: LoginUserType.phone,
              fieldValidator: (value) {
                final phoneRegExp = RegExp(
                  '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
                );
                if (value != null && value.length < 7 && !phoneRegExp.hasMatch(value)) {
                  return "geçersiz_telefon_numarası".tr;
                }
                return null;
              },
            ),
            /*const UserFormField(
              keyName: 'Onay Kod',
              icon: Icon(Icons.numbers),
            ),*/
          ],
          onLogin: _loginUser,
          onSignup: _signupUser,
          loginProviders: [
            LoginProvider(
              icon: FontAwesomeIcons.google,
              callback: () async {
                debugPrint('start google sign in');
                await Future.delayed(loginTime);
                debugPrint('stop google sign in');
                return null;
              },
            ),
            LoginProvider(
              icon: Icons.person,
              callback: () async {
                debugPrint('Start google sign in');
                await Future.delayed(loginTime);
                debugPrint('Stop google sign in');
                return null;
              },
            ),
          ],
          onSubmitAnimationCompleted: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomeScreen(),));
          },
          onRecoverPassword: _recoverPassword,
          messages: LoginMessages(
            additionalSignUpFormDescription: "kaydı_tamamlamak_için_formu_doldurunuz".tr,
            additionalSignUpSubmitButton: "gönder".tr,
            providersTitleFirst: 'veya'.tr,
            userHint: 'e_posta'.tr,
            passwordHint: 'şifre'.tr,
            confirmPasswordHint: 'şifre_tekrar'.tr,
            loginButton: 'giriş'.tr,
            signupButton: 'kayıt_ol'.tr,
            forgotPasswordButton: 'şifremi_unuttum'.tr,
            recoverPasswordButton: 'sıfırla'.tr,
            goBackButton: 'geri'.tr,
            recoverPasswordIntro: 'şifreni_sıfırla'.tr,
            confirmPasswordError: 'şifreler_eşleşmedi'.tr,
            recoverPasswordDescription: 'E-Mail_adresinize_şifre_sıfırlama_bağlantısı_gönderilecek'.tr,
            recoverPasswordSuccess: 'sıfırlama_bağlantısı_gönderildi.'.tr,
          ),
        ),
      ),
    );
  }
}
