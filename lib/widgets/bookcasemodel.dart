import 'dart:ui';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/models/book_case.dart';
import 'package:digitaler_buecherschrank/widgets/input/donatebook.dart';
import 'package:digitaler_buecherschrank/widgets/input/returnbook.dart';
import 'package:digitaler_buecherschrank/widgets/input/showbooks.dart';
import 'package:flutter/material.dart';

class BookCaseModel extends StatelessWidget {
  final BookCase bookcase;

  BookCaseModel(this.bookcase);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // TODO: Fix borders
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: BackdropFilter(
        filter: new ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          color: Theme.of(context).cardColor.withOpacity(0.6),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '${bookcase.title}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      '${bookcase.address}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.grey.shade600),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.library_books),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowBooks(bookcase)),
                        );
                      },
                      title: Text(S.of(context).label_show_books),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.arrow_downward),
                      onTap: () {
                        print('${bookcase.iId!.oid}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReturnBook(bookcase)),
                        );
                      },
                      title: Text(S.of(context).label_dropbook),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.volunteer_activism),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DonateWidget('${bookcase.iId!.oid}')),
                        );
                      },
                      title: Text(S.of(context).label_donate_book),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
