// TODO: Caching requests
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Client extends http.BaseClient{
  late http.Client client;

  Client(){
    this.client = new http.Client();
  }

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll({
      HttpHeaders.authorizationHeader: "Bearer ${SharedPrefs().user.tokens!.accessToken!.token}"
    });

    return this.client.send(request);
  }
}


class ApiService{
  final String host;
  final Client client = Client();


  factory ApiService(String hostName){
   return ApiService._internal(hostName);
  }

  ApiService._internal(this.host);

  Future<List<Book>> getBookCaseInventory(BookCase bookCase) async {
    var res = await client.get(Uri.https(host, 'bookCaseInventory', {
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