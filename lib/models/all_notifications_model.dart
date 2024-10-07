class AllNotificationModel {
  String? message;
  int? status;
  List<Data>? data;

  AllNotificationModel({this.message, this.status, this.data});

  AllNotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? receiverId;
  SenderId? senderId;
  String? title;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.receiverId,
      this.senderId,
      this.title,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    receiverId = json['receiver_id'];
    senderId = json['sender_id'] != null
        ? new SenderId.fromJson(json['sender_id'])
        : null;
    title = json['title'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['receiver_id'] = this.receiverId;
    if (this.senderId != null) {
      data['sender_id'] = this.senderId!.toJson();
    }
    data['title'] = this.title;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SenderId {
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

  SenderId(
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

  SenderId.fromJson(Map<String, dynamic> json) {
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
