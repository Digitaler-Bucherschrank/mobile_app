// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "label_bookinfo": MessageLookupByLibrary.simpleMessage("Book-Infos"),
        "label_borrowbook": MessageLookupByLibrary.simpleMessage("Take Book"),
        "label_dropbook": MessageLookupByLibrary.simpleMessage("Return Book"),
        "label_loading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "label_map": MessageLookupByLibrary.simpleMessage("Map"),
        "label_scanner_autor": MessageLookupByLibrary.simpleMessage("Author"),
        "label_scanner_bookcase":
            MessageLookupByLibrary.simpleMessage("Bookcase:"),
        "label_scanner_bookinfo":
            MessageLookupByLibrary.simpleMessage("Book Information:"),
        "label_scanner_confirm":
            MessageLookupByLibrary.simpleMessage("Confirm"),
        "label_scanner_distance":
            MessageLookupByLibrary.simpleMessage("Distance: "),
        "label_scanner_enterISBN": MessageLookupByLibrary.simpleMessage(
            "Scann Barcode or enter ISBN!"),
        "label_scanner_fromInventory":
            MessageLookupByLibrary.simpleMessage("Add book from inventory"),
        "label_scanner_fromWhere": MessageLookupByLibrary.simpleMessage(
            "Where should the book be added from?"),
        "label_scanner_newBook":
            MessageLookupByLibrary.simpleMessage("Add new book"),
        "label_scanner_notYourBook": MessageLookupByLibrary.simpleMessage(
            "Not your Book? Scann the barcode again or enter the correct isbn."),
        "label_scanner_publishedDate":
            MessageLookupByLibrary.simpleMessage("Date of publishment"),
        "label_scanner_publisher":
            MessageLookupByLibrary.simpleMessage("Publisher"),
        "label_scanner_subtitle":
            MessageLookupByLibrary.simpleMessage("Subtitle"),
        "label_scanner_title": MessageLookupByLibrary.simpleMessage("Title"),
        "label_search": MessageLookupByLibrary.simpleMessage("Search"),
        "label_searchprocess":
            MessageLookupByLibrary.simpleMessage("Searching...\n"),
        "title": MessageLookupByLibrary.simpleMessage("Digital Bookcase")
      };
}
