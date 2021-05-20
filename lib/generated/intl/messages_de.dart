// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "label_bookinfo": MessageLookupByLibrary.simpleMessage("Buch-Infos"),
        "label_borrowbook":
            MessageLookupByLibrary.simpleMessage("Buch mitnehmen"),
        "label_dropbook": MessageLookupByLibrary.simpleMessage("Buch ablegen"),
        "label_loading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "label_map": MessageLookupByLibrary.simpleMessage("Karte"),
        "label_scanner_autor": MessageLookupByLibrary.simpleMessage("Autor"),
        "label_scanner_bookcase":
            MessageLookupByLibrary.simpleMessage("Bücherschrank:"),
        "label_scanner_bookinfo":
            MessageLookupByLibrary.simpleMessage("Buchinformationen:"),
        "label_scanner_confirm":
            MessageLookupByLibrary.simpleMessage("Confirm"),
        "label_scanner_distance":
            MessageLookupByLibrary.simpleMessage("Entfernung: "),
        "label_scanner_enterISBN": MessageLookupByLibrary.simpleMessage(
            "Barcode scannen oder ISBN eingeben!"),
        "label_scanner_fromInventory":
            MessageLookupByLibrary.simpleMessage("Buch aus Inventar ablegen"),
        "label_scanner_fromWhere": MessageLookupByLibrary.simpleMessage(
            "Von wo soll das Buch hinzugefügt werden?"),
        "label_scanner_newBook":
            MessageLookupByLibrary.simpleMessage("Neues Buch ablegen"),
        "label_scanner_notYourBook": MessageLookupByLibrary.simpleMessage(
            "Nicht Ihr Buch? Barcode erneut scannen bzw. korrekte ISBN eigeben"),
        "label_scanner_publishedDate":
            MessageLookupByLibrary.simpleMessage("Erscheinungsdatum"),
        "label_scanner_publisher":
            MessageLookupByLibrary.simpleMessage("Verlag"),
        "label_scanner_subtitle":
            MessageLookupByLibrary.simpleMessage("Untertitel"),
        "label_scanner_title": MessageLookupByLibrary.simpleMessage("Titel"),
        "label_search": MessageLookupByLibrary.simpleMessage("Suchen"),
        "label_searchprocess":
            MessageLookupByLibrary.simpleMessage("Suchen..."),
        "title": MessageLookupByLibrary.simpleMessage("Digitaler Bücherschrank")
      };
}
