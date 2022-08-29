import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/main.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/widgets/dataProtection/dataProtectionText.dart';
import 'package:digitaler_buecherschrank/widgets/intro.dart';
import 'package:digitaler_buecherschrank/widgets/login.dart';
import 'package:flutter/material.dart';

class DataProtectionPage extends StatefulWidget {
  const DataProtectionPage({Key? key}) : super(key: key);

  @override
  DataProtectionPageState createState() => DataProtectionPageState();
}

class DataProtectionPageState extends State<DataProtectionPage> {
  bool checkBoxValue = false;
  bool makeColorRed = false;

  @override
  Widget build(BuildContext context) {
    var _sp = SharedPrefs();
    var _isLoggedIn = _sp.isLoggedIn;
    var _acceptedDataDeclaration = _sp.acceptedDataDeclaration;
    var _finishedIntro = _sp.finishedIntro;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).label_welcome),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(indruduction),
                Text(
                  elucidationTitle,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text(elucidation),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: checkBoxValue,
                      onChanged: (val) {
                        setState(() {
                          checkBoxValue = val!;
                        });
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        S.of(context).label_read_data_protection,
                        style: TextStyle(
                            color: makeColorRed
                                ? Colors.redAccent
                                : Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                    onPressed: () {
                      if (checkBoxValue) {
                        SharedPrefs().acceptedDataDeclaration = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _isLoggedIn
                                ? _finishedIntro
                                    ? MyHomePage()
                                    : IntroScreen()
                                : LoginScreen(),
                          ),
                        );
                      } else {
                        setState(() {
                          makeColorRed = true;
                        });
                      }
                    },
                    child: Text(S.of(context).label_accept))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
