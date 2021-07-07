// ignore: todo
// TODO: Caching requests
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digitaler_buecherschrank/api/authentication_service.dart';
import 'package:digitaler_buecherschrank/config.dart';
import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:digitaler_buecherschrank/models/user.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:dio_retry/dio_retry.dart';
import 'package:flutter/foundation.dart';
import '../main.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.type == DioErrorType.response) {
      switch (err.response!.data.statusCode) {
        case (401):
          {
            var errorMessage = err.response!.data.message;

            switch (errorMessage) {
              /* case("TokenExpiredError"): {
              // Potentially causing never ending function calls but shouldn't unless we don't catch something
              await AuthenticationService().refreshTokens();
              return super.onError(err, handler);
            } */ // handled by RetryInterceptor

              case ("JsonWebTokenError"):
              case ("client_not_found"):
              case ("user_not_found"):
              case ("access_token_outdated"):
                {
                  Utilities.logoutUser(MyApp.globalKey.currentContext);
                  return super.onError(err, handler);
                }

              default:
                {
                  return super.onError(err, handler);
                }
            }
          }

        default:
          {
            return super.onError(err, handler);
          }
      }
    } else {}

    return super.onError(err, handler);
  }
}

// TODO: ERROR HANDLING IF E.G. TOKEN LOSES VALIDITY WHILE SENDING REQUESTS
class ApiService {
  final String host;
  final Dio client = Dio();

  static final ApiService _instance = ApiService._internal(CONFIG.API_HOST);

  factory ApiService() {
    return _instance;
  }

  ApiService._internal(this.host) {
    client.options.headers.addAll({
      HttpHeaders.authorizationHeader:
          "Bearer ${SharedPrefs().user.tokens!.accessToken!.token}"
    });

    client.options.baseUrl = this.host;
    client.options.responseType = ResponseType.json;

    client.interceptors.add(InterceptorsWrapper(onError: (DioError e, handler) {
      // TODO: Add Screen to link user to some waiting screen until the server is online again
      return handler.next(e);
    }));

    client.interceptors.add(RetryInterceptor(
        options: RetryOptions(
          retries: 3,
          // Number of retries before a failure
          retryInterval: const Duration(seconds: 1),
          // Interval between each retry
          retryEvaluator: (error) async {
            var data = error.requestOptions.responseType == ResponseType.json
                ? error.response!.data
                : jsonDecode(error.response!.data);
            if (error.type != DioErrorType.cancel &&
                error.type != DioErrorType.response) {
              return true;
            } else if (error.response!.statusCode == 401) {
              switch (data["message"]) {
                case ("token_expired"):
                case ("invalid_access_token"):
                case ("client_not_found"):
                case ("user_not_found"):
                case ("access_token_outdated"):
                  {
                    await AuthenticationService().refreshTokens();
                    client.options.headers.clear();
                    client.options.headers.addAll({
                      HttpHeaders.authorizationHeader:
                          "Bearer ${SharedPrefs().user.tokens!.accessToken!.token}"
                    });
                  }
              }

              return true;
            } else {
              return false;
            }
          }, // Evaluating if a retry is necessary regarding the error. It is a good candidate for updating authentication token in case of a unauthorized error (be careful with concurrency though)
        ),
        dio: client));
  }

  Future<List<Book>> getBookData(List<Book> bookList) async {
    var bookParams = <String>[];

    for (var book in bookList) {
      bookParams.add(book.isbn!);
    }

    var params = {
      "isbn": bookParams.toString(),
    };

    var res = await client.get('/api/getBookInfo',
        queryParameters: params,
        options: Options(responseType: ResponseType.plain));

    var data = json.decode(res.data);
    for (var i = 0; i < bookList.length; i++) {
      bookList[i].bookData = VolumeData.fromJson(data![i]);
      bookList[i].title = bookList[i].bookData!.title;
      bookList[i].author = bookList[i].bookData!.authors![0];
    }

    return bookList;
  }

  Future<List<Book>> searchBooks(String query) async {
    var params = {
      "query": query,
    };

    var res = await client.get('/api/searchBooks',
        queryParameters: params,
        options: Options(responseType: ResponseType.plain));

    return await compute(Utilities.parseBooks, res.data);
  }

  Future<List<Book>> getBookCaseInventory(String bookCaseID) async {
    var params = {"_id": bookCaseID, "type": "inventory"};
    var inventory = <Book>[];

    var res = await client.get('/api/getBookCase',
        queryParameters: params,
        options: Options(responseType: ResponseType.plain));
    inventory = await compute(Utilities.parseBooks, res.data);

    return inventory;
  }

  Future<Map<String, List<Book>>> getUserInventory(User user) async {
    var res = await client.get('/api/getUserInventory',
        options: Options(responseType: ResponseType.plain));
    var parsedInventory = await compute(Utilities.parseInventory, res.data);

    return parsedInventory;
  }

  Future<bool> donateBook(Book book, bool manual, ManualBookData? data) async {
    Map<String, dynamic> params = {
      "isbn": book.isbn,
      "author": book.author,
      "title": book.title,
      "thumbnail": book.thumbnail,
      "location": book.location,
      "type": manual ? "manual" : "predefined"
    };

    if (manual) {
      params.addAll({"manualBookData": data!.toJson()});
    }

    try {
      await client.post('/api/donateBook', data: params);

      return true;
    } on DioError catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> borrowBook(Book book) async {
    var params = {
      "bookId": book.id,
      "location": book.location,
    };

    try {
      await client.post('/api/borrowBook', data: params);

      return true;
    } on DioError catch (e) {
      // Show user: "Please try again later" and refresh the List to fix up some issues with not being synced to the server
      return false;
    }
  }

  Future<bool> returnBook(Book book, BookCase bookCase) async {
    var params = {
      "bookId": book.id,
      "location": bookCase.iId!.oid,
    };

    try {
      await client.post('/api/returnBook', data: params);

      return true;
    } on DioError catch (e) {
      // Show user: "Please try again later" and refresh the List to fix up some issues with not being synced to the server
      return false;
    }
  }
}
