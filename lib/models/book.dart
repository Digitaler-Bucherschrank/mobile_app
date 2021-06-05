import 'dart:convert';

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
  BookData? bookData;

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
        ? new BookData.fromJson(json['bookInfo'])
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

// Google Books API BookData
class BookData {
  String? id;
  String? selfLink;
  VolumeInfo? volumeInfo;

  BookData({this.id, this.selfLink, this.volumeInfo});

  BookData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selfLink = json['selfLink'];
    volumeInfo = json['volumeInfo'] != null
        ? new VolumeInfo.fromJson(json['volumeInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['selfLink'] = this.selfLink;
    if (this.volumeInfo != null) {
      data['volumeInfo'] = this.volumeInfo!.toJson();
    }
    return data;
  }
}

class VolumeInfo {
  String? title;
  String? subtitle;
  List<dynamic>? authors;
  String? publisher;
  String? publishedDate;
  String? description;
  int? pageCount;
  String? mainCategory;
  List<dynamic>? categories;
  int? averageRating;
  int? ratingsCount;
  String? contentVersion;
  ImageLinks? imageLinks;
  String? language;
  String? previewLink;
  String? infoLink;
  String? canonicalVolumeLink;

  VolumeInfo(
      {this.title,
      this.subtitle,
      this.authors,
      this.publisher,
      this.publishedDate,
      this.description,
      this.pageCount,
      this.mainCategory,
      this.categories,
      this.averageRating,
      this.ratingsCount,
      this.contentVersion,
      this.imageLinks,
      this.language,
      this.previewLink,
      this.infoLink,
      this.canonicalVolumeLink});

  VolumeInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    authors = json['authors'];
    publisher = json['publisher'];
    publishedDate = json['publishedDate'];
    description = json['description'];
    pageCount = json['pageCount'];
    mainCategory = json['mainCategory'];
    categories = json['categories'];
    averageRating = json['averageRating'];
    ratingsCount = json['ratingsCount'];
    contentVersion = json['contentVersion'];
    imageLinks = json['imageLinks'] != null
        ? new ImageLinks.fromJson(json['imageLinks'])
        : null;
    language = json['language'];
    previewLink = json['previewLink'];
    infoLink = json['infoLink'];
    canonicalVolumeLink = json['canonicalVolumeLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['authors'] = this.authors;
    data['publisher'] = this.publisher;
    data['publishedDate'] = this.publishedDate;
    data['description'] = this.description;
    data['pageCount'] = this.pageCount;
    data['mainCategory'] = this.mainCategory;
    data['categories'] = this.categories;
    data['averageRating'] = this.averageRating;
    data['ratingsCount'] = this.ratingsCount;
    data['contentVersion'] = this.contentVersion;
    if (this.imageLinks != null) {
      data['imageLinks'] = this.imageLinks!.toJson();
    }
    data['language'] = this.language;
    data['previewLink'] = this.previewLink;
    data['infoLink'] = this.infoLink;
    data['canonicalVolumeLink'] = this.canonicalVolumeLink;
    return data;
  }
}

class ImageLinks {
  String? thumbnail;
  String? large;
  String? extraLarge;

  ImageLinks({this.thumbnail, this.large, this.extraLarge});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    large = json['large'];
    extraLarge = json['extraLarge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['large'] = this.large;
    data['extraLarge'] = this.extraLarge;
    return data;
  }
}
