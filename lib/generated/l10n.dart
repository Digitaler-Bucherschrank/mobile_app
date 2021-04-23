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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
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
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
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

  /// `Buch mitnehmen`
  String get label_borrowbook {
    return Intl.message(
      'Buch mitnehmen',
      name: 'label_borrowbook',
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

  /// `Karte`
  String get label_map {
    return Intl.message(
      'Karte',
      name: 'label_map',
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