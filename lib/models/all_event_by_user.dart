class AllEventModelByUser {
  String? message;
  int? status;
  List<Data>? data;

  AllEventModelByUser({this.message, this.status, this.data});

  AllEventModelByUser.fromJson(Map<String, dynamic> json) {
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
  List<String>? eventParameters;
  String? eventTitle;
  List<String>? eventGalleries;
  String? eventDate;
  String? eventTime;
  String? eventType;
  String? eventAddress;
  String? eventDescription;
  String? eventLatitudeCoordinates;
  String? eventLongitudeCoordinates;
  List<String>? eventDiscussion;
  String? userId;
  List<String>? invitations;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.eventParameters,
      this.eventTitle,
      this.eventGalleries,
      this.eventDate,
      this.eventTime,
      this.eventType,
      this.eventAddress,
      this.eventDescription,
      this.eventLatitudeCoordinates,
      this.eventLongitudeCoordinates,
      this.eventDiscussion,
      this.userId,
      this.invitations,
      this.comments,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    eventParameters = json['event_parameters'].cast<String>();
    eventTitle = json['event_title'];
    eventGalleries = json['event_galleries'].cast<String>();
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    eventType = json['event_type'];
    eventAddress = json['event_address'];
    eventDescription = json['event_description'];
    eventLatitudeCoordinates = json['event_latitude_coordinates'];
    eventLongitudeCoordinates = json['event_longitude_coordinates'];
    eventDiscussion = json['event_discussion'].cast<String>();
    userId = json['user_id'];
    invitations = json['invitations'].cast<String>();
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['event_parameters'] = eventParameters;
    data['event_title'] = eventTitle;
    data['event_galleries'] = eventGalleries;
    data['event_date'] = eventDate;
    data['event_time'] = eventTime;
    data['event_type'] = eventType;
    data['event_address'] = eventAddress;
    data['event_description'] = eventDescription;
    data['event_latitude_coordinates'] = eventLatitudeCoordinates;
    data['event_longitude_coordinates'] = eventLongitudeCoordinates;
    data['event_discussion'] = eventDiscussion;
    data['user_id'] = userId;
    data['invitations'] = invitations;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Comments {
  String? sId;
  UserId? userId;
  String? eventId;
  String? commentMessageContext;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Comments(
      {this.sId,
      this.userId,
      this.eventId,
      this.commentMessageContext,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Comments.fromJson(Map<String, dynamic> json) {
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
  String? refreshtoken;
  String? userCode;

  UserId(
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
      this.iV,
      this.refreshtoken,
      this.userCode});

  UserId.fromJson(Map<String, dynamic> json) {
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
    refreshtoken = json['refreshtoken'];
    userCode = json['user_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user_first_name'] = userFirstName;
    data['user_last_name'] = userLastName;
    data['user_birth_date'] = userBirthDate;
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
