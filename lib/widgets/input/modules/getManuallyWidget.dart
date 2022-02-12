import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/widgets/input/modules/popUps.dart';
import 'package:flutter/material.dart';

import '../../../models/book.dart';

class ManuallyWidget extends StatefulWidget {
  final double containerWidth;
  ManuallyWidget(this.containerWidth);

  @override
  _ManuallyWidgetState createState() => _ManuallyWidgetState(containerWidth);
}

class _ManuallyWidgetState extends State<ManuallyWidget> {
  double containerWidth;
  _ManuallyWidgetState(this.containerWidth);

  TextEditingController scannerText = new TextEditingController();
  TextEditingController titleText = new TextEditingController();
  TextEditingController authorText = new TextEditingController();
  ApiService apiService = new ApiService();
  ManualBookData _manualBook = new ManualBookData();
  VolumeData _bookData = new VolumeData();
  Book _book = new Book();
  TextStyle? textStyleNecessary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(S.of(context).label_scanner_manual_explanation,
                  style: Theme.of(context).textTheme.headline6),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: containerWidth,
                    child: TextField(
                      controller: scannerText,
                      decoration: InputDecoration(
                        labelText: "ISBN",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        fillColor: Theme.of(context).backgroundColor,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      onSubmitted: (val) async {
                        _book.isbn = val;
                        print(_book.isbn);
                        try {
                          var value = await apiService.getBookData([_book]);
                          setState(() {
                            titleText.text = "${value[0].title}";
                            print(titleText.text);
                            authorText.text = "${value[0].author}";
                            print(authorText.text);
                          });
                        } catch (e) {
                          print(e);
                          showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return ValidISBNPopUp();
                              }).then((value) {
                            setState(() {
                              scannerText.text = "";
                            });
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: containerWidth,
                    child: TextField(
                      controller: titleText,
                      decoration: InputDecoration(
                        labelText: "${S.of(context).label_scanner_title}*",
                        labelStyle: textStyleNecessary,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        fillColor: Theme.of(context).backgroundColor,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(50.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      onSubmitted: (val) {
                        _book.title = val;
                        print(_book.title);
                      },
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Container(
                width: containerWidth,
                child: TextField(
                  controller: authorText,
                  decoration: InputDecoration(
                    labelText: "${S.of(context).label_scanner_autor}*",
                    labelStyle: textStyleNecessary,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    fillColor: Theme.of(context).backgroundColor,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onSubmitted: (val) {
                    _book.author = val;
                    print(_book.author);
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Container(
                width: containerWidth,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: S.of(context).label_scanner_publisher,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    fillColor: Theme.of(context).backgroundColor,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onSubmitted: (val) {
                    _bookData.publisher = val;
                    print(_bookData.publisher);
                    _manualBook.publisher = val;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              // TODO: Natives Datumspicker verwenden ==> dann richtigen ISO String mitschicken
              Container(
                width: containerWidth,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: S.of(context).label_scanner_publishedDate,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    fillColor: Theme.of(context).backgroundColor,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onSubmitted: (val) {
                    _bookData.datePublished = DateTime.tryParse(val);
                    print(_book.bookData!.datePublished);
                    _manualBook.publishedDate = val;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Container(
                width: containerWidth,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: S.of(context).label_settings_language,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    fillColor: Theme.of(context).backgroundColor,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onSubmitted: (val) {
                    _bookData.language = val;
                    print(_bookData.language);
                    _manualBook.language = val;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 5)),
              Container(
                width: containerWidth,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: S.of(context).label_scanner_description,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    fillColor: Theme.of(context).backgroundColor,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onSubmitted: (val) {
                    _manualBook.description = val;
                    print(_manualBook.description);
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                S.of(context).label_scanner_necessary,
                style: textStyleNecessary,
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
            ],
          ),
        ),
        ElevatedButton(
          style: Theme.of(context).outlinedButtonTheme.style,
          onPressed: () {
            _book.bookData = _bookData;
            print(_book);
            if (_book.author == null || _book.title == null) {
              setState(() {
                textStyleNecessary = TextStyle(color: Colors.red);
              });
            } else {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return DonatePopUp(
                    book: _book,
                    manual: true,
                    data: _manualBook,
                  );
                },
              ).then((value) => Navigator.pop(context));
            }
          },
          child: Text(
            S.of(context).label_scanner_confirm,
          ),
        ),
      ],
    );
  }
}
