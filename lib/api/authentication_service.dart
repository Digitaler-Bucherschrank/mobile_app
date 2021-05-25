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

  static final AuthenticationService _instance =
      AuthenticationService._internal();

  factory AuthenticationService() {
    return _instance;
  }

  final client = RetryClient(http.Client(), when: (BaseResponse res) {
    switch (res.statusCode) {
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

  // Mechanism returning the tokens if these are valid else logs out the user
  Tokens? getTokens() {
    if (Jwt.isExpired(_user.tokens!.accessToken!.token!)) {
      refreshTokens().then((value) {
        if (value is Tokens) {
          _user.tokens = value;
          SharedPrefs().user = _user;
          return value;
        } else if (value == null) {
          logout();
        } else {
          // Logic for showing the user that the server is temporarily offline
        }
      });
    } else {
      return _user.tokens!;
    }
  }

  AuthenticationService._internal() {
    this._user = SharedPrefs().user;

    if (Jwt.isExpired(_user.tokens!.accessToken!.token!)) {
      refreshTokens().then((value) {
        if (value is Tokens) {
          _user.tokens = value;
          SharedPrefs().user = _user;
        } else if (value == null) {
          logout();
        } else {
          // Logic for showing the user that the server is temporarily offline
        }
      });
    }
  }

  Future<bool?> login(String username, String password) async {
    final client = RetryClient(http.Client(), when: (BaseResponse res) {
      switch (res.statusCode) {
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

    try {
      var res = await client.post(Uri.https(CONFIG.API_HOST, 'login'),
          body: {"username": username, "password": password});

      if (res.statusCode != 401) {
        var decodedUser = User.fromJson(jsonDecode(res.body));
        _user = decodedUser;
        SharedPrefs().user = decodedUser;
      } else if (res.statusCode != 503) {
        return false;
      } else {
        return null;
      }
    } catch (_) {
      return false;
    } finally {
      client.close();
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

    try {
      var res = await client.post(Uri.https(CONFIG.API_HOST, 'refresh'),
          headers: {
            HttpHeaders.authorizationHeader:
                "Bearer ${_user.tokens!.refreshToken!.token}"
          });

      if (res.statusCode == 200) {
        return Tokens.fromJson(jsonDecode(res.body));
      } else if (res.statusCode == 401) {
        // Logout the User --> no specialized error handling needed
        logout();
        return null;
      } else {
        return 503;
      }
    } catch (_) {
      return null;
    } finally {
      client.close();
    }
  }

  /// returns a bool if logout was successfull
  // ignore: todo
  /// TODO: Send User to login screen
  Future<bool?> logout() async {
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
        // User already logged out
        case (400):
          {
            return false;
          }
        default:
          {
            return true;
          }
      }
    });

    try {
      var res = await client.post(Uri.https(CONFIG.API_HOST, 'logout'),
          headers: {
            HttpHeaders.authorizationHeader:
                "Bearer ${_user.tokens!.accessToken!.token}"
          });

      if (res.statusCode != 401) {
        var decodedUser = User.fromJson(jsonDecode(res.body));
        _user = decodedUser;
        SharedPrefs().user = decodedUser;
      } else if (res.statusCode != 503) {
        return false;
      } else if (res.statusCode == 400) {
        // Client already logged out
        return true;
      } else {
        // Server unavailable
        return null;
      }
    } catch (_) {
      return false;
    } finally {
      client.close();
    }
  }
}
