import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/widgets/intro.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).label_welcome),
      ),
      body: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Text("hier könnte ihre Datenschutzerklärung stehen!"),
            Padding(padding: EdgeInsets.only(top: 200)),
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
                    )),
              ],
            ),
            OutlinedButton(
                onPressed: () {
                  if (checkBoxValue) {
                    SharedPrefs().acceptedDataDeclaration = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IntroScreen(),
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
    );
  }
}
