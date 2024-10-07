import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

class CommentsEventController extends GetxController {
  bool click = false;

  TextEditingController commentaireController = TextEditingController();
  void onChanged(String v) {
    if (v.isNotEmpty) {
      click = true;
    } else {
      click = false;
    }
    print('"click========================$click');
    update();
  }
}
