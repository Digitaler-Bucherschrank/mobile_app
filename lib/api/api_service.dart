// TODO: Caching requests
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digitaler_buecherschrank/api/authentication_service.dart';
import 'package:digitaler_buecherschrank/config.dart';
import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../main.dart';

class Client extends http.BaseClient{
  late http.Client client;

  Client(){
    this.client = new http.Client();
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers.addAll({
      HttpHeaders.authorizationHeader: "Bearer ${SharedPrefs().user.tokens!.accessToken!.token}"
    });

    var streamedRes = await this.client.send(request);
    var res = await Response.fromStream(streamedRes);

    switch(res.statusCode){
      case(401): {
        var error_message = json.decode(res.body).message;

        switch(error_message){
          case("TokenExpiredError"): {
            // Potentially causing never ending function calls but shouldn't unless we don't catch something
            await AuthenticationService().refreshTokens();
            return await send(request);
          }

          case("JsonWebTokenError"): {
            Utilities.logoutUser(MyApp.globalKey.currentContext);
            return streamedRes;
          }

          case("client_not_found"): {
            Utilities.logoutUser(MyApp.globalKey.currentContext);
            return streamedRes;
          }

          case("user_not_found"): {
            Utilities.logoutUser(MyApp.globalKey.currentContext);
            return streamedRes;
          }

          case("access_token_outdated"):{
            Utilities.logoutUser(MyApp.globalKey.currentContext);
            return streamedRes;
          }

          default: {
            return streamedRes;
          }
        }
      }

      default: {
        return streamedRes;
      }
    }
  }
}

// TODO: ERROR HANDLING IF E.G. TOKEN LOSES VALIDITY WHILE SENDING REQUESTS
class ApiService{
  final String host;
  final Client client = Client();

  static final ApiService _instance = ApiService._internal(CONFIG.API_HOST);

  factory ApiService(){
   return _instance;
  }

  ApiService._internal(this.host);

  Future<List<Book>> getBookCaseInventory(BookCase bookCase) async {
    var res = await client.get(Uri.https(host, 'api/bookCaseInventory', {
      "id": bookCase.iId!.oid
    }));

    var map = await compute(jsonDecode, res.body);

    var list = <Book>[];
    for(var book in map){
      list.add(Book.fromJson(book));
    }

    return list;
  }

}