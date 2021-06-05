class Book {
  String? id;
  String? isbn;
  String? author;
  String? title;
  String? location;
  String? thumbnail;
  bool? addedManual;
  ManualBookData? manualBookData;
  // Nothing the Database would deliver when requesting a book, needs to be populated manually
  VolumeData? bookData;

  Book(
      {this.id,
      this.author,
      this.isbn,
      this.title,
      this.addedManual,
      this.manualBookData,
      this.location,
      this.thumbnail,
      this.bookData});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    author = json['author'];
    title = json['title'];
    addedManual = json["addedmanual"];
    isbn = json['isbn'];
    location = json['location'];
    thumbnail = json['thumbnail'];
    manualBookData = json['manualBookData'] != null
        ? new ManualBookData.fromJson(json['manualBookData'])
        : null;
    bookData = json['bookData'] != null
        ? new VolumeData.fromJson(json['bookInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['author'] = this.author;
    data['title'] = this.title;
    data['addedmanual'] = this.addedManual;
    if (this.manualBookData != null) {
      data['manualBookData'] = this.manualBookData!.toJson();
    }
    data['isbn'] = this.isbn;
    data['location'] = this.location;
    data['thumbnail'] = this.thumbnail;
    if (this.bookData != null) {
      data['bookData'] = this.bookData!.toJson();
    }
    return data;
  }
}

class ManualBookData {
  String? description;
  String? publisher;
  String? publishedDate;
  String? language;

  ManualBookData(
      {this.description, this.publisher, this.publishedDate, this.language});

  ManualBookData.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    publisher = json['publisher'];
    publishedDate = json['publishedDate'];
    language = json['language'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['description'] = this.description!;
    data['publisher'] = this.publisher!;
    data['publishedDate'] = this.publishedDate!;
    data['language'] = this.language!;

    return data;
  }
}

class VolumeData {
  String? publisher;
  String? language;
  String? image;
  String? titleLong;
  String? dimensions;
  DateTime? datePublished;
  List<dynamic>? authors;
  String? title;
  String? isbn13;
  String? msrp;
  String? binding;
  String? isbn;

  VolumeData({
    this.publisher,
    this.language,
    this.image,
    this.titleLong,
    this.dimensions,
    this.datePublished,
    this.authors,
    this.title,
    this.isbn13,
    this.msrp,
    this.binding,
    this.isbn,
  });

  @override
  String toString() {
    return 'VolumeData(publisher: $publisher, language: $language, image: $image, titleLong: $titleLong, dimensions: $dimensions, datePublished: $datePublished, authors: $authors, title: $title, isbn13: $isbn13, msrp: $msrp, binding: $binding, isbn: $isbn)';
  }

  factory VolumeData.fromJson(Map<String, dynamic> json) {
    return VolumeData(
      publisher: json['publisher'] as String?,
      language: json['language'] as String?,
      image: json['image'] as String?,
      titleLong: json['title_long'] as String?,
      dimensions: json['dimensions'] as String?,
      datePublished: json['date_published'] == null
          ? null
          : DateTime.parse(json['date_published'] as String),
      authors: json['authors'] as List<dynamic>?,
      title: json['title'] as String?,
      isbn13: json['isbn13'] as String?,
      msrp: json['msrp'] as String?,
      binding: json['binding'] as String?,
      isbn: json['isbn'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'publisher': publisher,
      'language': language,
      'image': image,
      'title_long': titleLong,
      'dimensions': dimensions,
      'date_published': datePublished?.toIso8601String(),
      'authors': authors,
      'title': title,
      'isbn13': isbn13,
      'msrp': msrp,
      'binding': binding,
      'isbn': isbn,
    };
  }
}
