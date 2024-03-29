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

  /// `Bitte starten Sie die App neu und versuchen es später noch einmal.\n`
  String get error_maintenance_desc {
    return Intl.message(
      'Bitte starten Sie die App neu und versuchen es später noch einmal.\n',
      name: 'error_maintenance_desc',
      desc: '',
      args: [],
    );
  }

  /// `Der Server ist derzeit in Wartung!`
  String get error_maintenance_title {
    return Intl.message(
      'Der Server ist derzeit in Wartung!',
      name: 'error_maintenance_title',
      desc: '',
      args: [],
    );
  }

  /// `Fehler! Versuchen Sie es später nochmal.`
  String get error_try_later {
    return Intl.message(
      'Fehler! Versuchen Sie es später nochmal.',
      name: 'error_try_later',
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

  /// `Die Arbeiten an dieser App begannen im Oktober 2020 im Zuge der zweiten Generation des Digitechnikums, einem Projekt der der Stiftung Polytechnische Gesellschaft. Innerhalb der ein jähren Laufzeit des Digitechnikums entwickelte das vierköpfige Team einen funktionstüchtigen Prototypen. Mehr zum Digitechnikum finden Sie unter dem folgenden Link: `
  String get label_about_digitechnikum {
    return Intl.message(
      'Die Arbeiten an dieser App begannen im Oktober 2020 im Zuge der zweiten Generation des Digitechnikums, einem Projekt der der Stiftung Polytechnische Gesellschaft. Innerhalb der ein jähren Laufzeit des Digitechnikums entwickelte das vierköpfige Team einen funktionstüchtigen Prototypen. Mehr zum Digitechnikum finden Sie unter dem folgenden Link: ',
      name: 'label_about_digitechnikum',
      desc: '',
      args: [],
    );
  }

  /// `Nach dem Ende der zweiten Generation des Digitechnikums wurde die Entwicklung der App fortgeführt. Dabei unterstützte die Stiftung Polytechnische Gesellschaft das Team bei der Erstellung der Datenschutzerklärung und auf finanzieller Ebene. Mehr Informationen über die SPTG finden Sie unter dem folgenden Link: `
  String get label_about_SPTG {
    return Intl.message(
      'Nach dem Ende der zweiten Generation des Digitechnikums wurde die Entwicklung der App fortgeführt. Dabei unterstützte die Stiftung Polytechnische Gesellschaft das Team bei der Erstellung der Datenschutzerklärung und auf finanzieller Ebene. Mehr Informationen über die SPTG finden Sie unter dem folgenden Link: ',
      name: 'label_about_SPTG',
      desc: '',
      args: [],
    );
  }

  /// `Akzeptieren`
  String get label_accept {
    return Intl.message(
      'Akzeptieren',
      name: 'label_accept',
      desc: '',
      args: [],
    );
  }

  /// `Die offenen Bücherschränke - nun digital`
  String get label_bookcase_now_digital {
    return Intl.message(
      'Die offenen Bücherschränke - nun digital',
      name: 'label_bookcase_now_digital',
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

  /// `Manuell eingetragen:`
  String get label_book_info_addedManual {
    return Intl.message(
      'Manuell eingetragen:',
      name: 'label_book_info_addedManual',
      desc: '',
      args: [],
    );
  }

  /// `Einband:`
  String get label_book_info_binding {
    return Intl.message(
      'Einband:',
      name: 'label_book_info_binding',
      desc: '',
      args: [],
    );
  }

  /// `Erschienen:`
  String get label_book_info_datePublished {
    return Intl.message(
      'Erschienen:',
      name: 'label_book_info_datePublished',
      desc: '',
      args: [],
    );
  }

  /// `Dimensionen:`
  String get label_book_info_dimensions {
    return Intl.message(
      'Dimensionen:',
      name: 'label_book_info_dimensions',
      desc: '',
      args: [],
    );
  }

  /// `ISBN 13:`
  String get label_book_info_ISBN13 {
    return Intl.message(
      'ISBN 13:',
      name: 'label_book_info_ISBN13',
      desc: '',
      args: [],
    );
  }

  /// `Sprache:`
  String get label_book_info_language {
    return Intl.message(
      'Sprache:',
      name: 'label_book_info_language',
      desc: '',
      args: [],
    );
  }

  /// `Ort:`
  String get label_book_info_location {
    return Intl.message(
      'Ort:',
      name: 'label_book_info_location',
      desc: '',
      args: [],
    );
  }

  /// `Verlag:`
  String get label_book_info_publisher {
    return Intl.message(
      'Verlag:',
      name: 'label_book_info_publisher',
      desc: '',
      args: [],
    );
  }

  /// `Nutzer:`
  String get label_book_info_user {
    return Intl.message(
      'Nutzer:',
      name: 'label_book_info_user',
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

  /// `Abbrechen`
  String get label_cancel {
    return Intl.message(
      'Abbrechen',
      name: 'label_cancel',
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

  /// `Account löschen`
  String get label_delete_account {
    return Intl.message(
      'Account löschen',
      name: 'label_delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Account wird gelöscht...`
  String get label_deleting_account {
    return Intl.message(
      'Account wird gelöscht...',
      name: 'label_deleting_account',
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

  /// `Fertig!`
  String get label_done {
    return Intl.message(
      'Fertig!',
      name: 'label_done',
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

  /// `Funktionsweise`
  String get label_functionality {
    return Intl.message(
      'Funktionsweise',
      name: 'label_functionality',
      desc: '',
      args: [],
    );
  }

  /// `In dieser App kannst du die verschiedenen offenen Bücherschränke deiner Stadt kompakt auf einer Karte finden. Du kannst die jeweiligen Inventare betrachten, Bücher ausleihen & Bücher spenden bzw. zurücklegen!`
  String get label_functionality_text {
    return Intl.message(
      'In dieser App kannst du die verschiedenen offenen Bücherschränke deiner Stadt kompakt auf einer Karte finden. Du kannst die jeweiligen Inventare betrachten, Bücher ausleihen & Bücher spenden bzw. zurücklegen!',
      name: 'label_functionality_text',
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

  /// `Prüfe ISBN...`
  String get label_isbn_test {
    return Intl.message(
      'Prüfe ISBN...',
      name: 'label_isbn_test',
      desc: '',
      args: [],
    );
  }

  /// `ISBN ist nicht valide!`
  String get label_isbn_unvalid {
    return Intl.message(
      'ISBN ist nicht valide!',
      name: 'label_isbn_unvalid',
      desc: '',
      args: [],
    );
  }

  /// `ISBN ist valide!`
  String get label_isbn_valid {
    return Intl.message(
      'ISBN ist valide!',
      name: 'label_isbn_valid',
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

  /// `Sowohl online als auch offline!`
  String get label_online_and_offline {
    return Intl.message(
      'Sowohl online als auch offline!',
      name: 'label_online_and_offline',
      desc: '',
      args: [],
    );
  }

  /// `Die App kannst du sowohl offline als auch online nutzen. Funktionen wie das Betrachten der Inventare funktionieren nur im Online-Modus, allerdings funktionieren Funktionen wie die Karte auch ohne Internet.`
  String get label_online_and_offline_text {
    return Intl.message(
      'Die App kannst du sowohl offline als auch online nutzen. Funktionen wie das Betrachten der Inventare funktionieren nur im Online-Modus, allerdings funktionieren Funktionen wie die Karte auch ohne Internet.',
      name: 'label_online_and_offline_text',
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

  /// `Ich habe die Datenschutzerklärung gelesen und verstanden!`
  String get label_read_data_protection {
    return Intl.message(
      'Ich habe die Datenschutzerklärung gelesen und verstanden!',
      name: 'label_read_data_protection',
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

  /// `Beschreibung`
  String get label_scanner_description {
    return Intl.message(
      'Beschreibung',
      name: 'label_scanner_description',
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

  /// `*Zwingend notwendig zur Verarbeitung.`
  String get label_scanner_necessary {
    return Intl.message(
      '*Zwingend notwendig zur Verarbeitung.',
      name: 'label_scanner_necessary',
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

  /// `Fertig!`
  String get label_scanner_success {
    return Intl.message(
      'Fertig!',
      name: 'label_scanner_success',
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

  /// `Über`
  String get label_settings_about {
    return Intl.message(
      'Über',
      name: 'label_settings_about',
      desc: '',
      args: [],
    );
  }

  /// `Allgemein`
  String get label_settings_general {
    return Intl.message(
      'Allgemein',
      name: 'label_settings_general',
      desc: '',
      args: [],
    );
  }

  /// `Sprache`
  String get label_settings_language {
    return Intl.message(
      'Sprache',
      name: 'label_settings_language',
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

  /// `Sind Sie sich sicher, dass sie den Account löschen wollen? Die Löschung kann nicht rückgängig gemacht werden.`
  String get label_sure_delete_account {
    return Intl.message(
      'Sind Sie sich sicher, dass sie den Account löschen wollen? Die Löschung kann nicht rückgängig gemacht werden.',
      name: 'label_sure_delete_account',
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

  /// `Wir sind auf dich angewiesen!`
  String get label_we_depend_on_you {
    return Intl.message(
      'Wir sind auf dich angewiesen!',
      name: 'label_we_depend_on_you',
      desc: '',
      args: [],
    );
  }

  /// `Diese App lebt davon, dass so viele Bücherschränkler*innen wie möglich diese nutzen, damit die bei uns verfügbaren Informationen aktuell & nützlich sind. Daher bitten wir dich: Spread the Word! Je mehr diese App nutzen, desto mehr hat jeder davon.`
  String get label_we_depend_on_you_text {
    return Intl.message(
      'Diese App lebt davon, dass so viele Bücherschränkler*innen wie möglich diese nutzen, damit die bei uns verfügbaren Informationen aktuell & nützlich sind. Daher bitten wir dich: Spread the Word! Je mehr diese App nutzen, desto mehr hat jeder davon.',
      name: 'label_we_depend_on_you_text',
      desc: '',
      args: [],
    );
  }

  /// `Willkommen`
  String get label_welcome {
    return Intl.message(
      'Willkommen',
      name: 'label_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Willkommen zum Projekt Digitaler Bücherschrank!`
  String get label_welcome_to {
    return Intl.message(
      'Willkommen zum Projekt Digitaler Bücherschrank!',
      name: 'label_welcome_to',
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
