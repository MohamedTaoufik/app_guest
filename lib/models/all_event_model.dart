class AllEventModel {
  String? message;
  int? status;
  List<Data>? data;

  AllEventModel({this.message, this.status, this.data});

  AllEventModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  List<String?> getUserProfilePhotosForEvent(String eventId) {
    Set<String?> userProfilePhotosSet = {};
    if (data != null) {
      // Find the event by eventId
      var event = data!.firstWhere(
        (element) => element.sId == eventId,
      );
      if (event.comments != null) {
        for (var comment in event.comments!) {
          if (comment.userId != null &&
              comment.userId!.userProfilePhoto != null) {
            userProfilePhotosSet.add(comment.userId!.userProfilePhoto);
          }
        }
      }
    }
    return userProfilePhotosSet.toList();
  }
}

class Data {
  List<String>? eventParameters;
  List<String>? eventDiscussion;
  String? sId;
  String? eventName;
  String? eventPlace;
  List<String>? eventGalleries;
  String? userId;
  List<String>? invitations;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? eventTitle;
  String? eventDate;
  String? eventTime;
  String? eventType;
  String? eventAddress;
  String? eventDescription;
  String? eventLatitudeCoordinates;
  String? eventLongitudeCoordinates;

  Data(
      {this.eventParameters,
      this.eventDiscussion,
      this.sId,
      this.eventName,
      this.eventPlace,
      this.eventGalleries,
      this.userId,
      this.invitations,
      this.comments,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.eventTitle,
      this.eventDate,
      this.eventTime,
      this.eventType,
      this.eventAddress,
      this.eventDescription,
      this.eventLatitudeCoordinates,
      this.eventLongitudeCoordinates});

  Data.fromJson(Map<String, dynamic> json) {
    eventParameters = json['event_parameters'].cast<String>();
    eventDiscussion = json['event_discussion'].cast<String>();
    sId = json['_id'];
    eventName = json['event_name'];
    eventPlace = json['event_place'];
    eventGalleries = json['event_galleries'].cast<String>();
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
    eventTitle = json['event_title'];
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    eventType = json['event_type'];
    eventAddress = json['event_address'];
    eventDescription = json['event_description'];
    eventLatitudeCoordinates = json['event_latitude_coordinates'];
    eventLongitudeCoordinates = json['event_longitude_coordinates'];
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
  List<dynamic>? invitations;
  List<String>? comments;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? refreshtoken;

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
      this.refreshtoken});

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

    invitations = json['invitations'];
    comments = json['comments'].cast<String>();
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    refreshtoken = json['refreshtoken'];
  }
}
