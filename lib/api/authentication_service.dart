import 'dart:convert';
import 'dart:io';

import 'package:digitaler_buecherschrank/config.dart';
import 'package:digitaler_buecherschrank/main.dart';
import 'package:digitaler_buecherschrank/models/user.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthenticationService {
    late User _user;

    User get user => this._user;

    static final AuthenticationService _instance = AuthenticationService._internal();

    factory AuthenticationService(){
        return _instance;
    }

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


    // checks if Tokens are still up to date
    AuthenticationService._internal(){
        this._user = SharedPrefs().user;

        if(_user.tokens?.accessToken != null && _user.tokens?.refreshToken != null){
            if(Jwt.isExpired(_user.tokens?.accessToken?.token ?? "")){
                if(Jwt.isExpired(_user.tokens?.refreshToken?.token ?? "")){
                    logout();
                } else {
                    refreshTokens();
                }
            }
        } else {
            Utilities.logoutUser(null);
        }
    }

    Future<bool?> login(String username, String password) async {
        final client = RetryClient(http.Client(), when: (BaseResponse res) {
            switch(res.statusCode){
                case(401): {
                    return false;
                }
                case(201): {
                    return false;
                }
                case(400): {
                    return false;
                }
                default: {
                    return true;
                }
            }
        });

        try {
            var res = await client.post(Uri.https(CONFIG.API_HOST, 'api/login'), body: {
                "username": username,
                "password": password,
                "client_id": SharedPrefs().clientId
            });

            if(res.statusCode == 201) {
                var decodedUser = User.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
                _user = decodedUser;
                SharedPrefs().user = decodedUser;
                SharedPrefs().isLoggedIn = true;
                return true;
            } else if(res.statusCode == 400) {
                Utilities.logoutUser(null);
                return false;
            } else if(res.statusCode == 401){
                return null;
            }

        } catch(_) {
            return null;
        }finally {
            client.close();
        }

    }


    Future<void> refreshTokens() async{
        final client = RetryClient(http.Client(), when: (BaseResponse res) {
            switch(res.statusCode){
                case(200): {
                    return false;
                }
                case(401): {
                    return false;
                }
                default: {
                    return true;
                }
            }
        });

        try {
            var res = await client.post(Uri.https(CONFIG.API_HOST, 'api/refresh'), headers: {
                HttpHeaders.authorizationHeader: "Bearer ${_user.tokens!.refreshToken!.token}"
            });

            if(res.statusCode == 200) {
                var tokens = Tokens.fromJson(jsonDecode(res.body));
                if(tokens is Tokens) {
                    _user.tokens = tokens;
                    SharedPrefs().user = _user;
                } else {
                    logout();
                }
            } else if(res.statusCode == 401) {
                // Logout the User --> no specialized error handling needed
                logout();
                return null;
            } else {
                // Logic for showing the user that the server is temporarily offline
            }

        } catch(_) {
            return null;
        }finally {
            client.close();
        }
    }

    /// TODO: Send User to login screen
    Future<bool?> logout() async {
        final client = RetryClient(http.Client(), when: (BaseResponse res) {
            switch(res.statusCode){
                case(200): {
                    return false;
                }
                case(401): {
                    return false;
                }
                // User already logged out
                case(400): {
                    return false;
                }
                default: {
                    return true;
                }
            }
        });

        try {
            var res = await client.post(Uri.https(CONFIG.API_HOST, 'api/logout'), headers: {
                HttpHeaders.authorizationHeader: "Bearer ${_user.tokens!.accessToken!.token}"
            });

            // Logout anyways also if there are other Errors
            if(res.statusCode != 401) {
                Utilities.logoutUser(MyApp.globalKey.currentContext);
            } else if(res.statusCode != 503) {
                return false;
            } else if(res.statusCode == 400){
                // Client already logged out
                Utilities.logoutUser(MyApp.globalKey.currentContext);
                return true;
            } else {
                // Server unavailable
                return null;
            }

        } catch(_) {
            return false;
        }finally {
            client.close();
        }
    }
}