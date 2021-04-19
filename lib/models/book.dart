class Book {
  String? id;
  String? googleBooksID;
  String? author;
  String? title;
  String? location;
  String? thumbnail;
  BookData? bookData;

  Book(
      {this.id,
        this.googleBooksID,
        this.author,
        this.title,
        this.location,
        this.thumbnail,
        this.bookData});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    googleBooksID = json['googleBooksID'];
    author = json['author'];
    title = json['title'];
    location = json['location'];
    thumbnail = json['thumbnail'];
    bookData = json['bookData'] != null
        ? new BookData.fromJson(json['bookData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['googleBooksID'] = this.googleBooksID;
    data['author'] = this.author;
    data['title'] = this.title;
    data['location'] = this.location;
    data['thumbnail'] = this.thumbnail;
    if (this.bookData != null) {
      data['bookData'] = this.bookData!.toJson();
    }
    return data;
  }
}

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
  List<String>? authors;
  String? publisher;
  String? publishedDate;
  String? description;
  int? pageCount;
  String? mainCategory;
  List<String>? categories;
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
    authors = json['authors'].cast<String>();
    publisher = json['publisher'];
    publishedDate = json['publishedDate'];
    description = json['description'];
    pageCount = json['pageCount'];
    mainCategory = json['mainCategory'];
    categories = json['categories'].cast<String>();
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
