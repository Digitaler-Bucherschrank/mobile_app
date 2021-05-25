import 'package:digitaler_buecherschrank/api/authentication_service.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'login/flutter_login.dart';

class LoginScreen extends StatelessWidget {
  final bool skipLogin = true;

  Future<String?> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    if (!skipLogin) {
      var res = await AuthenticationService().login(data.name, data.password);
      if (res == null) {
        return "Server unavailable";
      } else if (res == true) {
        return null;
      } else {
        return "Password or Username wrong";
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(titleStyle: TextStyle(fontSize: 30)),
      messages: LoginMessages(userHint: "Username"),
      title: 'Digitaler Bücherschrank',
      logo: 'assets/icons/icon.png',
      userValidator: (var userName) {
        return null;
      },
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
      },
      onRecoverPassword: (String s) {},
      hideForgotPasswordButton: true,
    );
  }
}
