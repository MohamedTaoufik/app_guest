class GetUser {
  String? message;
  int? status;
  Data? data;

  GetUser({this.message, this.status, this.data});

  GetUser.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? userFirstName;
  String? userLastName;
  String? userBirthDate;
  String? userEmail;
  String? userPassword;
  String? userProfilePhoto;
  bool? verified;
  String? fcmToken;
  List<String>? events;
  List<String>? activities;
  List<String>? invitations;
  List<String>? comments;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? refreshtoken;

  Data(
      {this.sId,
      this.userFirstName,
      this.userLastName,
      this.userBirthDate,
      this.userEmail,
      this.userPassword,
      this.userProfilePhoto,
      this.verified,
      this.fcmToken,
      this.events,
      this.activities,
      this.invitations,
      this.comments,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.refreshtoken});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userFirstName = json['user_first_name'];
    userLastName = json['user_last_name'];
    userBirthDate = json['user_birth_date'];
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    userProfilePhoto = json['user_profile_photo'];
    verified = json['verified'];
    fcmToken = json['fcmToken'];
    events = json['events'].cast<String>();
    activities = json['activities'].cast<String>();
    invitations = json['invitations'].cast<String>();
    comments = json['comments'].cast<String>();
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    refreshtoken = json['refreshtoken'];
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
    data['fcmToken'] = this.fcmToken;
    data['events'] = this.events;
    data['activities'] = this.activities;
    data['invitations'] = this.invitations;
    data['comments'] = this.comments;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['refreshtoken'] = this.refreshtoken;
    return data;
  }
}
