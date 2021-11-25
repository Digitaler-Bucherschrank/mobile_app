import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:flutter/material.dart';

double _verticalPadding(BuildContext context) {
  return MediaQuery.of(context).size.height * 0.4;
}

double _horizontalPadding(BuildContext context) {
  return MediaQuery.of(context).size.width * 0.2;
}

class BookcasePopUp extends StatelessWidget {
  final Book book;
  final String bookCaseID;

  BookcasePopUp({required this.book, required this.bookCaseID});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().borrowBook(book),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: _horizontalPadding(context),
              vertical: _verticalPadding(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Loading",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                CircularProgressIndicator()
              ],
            ),
          );
        } else if (snapshot.data) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: _horizontalPadding(context),
              vertical: _verticalPadding(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Succes",
                  style: Theme.of(context).textTheme.headline6,
                ),
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        } else {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: _horizontalPadding(context),
              vertical: _verticalPadding(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Error! Try again later.",
                  style: Theme.of(context).textTheme.headline6,
                ),
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class UserPopUp extends StatelessWidget {
  final Book book;
  final BookCase bookCase;
  UserPopUp({required this.book, required this.bookCase});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().returnBook(book, bookCase),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: _horizontalPadding(context),
              vertical: _verticalPadding(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Loading",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                CircularProgressIndicator()
              ],
            ),
          );
        } else if (snapshot.data) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: _horizontalPadding(context),
              vertical: _verticalPadding(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Succes",
                  style: Theme.of(context).textTheme.headline6,
                ),
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        } else {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: _horizontalPadding(context),
              vertical: _verticalPadding(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Error! Try again later.",
                  style: Theme.of(context).textTheme.headline6,
                ),
                ElevatedButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }
}
