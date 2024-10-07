class AllCommentsByEventModel {
  String? message;
  int? status;
  List<Data>? data;

  AllCommentsByEventModel({this.message, this.status, this.data});

  AllCommentsByEventModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
  List<String> getPhotosUsers() {
    List<String>? users = [];
    if (data != null) {
      users = data!
          .map((data) => data.userId!.userProfilePhoto)
          .cast<String>()
          .toList();
    }
    return users;
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
  UserId? userId;
  String? eventId;
  String? commentMessageContext;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.userId,
      this.eventId,
      this.commentMessageContext,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
        json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    eventId = json['event_id'];
    commentMessageContext = json['comment_message_context'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['event_id'] = this.eventId;
    data['comment_message_context'] = this.commentMessageContext;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class UserId {
  List<String>? activities;
  String? sId;
  String? userCivilityTitle;
  String? userFirstName;
  String? userMiddleName;
  String? userLastName;
  String? userPseudonym;
  String? userBirthDate;
  String? userGender;
  String? userMartialStatus;
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
  String? refreshtoken;
  String? userCode;

  UserId(
      {this.activities,
      this.sId,
      this.userCivilityTitle,
      this.userFirstName,
      this.userMiddleName,
      this.userLastName,
      this.userPseudonym,
      this.userBirthDate,
      this.userGender,
      this.userMartialStatus,
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
      this.iV,
      this.refreshtoken,
      this.userCode});

  UserId.fromJson(Map<String, dynamic> json) {
    activities = json['activities'].cast<String>();
    sId = json['_id'];
    userCivilityTitle = json['user_civility_title'];
    userFirstName = json['user_first_name'];
    userMiddleName = json['user_middle_name'];
    userLastName = json['user_last_name'];
    userPseudonym = json['user_pseudonym'];
    userBirthDate = json['user_birth_date'];
    userGender = json['user_gender'];
    userMartialStatus = json['user_martial_status'];
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
    refreshtoken = json['refreshtoken'];
    userCode = json['user_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activities'] = this.activities;
    data['_id'] = this.sId;
    data['user_civility_title'] = this.userCivilityTitle;
    data['user_first_name'] = this.userFirstName;
    data['user_middle_name'] = this.userMiddleName;
    data['user_last_name'] = this.userLastName;
    data['user_pseudonym'] = this.userPseudonym;
    data['user_birth_date'] = this.userBirthDate;
    data['user_gender'] = this.userGender;
    data['user_martial_status'] = this.userMartialStatus;
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
    data['refreshtoken'] = this.refreshtoken;
    data['user_code'] = this.userCode;
    return data;
  }
}
