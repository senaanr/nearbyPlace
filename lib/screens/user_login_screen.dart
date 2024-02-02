import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/screens/current_location.dart';

class UserLoginScreen extends StatelessWidget {
  UserLoginScreen({super.key});

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
          title: 'ECORP',
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
              displayName: 'Telefon Numarası',
              userType: LoginUserType.phone,
              fieldValidator: (value) {
                final phoneRegExp = RegExp(
                  '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
                );
                if (value != null && value.length < 7 && !phoneRegExp.hasMatch(value)) {
                  return "Geçersiz telefon numarası";
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
              icon: FontAwesomeIcons.facebookF,
              callback: () async {
                debugPrint('start facebook sign in');
                await Future.delayed(loginTime);
                debugPrint('stop facebook sign in');
                return null;
              },
            ),
            LoginProvider(
              icon: FontAwesomeIcons.linkedinIn,
              callback: () async {
                debugPrint('start linkdin sign in');
                await Future.delayed(loginTime);
                debugPrint('stop linkdin sign in');
                return null;
              },
            ),
          ],
          onRecoverPassword: _recoverPassword,
          messages: LoginMessages(
            additionalSignUpFormDescription: "Kaydı tamamlamak için formu doldurunuz.",
            additionalSignUpSubmitButton: "Gönder",
            providersTitleFirst: 'Veya',
            userHint: 'E-Mail',
            passwordHint: 'Şifre',
            confirmPasswordHint: 'Şifre Tekrar',
            loginButton: 'Giriş',
            signupButton: 'Kayıt Ol',
            forgotPasswordButton: 'Şifremi Unuttum',
            recoverPasswordButton: 'Sıfırla',
            goBackButton: 'Geri',
            recoverPasswordIntro: 'Şifreni Sıfırla',
            confirmPasswordError: 'Şifreler eşleşmedi.',
            recoverPasswordDescription: 'E-Mail adresinize şifre sıfırlama bağlantısı gönderilecek.',
            recoverPasswordSuccess: 'Sıfırlama bağlantısı gönderildi.',
          ),
        ),
      ),
    );
  }
}
