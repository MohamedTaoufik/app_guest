class UserMembreModel {
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

  UserMembreModel(
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
      this.refreshtoken});

  UserMembreModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
