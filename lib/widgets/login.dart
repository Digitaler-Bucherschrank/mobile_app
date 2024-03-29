import 'package:digitaler_buecherschrank/api/authentication_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/widgets/intro.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'login/flutter_login.dart';

class LoginScreen extends StatelessWidget {
  var sp = SharedPrefs();

  Future<String?> _authUserLogin(LoginData data) async {
    print(
        'Name: ${data.name}, Password: ${data.password}, mail: ${data.email ?? "GG"}');
    var res = await AuthenticationService().login(data.name, data.password);
    if (res == null) {
      return S.current.label_server_unavailable;
    } else if (res == true) {
      return null;
    } else {
      return S.current.error_login_invalid_credentials;
    }
  }

  Future<String?> _authUserSignUp(LoginData data) async {
    print(
        'Name: ${data.name}, Password: ${data.password}, mail: ${data.email ?? "GG"}');
    var res = await AuthenticationService()
        .signUp(data.name, data.password, data.email!);

    // Checks what type of error message to show
    switch (res) {
      case (null):
        {
          return S.current.label_server_unavailable;
        }

      case ("logged_in"):
        {
          return null;
        }

      case ("client_id_used"):
        {
          return "client_id_used";
        }

      case ("login_failed"):
        {
          return S.current.error_login_failed;
        }

      case ("username_too_short"):
        {
          return S.current.error_username_too_short;
        }

      case ("username_too_long"):
        {
          return S.current.error_username_too_long;
        }

      case ("invalid_username"):
        {
          return S.current.error_invalid_username;
        }

      case ("invalid_mail"):
        {
          return S.current.error_invalid_mail;
        }

      case ("username_taken"):
        {
          return S.current.error_username_taken;
        }

      case ("mail_taken"):
        {
          return S.current.error_mail_taken;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
          titleStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
      messages: LoginMessages(
          userHint: S.current.label_username,
          passwordHint: S.current.label_password,
          confirmPasswordHint: S.current.label_confirm_pw,
          signupButton: S.current.label_signup_button,
          loginButton: S.current.label_login_button),
      title: S.current.title,
      logo: 'assets/icons/icon.png',
      userValidator: (var userName) {
        return null;
      },
      onLogin: _authUserLogin,
      onSignup: _authUserSignUp,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            if (sp.finishedIntro) {
              return MyHomePage();
            } else {
              return IntroScreen();
            }
          },
        ));
      },
      onRecoverPassword: (String s) {},
      hideForgotPasswordButton: true,
    );
  }
}
