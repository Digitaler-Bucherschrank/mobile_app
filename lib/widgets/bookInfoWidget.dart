import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book.dart';
import 'package:flutter/material.dart';

class BookInfoWidget extends StatelessWidget {
  BookInfoWidget(this.book);
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title!),
      ),
      body: SingleChildScrollView(
        child: Builder(builder: (contrxt) {
          if (book.addedManual! && book.isbn == null) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Image.network(book.thumbnail!),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).label_scanner_title + ": ",
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(book.title!,
                                style: Theme.of(context).textTheme.bodyText1)
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).label_scanner_autor + ": ",
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(book.author!,
                                style: Theme.of(context).textTheme.bodyText1)
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ISBN: ",
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(book.isbn != null ? book.isbn! : "-",
                                style: Theme.of(context).textTheme.bodyText1)
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).label_book_info_addedManual,
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(
                                book.addedManual != null
                                    ? "${book.addedManual!}"
                                    : "-",
                                style: Theme.of(context).textTheme.bodyText1)
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                book.currentUser != null
                                    ? S.of(context).label_book_info_user
                                    : S.of(context).label_book_info_location,
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(
                                book.currentUser != null
                                    ? book.currentUser!
                                    : book.location!,
                                style: Theme.of(context).textTheme.bodyText1)
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ID: ",
                                style: Theme.of(context).textTheme.bodyText1),
                            Text(book.id != null ? book.id! : "-",
                                style: Theme.of(context).textTheme.bodyText1)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return FutureBuilder(
              future: ApiService().getBookData([book]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).label_loading,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        CircularProgressIndicator()
                      ],
                    ),
                  );
                } else {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Image.network(
                                book.bookData != null &&
                                        book.bookData!.image != null
                                    ? book.bookData!.image!
                                    : book.thumbnail!,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(S.of(context).label_scanner_title + ": ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      book.title!,
                                      textAlign: TextAlign.end,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(S.of(context).label_scanner_autor + ": ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text(book.author!,
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ISBN: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text(
                                      book.bookData != null
                                          ? book.bookData!.isbn != null
                                              ? book.bookData!.isbn!
                                              : "-"
                                          : "-",
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(S.of(context).label_book_info_ISBN13,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text(
                                      book.bookData != null
                                          ? book.bookData!.isbn13 != null
                                              ? book.bookData!.isbn13!
                                              : "-"
                                          : "-",
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(S.of(context).label_book_info_binding,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text(
                                      book.bookData != null
                                          ? book.bookData!.binding != null
                                              ? book.bookData!.binding!
                                              : "-"
                                          : "-",
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(S.of(context).label_book_info_language,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text(
                                      book.bookData != null
                                          ? book.bookData!.language != null
                                              ? book.bookData!.language!
                                              : "-"
                                          : "-",
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(S.of(context).label_book_info_dimensions,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                        book.bookData != null
                                            ? book.bookData!.dimensions != null
                                                ? book.bookData!.dimensions!
                                                : "-"
                                            : "-",
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      S
                                          .of(context)
                                          .label_book_info_datePublished,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                        book.bookData != null
                                            ? book.bookData!.datePublished !=
                                                    null
                                                ? book.bookData!.datePublished!
                                                    .toLocal()
                                                    .toString()
                                                : "-"
                                            : "-",
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(S.of(context).label_book_info_publisher,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                        book.bookData != null
                                            ? book.bookData!.publisher != null
                                                ? book.bookData!.publisher!
                                                : "-"
                                            : "-",
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      S.of(context).label_book_info_addedManual,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text(
                                      book.addedManual != null
                                          ? "${book.addedManual!}"
                                          : "-",
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      book.currentUser != null
                                          ? S.of(context).label_book_info_user
                                          : S
                                              .of(context)
                                              .label_book_info_location,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text(
                                      book.currentUser != null
                                          ? book.currentUser!
                                          : book.location!,
                                      style:
                                          Theme.of(context).textTheme.bodyText1)
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("ID: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  Text(book.id != null ? book.id! : "-",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          }
        }),
      ),
    );
  }
}
