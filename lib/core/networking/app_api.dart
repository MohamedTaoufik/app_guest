class AppApi {
  // static const String baseUrl = "http://localhost:3000/";
  static const String baseUrl = "http://192.168.1.76:3000/";

  static const String createMembreUrl = "${baseUrl}members/";
  static const String getUserUrl = "${baseUrl}users/";

  static const String signInUrl = "${baseUrl}authentification/signin";
  static const String getAllEventUrl = "${baseUrl}events/";
  static const String getEventUrl = "${baseUrl}events/byId/";

  static const String getAllCommentUrl = "${baseUrl}comments/";

  static const String getImageEventUrl = "${baseUrl}file/events/";
  static const String getImageUsersUrl = "${baseUrl}file/users/";

  static const String forgotPasswordUrl = "${baseUrl}users/sendMail";
  static const String updatePasswordUrl =
      "${baseUrl}authentification/updatePassword/";
  static const String getUserEmailUrl = "${baseUrl}users/find/";
  static const String sendNotificationUrl = "${baseUrl}notifications/";

  static const String verifyCodeUrl = "${baseUrl}users/reset-password/";
  static const String logOutUrl = "${baseUrl}authentification/logout";
}
