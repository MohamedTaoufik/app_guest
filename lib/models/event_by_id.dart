class EventModel {
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
  List<String>? comments;
  String? createdAt;
  String? updatedAt;
  int? iV;

  EventModel(
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

  EventModel.fromJson(Map<String, dynamic> json) {
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
    comments = json['comments'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['event_parameters'] = this.eventParameters;
    data['event_title'] = this.eventTitle;
    data['event_galleries'] = this.eventGalleries;
    data['event_date'] = this.eventDate;
    data['event_time'] = this.eventTime;
    data['event_type'] = this.eventType;
    data['event_address'] = this.eventAddress;
    data['event_description'] = this.eventDescription;
    data['event_latitude_coordinates'] = this.eventLatitudeCoordinates;
    data['event_longitude_coordinates'] = this.eventLongitudeCoordinates;
    data['event_discussion'] = this.eventDiscussion;
    data['user_id'] = this.userId;
    data['invitations'] = this.invitations;
    data['comments'] = this.comments;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
