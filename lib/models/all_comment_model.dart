class AllCommentModel {
  String? message;
  int? status;
  List<Data>? data;

  AllCommentModel({this.message, this.status, this.data});

  AllCommentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
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
    userId = json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
    eventId = json['event_id'];
    commentMessageContext = json['comment_message_context'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (userId != null) {
      data['user_id'] = userId!.toJson();
    }
    data['event_id'] = eventId;
    data['comment_message_context'] = commentMessageContext;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class UserId {
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
      {this.sId,
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_civility_title'] = userCivilityTitle;
    data['user_first_name'] = userFirstName;
    data['user_middle_name'] = userMiddleName;
    data['user_last_name'] = userLastName;
    data['user_pseudonym'] = userPseudonym;
    data['user_birth_date'] = userBirthDate;
    data['user_gender'] = userGender;
    data['user_martial_status'] = userMartialStatus;
    data['user_email'] = userEmail;
    data['user_password'] = userPassword;
    data['user_profile_photo'] = userProfilePhoto;
    data['verified'] = verified;
    data['events'] = events;
    data['invitations'] = invitations;
    data['comments'] = comments;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['refreshtoken'] = refreshtoken;
    data['user_code'] = userCode;
    return data;
  }
}
