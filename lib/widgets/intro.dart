import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'login.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // TODO: Translate text into English
    List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        title: S.of(context).label_welcome_to,
        body: S.of(context).label_bookcase_now_digital,
        decoration: PageDecoration(
            imageFlex: 3,
            bodyFlex: 2,
            imageAlignment: Alignment.bottomCenter,
            imagePadding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1)),
        image: Center(
            child: isDarkMode
                ? ColorFiltered(
                    colorFilter: ColorFilter.matrix([
                      -1,
                      0,
                      0,
                      0,
                      255,
                      0,
                      -1,
                      0,
                      0,
                      255,
                      0,
                      0,
                      -1,
                      0,
                      255,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child:
                        Image.asset("assets/intro/intro1.png", height: 300.0),
                  )
                : Image.asset("assets/intro/intro1.png", height: 300.0)),
      ),
      PageViewModel(
        title: S.of(context).label_functionality,
        body: S.of(context).label_functionality_text,
        decoration: PageDecoration(
            imageFlex: 3,
            bodyFlex: 2,
            imageAlignment: Alignment.bottomCenter,
            imagePadding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1)),
        image: Center(
            child: isDarkMode
                ? ColorFiltered(
                    colorFilter: ColorFilter.matrix([
                      -1,
                      0,
                      0,
                      0,
                      255,
                      0,
                      -1,
                      0,
                      0,
                      255,
                      0,
                      0,
                      -1,
                      0,
                      255,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child:
                        Image.asset("assets/intro/intro2.png", height: 300.0),
                  )
                : Image.asset("assets/intro/intro2.png", height: 300.0)),
      ),
      PageViewModel(
        title: S.of(context).label_online_and_offline,
        body: S.of(context).label_online_and_offline_text,
        decoration: PageDecoration(
            imageFlex: 3,
            bodyFlex: 2,
            imageAlignment: Alignment.bottomCenter,
            imagePadding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1)),
        image: Center(
            child: Image.asset("assets/intro/intro3.png", height: 300.0)),
      ),
      PageViewModel(
        title: S.of(context).label_we_depend_on_you,
        body: S.of(context).label_we_depend_on_you_text,
        decoration: PageDecoration(
            imageFlex: 3,
            bodyFlex: 2,
            imageAlignment: Alignment.bottomCenter,
            contentMargin: EdgeInsets.all(16.0) +
                EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.15),
            imagePadding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                left: MediaQuery.of(context).size.width * 0.05)),
        image: Center(
            child: isDarkMode
                ? ColorFiltered(
                    colorFilter: ColorFilter.matrix([
                      -1,
                      0,
                      0,
                      0,
                      255,
                      0,
                      -1,
                      0,
                      0,
                      255,
                      0,
                      0,
                      -1,
                      0,
                      255,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child:
                        Image.asset("assets/intro/intro4.png", height: 300.0),
                  )
                : Image.asset("assets/intro/intro4.png", height: 300.0)),
      )
    ];

    return IntroductionScreen(
      pages: listPagesViewModel,
      done: Text(S.of(context).label_done,
          style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      onDone: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
        SharedPrefs().finishedIntro = true;
      },
    );
  }
}
