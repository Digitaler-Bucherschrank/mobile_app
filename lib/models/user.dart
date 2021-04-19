class User {
  String? id;
  String? username;
  String? mail;
  Tokens? tokens;

  User({this.id, this.username, this.mail, this.tokens});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    mail = json['mail'];
    tokens =
    json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['mail'] = this.mail;
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }
}

class Tokens {
  String? client;
  AccessToken? accessToken;
  RefreshToken? refreshToken;

  Tokens({this.client, this.accessToken, this.refreshToken});

  Tokens.fromJson(Map<String, dynamic> json) {
    client = json['client'];
    accessToken = json['accessToken'] != null
        ? new AccessToken.fromJson(json['accessToken'])
        : null;
    refreshToken = json['refreshToken'] != null
        ? new RefreshToken.fromJson(json['refreshToken'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client'] = this.client;
    if (this.accessToken != null) {
      data['accessToken'] = this.accessToken!.toJson();
    }
    if (this.refreshToken != null) {
      data['refreshToken'] = this.refreshToken!.toJson();
    }
    return data;
  }
}

class AccessToken {
  String? token;

  AccessToken({this.token});

  AccessToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class RefreshToken {
  String? token;

  RefreshToken({this.token});

  RefreshToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
