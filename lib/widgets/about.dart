import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/l10n.dart';

Future<void> launch(_url) async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Column(
        children: [
          Card(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    "assets/SPTGLogos/Logo_Digitechnikum.png",
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: S.of(context).label_about_digitechnikum,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color),
                        ),
                        new TextSpan(
                          text: "digitechnikum.de",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                Uri.parse("https://digitechnikum.de/"),
                              );
                            },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(
                    "assets/SPTGLogos/SPTG_Logo.png",
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: S.of(context).label_about_SPTG,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color),
                        ),
                        new TextSpan(
                          text: "sptg.de",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch(
                                Uri.parse("https://sptg.de/"),
                              );
                            },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
