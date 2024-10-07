class LoginUserModel {
  Tokens? tokens;
  User? user;

  LoginUserModel({this.tokens, this.user});

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    tokens =
        json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Tokens {
  String? accessToken;
  String? refreshToken;

  Tokens({this.accessToken, this.refreshToken});

  Tokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}

class User {
  String? sId;
  String? userFirstName;
  String? userLastName;
  String? userBirthDate;
  String? userEmail;
  String? userPassword;
  String? userProfilePhoto;
  bool? verified;
  List<String>? events;
  List<String>? invitations;
  List<String>? comments;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
      {this.sId,
      this.userFirstName,
      this.userLastName,
      this.userBirthDate,
      this.userEmail,
      this.userPassword,
      this.userProfilePhoto,
      this.verified,
      this.events,
      this.invitations,
      this.comments,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userFirstName = json['user_first_name'];
    userLastName = json['user_last_name'];
    userBirthDate = json['user_birth_date'];
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    userProfilePhoto = json['user_profile_photo'];
    verified = json['verified'];
    events = json['events'].cast<String>();
    invitations = json['invitations'].cast<String>();
    comments = json['comments'].cast<String>();
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_first_name'] = this.userFirstName;
    data['user_last_name'] = this.userLastName;
    data['user_birth_date'] = this.userBirthDate;
    data['user_email'] = this.userEmail;
    data['user_password'] = this.userPassword;
    data['user_profile_photo'] = this.userProfilePhoto;
    data['verified'] = this.verified;
    data['events'] = this.events;
    data['invitations'] = this.invitations;
    data['comments'] = this.comments;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
