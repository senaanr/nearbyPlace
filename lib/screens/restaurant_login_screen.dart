import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RestaurantLoginScreen extends StatelessWidget {
  RestaurantLoginScreen({super.key});

  Map<String, String> mockUsers = {
    'dribbble@gmail.com': '12345',
    'hunter@gmail.com': 'hunter',
    'near.huscarl@gmail.com': 'subscribe to pewdiepie',
    '@.com': '.',
  };

  static const String routeName = '/login';

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'User not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
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
            image: AssetImage('assets/image/road1.jpg'),
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
            const UserFormField(
              keyName: 'Ad',
              icon: Icon(FontAwesomeIcons.person),
            ),
            const UserFormField(
              keyName: 'Soyad',
              icon: Icon(FontAwesomeIcons.person),
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
            const UserFormField(
              keyName: 'Onay Kod',
              icon: Icon(Icons.numbers),
            ),
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
