class User {
  String? id;
  String? username;
  Tokens? tokens;

  User({this.id, this.username, this.tokens});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    tokens =
        json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }
}

class Tokens {
  AccessToken? accessToken;
  RefreshToken? refreshToken;

  Tokens({ this.accessToken, this.refreshToken});

  Tokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'] != null
        ? new AccessToken.fromJson(json['accessToken'])
        : null;
    refreshToken = json['refreshToken'] != null
        ? new RefreshToken.fromJson(json['refreshToken'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  int? iat;

  AccessToken({this.token, this.iat});

  AccessToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    iat = json['iat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['iat'] = this.iat;
    return data;
  }
}

class RefreshToken {
  String? token;
  int? iat;

  RefreshToken({this.token, this.iat});

  RefreshToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    iat = json['iat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['iat'] = this.iat;
    return data;
  }
}
