// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Alles klar`
  String get dialog_ok_button {
    return Intl.message(
      'Alles klar',
      name: 'dialog_ok_button',
      desc: '',
      args: [],
    );
  }

  /// `Verbinde dich wieder mit dem Internet, um alle Funktionen der App nutzen zu können.`
  String get error_connectivity_desc {
    return Intl.message(
      'Verbinde dich wieder mit dem Internet, um alle Funktionen der App nutzen zu können.',
      name: 'error_connectivity_desc',
      desc: '',
      args: [],
    );
  }

  /// `Limitierte Funktionen`
  String get error_connectivity_title {
    return Intl.message(
      'Limitierte Funktionen',
      name: 'error_connectivity_title',
      desc: '',
      args: [],
    );
  }

  /// `Email ist ungültig!`
  String get error_invalid_mail {
    return Intl.message(
      'Email ist ungültig!',
      name: 'error_invalid_mail',
      desc: '',
      args: [],
    );
  }

  /// `Nutzername besitzt ungültige Zeichen!`
  String get error_invalid_username {
    return Intl.message(
      'Nutzername besitzt ungültige Zeichen!',
      name: 'error_invalid_username',
      desc: '',
      args: [],
    );
  }

  /// `Einloggen fehlgeschlagen. Bitte versuch es erneut`
  String get error_login_failed {
    return Intl.message(
      'Einloggen fehlgeschlagen. Bitte versuch es erneut',
      name: 'error_login_failed',
      desc: '',
      args: [],
    );
  }

  /// `Nutzername oder Passwort ungültig!`
  String get error_login_invalid_credentials {
    return Intl.message(
      'Nutzername oder Passwort ungültig!',
      name: 'error_login_invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Email wird bereits verwendet!`
  String get error_mail_taken {
    return Intl.message(
      'Email wird bereits verwendet!',
      name: 'error_mail_taken',
      desc: '',
      args: [],
    );
  }

  /// `Nutzername wird bereits verwendet!`
  String get error_username_taken {
    return Intl.message(
      'Nutzername wird bereits verwendet!',
      name: 'error_username_taken',
      desc: '',
      args: [],
    );
  }

  /// `Nutzername zu lang!`
  String get error_username_too_long {
    return Intl.message(
      'Nutzername zu lang!',
      name: 'error_username_too_long',
      desc: '',
      args: [],
    );
  }

  /// `Nutzername zu kurz!`
  String get error_username_too_short {
    return Intl.message(
      'Nutzername zu kurz!',
      name: 'error_username_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Buch-Infos`
  String get label_bookinfo {
    return Intl.message(
      'Buch-Infos',
      name: 'label_bookinfo',
      desc: '',
      args: [],
    );
  }

  /// `Buch nehmen`
  String get label_borrowbook {
    return Intl.message(
      'Buch nehmen',
      name: 'label_borrowbook',
      desc: '',
      args: [],
    );
  }

  /// `Schließen`
  String get label_close_sheet {
    return Intl.message(
      'Schließen',
      name: 'label_close_sheet',
      desc: '',
      args: [],
    );
  }

  /// `Password bestätigen`
  String get label_confirm_pw {
    return Intl.message(
      'Password bestätigen',
      name: 'label_confirm_pw',
      desc: '',
      args: [],
    );
  }

  /// `Buch spenden`
  String get label_donate_book {
    return Intl.message(
      'Buch spenden',
      name: 'label_donate_book',
      desc: '',
      args: [],
    );
  }

  /// `Buch ablegen`
  String get label_dropbook {
    return Intl.message(
      'Buch ablegen',
      name: 'label_dropbook',
      desc: '',
      args: [],
    );
  }

  /// `Inventar des Bücherschranks ist leer!`
  String get label_empty_bookcase {
    return Intl.message(
      'Inventar des Bücherschranks ist leer!',
      name: 'label_empty_bookcase',
      desc: '',
      args: [],
    );
  }

  /// `Ihr Inventar ist leer!`
  String get label_empty_user {
    return Intl.message(
      'Ihr Inventar ist leer!',
      name: 'label_empty_user',
      desc: '',
      args: [],
    );
  }

  /// `Hilfe`
  String get label_help {
    return Intl.message(
      'Hilfe',
      name: 'label_help',
      desc: '',
      args: [],
    );
  }

  /// `Dein Inventar`
  String get label_inventory {
    return Intl.message(
      'Dein Inventar',
      name: 'label_inventory',
      desc: '',
      args: [],
    );
  }

  /// `Lade...`
  String get label_loading {
    return Intl.message(
      'Lade...',
      name: 'label_loading',
      desc: '',
      args: [],
    );
  }

  /// `Anmelden`
  String get label_login_button {
    return Intl.message(
      'Anmelden',
      name: 'label_login_button',
      desc: '',
      args: [],
    );
  }

  /// `Ausloggen`
  String get label_logout {
    return Intl.message(
      'Ausloggen',
      name: 'label_logout',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get label_mail {
    return Intl.message(
      'E-mail',
      name: 'label_mail',
      desc: '',
      args: [],
    );
  }

  /// `Karte`
  String get label_map {
    return Intl.message(
      'Karte',
      name: 'label_map',
      desc: '',
      args: [],
    );
  }

  /// `Passwort`
  String get label_password {
    return Intl.message(
      'Passwort',
      name: 'label_password',
      desc: '',
      args: [],
    );
  }

  /// `Autor`
  String get label_scanner_autor {
    return Intl.message(
      'Autor',
      name: 'label_scanner_autor',
      desc: '',
      args: [],
    );
  }

  /// `Bücherschrank:`
  String get label_scanner_bookcase {
    return Intl.message(
      'Bücherschrank:',
      name: 'label_scanner_bookcase',
      desc: '',
      args: [],
    );
  }

  /// `Buchinformationen:`
  String get label_scanner_bookinfo {
    return Intl.message(
      'Buchinformationen:',
      name: 'label_scanner_bookinfo',
      desc: '',
      args: [],
    );
  }

  /// `Bestätigen`
  String get label_scanner_confirm {
    return Intl.message(
      'Bestätigen',
      name: 'label_scanner_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Entfernung: `
  String get label_scanner_distance {
    return Intl.message(
      'Entfernung: ',
      name: 'label_scanner_distance',
      desc: '',
      args: [],
    );
  }

  /// `Barcode scannen oder ISBN eingeben!`
  String get label_scanner_enterISBN {
    return Intl.message(
      'Barcode scannen oder ISBN eingeben!',
      name: 'label_scanner_enterISBN',
      desc: '',
      args: [],
    );
  }

  /// `Buch aus Inventar ablegen`
  String get label_scanner_fromInventory {
    return Intl.message(
      'Buch aus Inventar ablegen',
      name: 'label_scanner_fromInventory',
      desc: '',
      args: [],
    );
  }

  /// `Von wo soll das Buch hinzugefügt werden?`
  String get label_scanner_fromWhere {
    return Intl.message(
      'Von wo soll das Buch hinzugefügt werden?',
      name: 'label_scanner_fromWhere',
      desc: '',
      args: [],
    );
  }

  /// `Eckdaten des Buchs eingeben!`
  String get label_scanner_manual_explanation {
    return Intl.message(
      'Eckdaten des Buchs eingeben!',
      name: 'label_scanner_manual_explanation',
      desc: '',
      args: [],
    );
  }

  /// `Neues Buch ablegen`
  String get label_scanner_newBook {
    return Intl.message(
      'Neues Buch ablegen',
      name: 'label_scanner_newBook',
      desc: '',
      args: [],
    );
  }

  /// `Nicht Ihr Buch? Barcode erneut scannen bzw. korrekte ISBN eigeben.`
  String get label_scanner_notYourBook {
    return Intl.message(
      'Nicht Ihr Buch? Barcode erneut scannen bzw. korrekte ISBN eigeben.',
      name: 'label_scanner_notYourBook',
      desc: '',
      args: [],
    );
  }

  /// `Erscheinungsdatum`
  String get label_scanner_publishedDate {
    return Intl.message(
      'Erscheinungsdatum',
      name: 'label_scanner_publishedDate',
      desc: '',
      args: [],
    );
  }

  /// `Verlag`
  String get label_scanner_publisher {
    return Intl.message(
      'Verlag',
      name: 'label_scanner_publisher',
      desc: '',
      args: [],
    );
  }

  /// `Untertitel`
  String get label_scanner_subtitle {
    return Intl.message(
      'Untertitel',
      name: 'label_scanner_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Titel`
  String get label_scanner_title {
    return Intl.message(
      'Titel',
      name: 'label_scanner_title',
      desc: '',
      args: [],
    );
  }

  /// `Suchen`
  String get label_search {
    return Intl.message(
      'Suchen',
      name: 'label_search',
      desc: '',
      args: [],
    );
  }

  /// `Suchen...`
  String get label_searchprocess {
    return Intl.message(
      'Suchen...',
      name: 'label_searchprocess',
      desc: '',
      args: [],
    );
  }

  /// `Server derzeit nicht erreichbar. Bitte versuche es später`
  String get label_server_unavailable {
    return Intl.message(
      'Server derzeit nicht erreichbar. Bitte versuche es später',
      name: 'label_server_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Einstellungen`
  String get label_settings {
    return Intl.message(
      'Einstellungen',
      name: 'label_settings',
      desc: '',
      args: [],
    );
  }

  /// `Bücher anzeigen`
  String get label_show_books {
    return Intl.message(
      'Bücher anzeigen',
      name: 'label_show_books',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get label_signup_button {
    return Intl.message(
      'Signup',
      name: 'label_signup_button',
      desc: '',
      args: [],
    );
  }

  /// `Nutzername`
  String get label_username {
    return Intl.message(
      'Nutzername',
      name: 'label_username',
      desc: '',
      args: [],
    );
  }

  /// `Siehe Bücher`
  String get label_view_books {
    return Intl.message(
      'Siehe Bücher',
      name: 'label_view_books',
      desc: '',
      args: [],
    );
  }

  /// `Willkommen, {name}!`
  String label_welcome_user(Object name) {
    return Intl.message(
      'Willkommen, $name!',
      name: 'label_welcome_user',
      desc: '',
      args: [name],
    );
  }

  /// `Digitaler Bücherschrank`
  String get title {
    return Intl.message(
      'Digitaler Bücherschrank',
      name: 'title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<S> load(Locale locale) => S.load(locale);

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
