// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "error_invalid_mail" : MessageLookupByLibrary.simpleMessage("Email ist ungültig!"),
    "error_invalid_username" : MessageLookupByLibrary.simpleMessage("Nutzername besitzt ungültige Zeichen!"),
    "error_login_failed" : MessageLookupByLibrary.simpleMessage("Einloggen fehlgeschlagen. Bitte versuch es erneut"),
    "error_mail_taken" : MessageLookupByLibrary.simpleMessage("Email wird bereits verwendet."),
    "error_username_taken" : MessageLookupByLibrary.simpleMessage("Nutzername wird bereits verwendet"),
    "error_username_too_long" : MessageLookupByLibrary.simpleMessage("Nutzername zu lang!"),
    "error_username_too_short" : MessageLookupByLibrary.simpleMessage("Nutzername zu kurz!"),
    "label_bookinfo" : MessageLookupByLibrary.simpleMessage("Buch-Infos"),
    "label_borrowbook" : MessageLookupByLibrary.simpleMessage("Buch mitnehmen"),
    "label_confirm_pw" : MessageLookupByLibrary.simpleMessage("Password bestätigen"),
    "label_dropbook" : MessageLookupByLibrary.simpleMessage("Buch ablegen"),
    "label_loading" : MessageLookupByLibrary.simpleMessage("Loading..."),
    "label_login_button" : MessageLookupByLibrary.simpleMessage("Anmelden"),
    "label_mail" : MessageLookupByLibrary.simpleMessage("Email"),
    "label_map" : MessageLookupByLibrary.simpleMessage("Karte"),
    "label_password" : MessageLookupByLibrary.simpleMessage("Passwort"),
    "label_scanner_autor" : MessageLookupByLibrary.simpleMessage("Autor"),
    "label_scanner_bookcase" : MessageLookupByLibrary.simpleMessage("Bücherschrank:"),
    "label_scanner_bookinfo" : MessageLookupByLibrary.simpleMessage("Buchinformationen:"),
    "label_scanner_confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "label_scanner_distance" : MessageLookupByLibrary.simpleMessage("Entfernung: "),
    "label_scanner_enterISBN" : MessageLookupByLibrary.simpleMessage("Barcode scannen oder ISBN eingeben!"),
    "label_scanner_fromInventory" : MessageLookupByLibrary.simpleMessage("Buch aus Inventar ablegen"),
    "label_scanner_fromWhere" : MessageLookupByLibrary.simpleMessage("Von wo soll das Buch hinzugefügt werden?"),
    "label_scanner_newBook" : MessageLookupByLibrary.simpleMessage("Neues Buch ablegen"),
    "label_scanner_notYourBook" : MessageLookupByLibrary.simpleMessage("Nicht Ihr Buch? Barcode erneut scannen bzw. korrekte ISBN eigeben"),
    "label_scanner_publishedDate" : MessageLookupByLibrary.simpleMessage("Erscheinungsdatum"),
    "label_scanner_publisher" : MessageLookupByLibrary.simpleMessage("Verlag"),
    "label_scanner_subtitle" : MessageLookupByLibrary.simpleMessage("Untertitel"),
    "label_scanner_title" : MessageLookupByLibrary.simpleMessage("Titel"),
    "label_search" : MessageLookupByLibrary.simpleMessage("Suchen"),
    "label_searchprocess" : MessageLookupByLibrary.simpleMessage("Suchen..."),
    "label_server_unavailable" : MessageLookupByLibrary.simpleMessage("Server derzeit nicht erreichbar. Bitte versuche es später"),
    "label_signup_button" : MessageLookupByLibrary.simpleMessage("Signup"),
    "label_username" : MessageLookupByLibrary.simpleMessage("Nutzername"),
    "title" : MessageLookupByLibrary.simpleMessage("Digitaler Bücherschrank")
  };
}
