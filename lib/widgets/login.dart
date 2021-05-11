import 'package:digitaler_buecherschrank/api/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../main.dart';

class LoginScreen extends StatelessWidget {
  Future<String?> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');
    var res = await AuthenticationService().login(data.name, data.password);
      if (res ??= true) {
        return "Server unavailable";
      } else if(res == true){
        return null;
      } else {
        return "Password or Username wrong";
      }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Digitaler Bücherschrank',
       
      logo: 'assets/icons/icon.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
      }, onRecoverPassword: (String s) {  },
        hideForgotPasswordButton: true,
    );
  }
}