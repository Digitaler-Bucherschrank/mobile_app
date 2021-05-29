import 'dart:io';

import 'package:digitaler_buecherschrank/config.dart';
import 'package:digitaler_buecherschrank/main.dart';
import 'package:digitaler_buecherschrank/models/user.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:dio_retry/dio_retry.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:jwt_decode/jwt_decode.dart';

// TODO: transition
class AuthenticationService {
    final Dio client = Dio();
    late User _user;

  User get user => this._user;

  static final AuthenticationService _instance =
      AuthenticationService._internal();

  factory AuthenticationService() {
    return _instance;
  }

    // checks if Tokens are still up to date
    AuthenticationService._internal(){
        client.options.baseUrl = CONFIG.API_HOST;
        client.options.responseType = ResponseType.json;

            client.interceptors.add(RetryInterceptor(
            options: RetryOptions(
                retries: 3, // Number of retries before a failure
                retryInterval: const Duration(seconds: 1), // Interval between each retry
                retryEvaluator: (error) async {
                    // TODO: Show user the server is unavailable
                    if(error.type != DioErrorType.cancel && error.type != DioErrorType.response){
                        return true;
                    } else {
                        return false;
                    }
                }, // Evaluating if a retry is necessary regarding the error. It is a good candidate for updating authentication token in case of a unauthorized error (be careful with concurrency though)
            ), dio: client
        ));

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
          // Logic for showing the user that the server is temporarily offline
        }
      });
    } else {
      return _user.tokens!;
    }

    /// Status codes:
    /// 201: Login successful
    /// 400: client_id_already used (hence no further case differentation)
    /// 401: Login failed
    Future<bool?> login(String username, String password) async {
        try {
            var res = await client.post('/api/login', data: {
                "username": username,
                "password": password,
                "client_id": SharedPrefs().clientId
            });

            var decodedUser = User.fromJson(res.data as Map<String, dynamic>);
            _user = decodedUser;
            SharedPrefs().user = decodedUser;
            SharedPrefs().isLoggedIn = true;
            return true;

        } on DioError catch (e) {
            if (e.response!.statusCode == 400) {
                Utilities.logoutUser(MyApp.globalKey.currentContext);
                return null;
            } else if (e.response!.statusCode == 401) {
                return false;
            }
        }
    }
  }

  Future<dynamic?> refreshTokens() async {
    final client = RetryClient(http.Client(), when: (BaseResponse res) {
      switch (res.statusCode) {
        case (200):
          {
            return false;
          }
        case (401):
          {
            return false;
          }
        default:
          {
            return true;
          }
      }
    });

    Future<void> refreshTokens() async{
        try {
            var res = await client.post('/api/refresh', options: Options(headers: {
                HttpHeaders.authorizationHeader: "Bearer ${_user.tokens!.refreshToken!.token}"
            }));

                var tokens = Tokens.fromJson(res.data);
                if(tokens is Tokens) {
                    _user.tokens = tokens;
                    SharedPrefs().user = _user;
                } else {
                    logout();
                }
        } on DioError catch (e) {
            if (e.response!.statusCode == 401) {
                // Logout the User --> no specialized error handling needed
                await logout();
                return null;
            } else {
                // Logic for showing the user that the server is temporarily offline
                return null;
            }
        }
    }
  }


    Future<bool?> logout() async {
        try {
            var res = await client.post('/api/logout', options: Options(headers: {
                HttpHeaders.authorizationHeader: "Bearer ${_user.tokens!.accessToken!.token}"
            }));

            Utilities.logoutUser(MyApp.globalKey.currentContext);
        } on DioError catch (e) {
            // Logout anyways also if there are other Errors
            if (e.response!.statusCode == 401) {
                Utilities.logoutUser(MyApp.globalKey.currentContext);
            }  else if(e.response!.statusCode == 400){
                // Client already logged out
                Utilities.logoutUser(MyApp.globalKey.currentContext);
                return true;
            } else if(e.response!.statusCode != 503) {
                return false;
            } else {
                // Server unavailable - show maybe some dialogue?
                return null;
            }
        }
    }

    ///
    ///
    Future<String?> signUp(String username, String password, String email) async {
      var hashedPw = await FlutterBcrypt.hashPw(password: password, salt: await FlutterBcrypt.salt());
      try {
          var res = await client.post('/api/signup', data: {
              "username": username,
              "hash": hashedPw,
              "mail": email,
          });

              // Try to login after sign-up
              var loggedIn = await login(username, password);

              if(loggedIn == null){
                  return "login_failed";
              } else if(loggedIn){
                  return "logged_in";
              } else {
                  // TODO: Try to find a way to stop future chaining
                  // this is basically dead code, i don't know yet how to avoid this being executed
                  return "client_id_used";
              }

      } on DioError catch (e) {
          if(e.response!.statusCode == 400) {
              /// Return the servers error message to _authSignUp
              return e.response!.data["message"];
          } else if(e.response!.statusCode == 401){
              return null;
          }
      }
  }
}
