class PhotoModel {
  String description;
  String altDescription;
  String id;
  UrlsModel urls;
  AuthorModel authorName;

  PhotoModel({
    this.altDescription,
    this.description,
    this.id,
    this.urls,
    this.authorName,
  });

  factory PhotoModel.fromMap(Map<String, dynamic> jsonData) {
    return PhotoModel(
      urls: UrlsModel.fromMap(jsonData['urls']),
      authorName: AuthorModel.fromMap(jsonData['user']),
      altDescription: jsonData['alt_description'],
      description: jsonData['description'],
      id: jsonData['id'],
    );
  }
}

class AuthorModel {
  String name;
  AuthorModel({
    this.name,
  });

  factory AuthorModel.fromMap(Map<String, dynamic> jsonData) {
    return AuthorModel(
      name: jsonData['name'],
    );
  }
}

class UrlsModel {
  String small;
  String raw;
  String full;

  UrlsModel({
    this.small,
    this.raw,
    this.full,
  });

  factory UrlsModel.fromMap(Map<String, dynamic> jsonData) {
    return UrlsModel(
      small: jsonData['small'],
      raw: jsonData['raw'],
      full: jsonData['full'],
    );
  }
}
