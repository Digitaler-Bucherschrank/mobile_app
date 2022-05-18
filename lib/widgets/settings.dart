import 'package:digitaler_buecherschrank/api/api_service.dart';
import 'package:digitaler_buecherschrank/generated/l10n.dart';
import 'package:digitaler_buecherschrank/utils/shared_preferences.dart';
import 'package:digitaler_buecherschrank/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_radio_picker.dart';
import 'package:restart_app/restart_app.dart';

import 'login.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.label_settings),
      ),
      body: Center(
        child:
            // Settings UI with listTiles and dividers as well as titles
            ListView(
          children: <Widget>[
            SettingsDivider(title: S.current.label_settings_general),
            ListTile(
              title: Text(
                S.current.label_settings_language,
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
              leading: Icon(Icons.language, size: 35),
              onTap: () {
                SharedPrefs sp = SharedPrefs();

                const List<LangModel> languages = <LangModel>[
                  LangModel('System-Default', ''),
                  LangModel('English', 'en'),
                  LangModel('German', 'de')
                ];

                LangModel selectedLanguage = languages.firstWhere(
                    (element) => element.code == sp.language,
                    orElse: () => languages[0]);

                showMaterialRadioPicker<LangModel>(
                  context: context,
                  title: 'App-' + S.current.label_settings_language,
                  items: languages,
                  selectedItem: selectedLanguage,
                  onChanged: (value) => {
                    sp.language = value.code,
                    S.delegate.load(Locale(value.code)),
                    Restart.restartApp()
                  },
                );
              },
            ),
            ListTile(
              title: Text(
                S.current.label_settings_about,
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
              leading: Icon(Icons.info, size: 35),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                S.current.label_logout,
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
              leading: Icon(
                Icons.exit_to_app,
                size: 35,
              ),
              onTap: () {
                Utilities.logoutUser(null);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            ListTile(
              title: Text(
                "Delete Account",
                style: new TextStyle(
                  fontSize: 17.0,
                ),
              ),
              leading: Icon(
                Icons.delete_forever,
                size: 35,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return sureDeleteAccountPopUp(context);
                  },
                );
              },
            ),
            // ListTile with bigger leading Icon
          ],
        ),
      ),
    );
  }
}

class LangModel {
  const LangModel(this.name, this.code);
  final String code;
  final String name;

  @override
  String toString() => name;
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 16.0, left: 16.0, right: 22.0, bottom: 5.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          this.title,
          style: groupStyle(context),
        ),
      ),
    );
  }

  TextStyle groupStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
    );
  }
}

Dialog sureDeleteAccountPopUp(BuildContext context) {
  return Dialog(
    insetPadding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * 0.2,
      vertical: MediaQuery.of(context).size.height * 0.35,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Are you sure you want to delete your Account? Deleting your Account is not reversable!",
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return deleteAccountPopUp(context);
                },
              );
            },
            child: Text("Delete Account")),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    ),
  );
}

Dialog deleteAccountPopUp(BuildContext context) {
  return Dialog(
    child: FutureBuilder(
      future: ApiService().deleteUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Column(
            children: [
              Text("Deliting User-Data"),
              CircularProgressIndicator(),
            ],
          );
        } else if (snapshot.data) {
          return Text("Succes!");
        } else {
          return Text("Fail!");
        }
      },
    ),
  );
}
