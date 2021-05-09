import 'dart:convert';
import 'dart:io';

import 'package:digitaler_buecherschrank/config.dart';
import 'package:digitaler_buecherschrank/models/user.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthenticationService {
    late User _user;

    User get user => this._user;

    factory AuthenticationService(){
        return AuthenticationService._internal();
    }

    AuthenticationService._internal(){
        this._user = SharedPrefs().user;

        if(Jwt.isExpired(_user.tokens!.accessToken!.token!)){
            refreshAccessToken().then((value) {
                if(value is Tokens) {
                    _user.tokens = value;
                    SharedPrefs().user = _user;
                } else if(value == null){
                    logout();
                } else {
                    // Logic for showing the user that the server is temporarily offline
                }
            });
        }
    }

    Future<void> login() async {

    }


    Future<dynamic?> refreshAccessToken() async{
        final client = RetryClient(http.Client(), when: (BaseResponse res) {
            switch(res.statusCode){
                case(401): {
                    return false;
                }
                default: {
                    return true;
                }
            }
        });

        try {
            var res = await client.post(Uri.https(CONFIG.API_HOST, 'refresh'), headers: {
                HttpHeaders.authorizationHeader: "Bearer ${_user.tokens!.refreshToken!.token}"
            });

            if(res.statusCode != 401) {
                return Tokens.fromJson(jsonDecode(res.body));
            } else if(res.statusCode != 503) {
                return null;
            } else {
                return 503;
            }

        } catch(_) {
            return null;
        }finally {
            client.close();
        }
    }

    Future<void> logout() async {
      // removes client from server
    }
}