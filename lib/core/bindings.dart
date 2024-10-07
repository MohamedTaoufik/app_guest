

import 'package:app_guest/controllers/comments_event_controller.dart';
import 'package:app_guest/controllers/event_controller.dart';
import 'package:app_guest/controllers/profile_controller.dart';
import 'package:get/get.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => EventController());
    Get.lazyPut(() => CommentsEventController());
  }
}
