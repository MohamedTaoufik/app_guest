import 'dart:io';
import 'dart:typed_data';

import 'package:app_guest/core/networking/app_api.dart';
import 'package:app_guest/core/storage/app_storage.dart';
import 'package:app_guest/models/all_comment_model.dart';
import 'package:app_guest/models/all_comments_by_event_model.dart';
import 'package:app_guest/models/all_event_by_user.dart';
import 'package:app_guest/models/all_event_model.dart';
import 'package:app_guest/models/all_notifications_model.dart';
import 'package:app_guest/models/event_by_id.dart';
import 'package:app_guest/models/get_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';


import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_dio_logger/src/pretty_dio_logger.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EventController extends GetxController {
  final FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        // Scroll to the bottom when the TextField gains focus
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      }
    });
  }

  Dio dio = Dio()
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        filter: (options, args) {
          //  return !options.uri.path.contains('posts');
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );

  final formKey = GlobalKey<FormState>();
    final formKeyUpdate = GlobalKey<FormState>();

  TextEditingController nomEvent = TextEditingController();

  late List<String?> listPhotoUsers;

  TextEditingController placeEvent = TextEditingController();
  AllEventModel? allEventModel;
  AllCommentModel? allCommentModel;
  Future<AllEventModel?> getAllEvent() async {
    listPhotoUsers = [];
    print('get event---------------------------$listPhotoUsers');
    try {
      dio_.Response response = await dio.get(
        AppApi.getAllEventUrl,
      );
      print('response===================${response.statusMessage}');
      if (response.statusCode == 200) {
        allEventModel = AllEventModel.fromJson(response.data);
        print('data=length=================${allEventModel!.data!.length}');
        print('data==================${allEventModel!.data!}');

//  listPhotoUsers = allEventModel!
//               .getUserProfilePhotosForEvent("6683a9adc56152106ca28328");
        return allEventModel;
      }
    } catch (e) {
      print("error catch===================> $e");
      return null;
    }
    return null;
  }

  String? selectedValue;

  void onChnagedDropDown(String value) {
    selectedValue = value;
    update();
  }

//-----------------------date -------------------------
  GetUser? getUser;
  getMembreByemail(BuildContext context, String email) async {
    try {
      print('---------------------------get-email------------------');

      var response = await dio.request(
        '${AppApi.getUserEmailUrl}${email}',
        options: Options(
          method: 'GET',
        ),
      );
      print("get------------------------email---------------");
      if (response.statusCode == 200) {
        print("getee------------- email---------------");
        getUser = GetUser.fromJson(response.data);
        print(
            "getee------------- email---- ${getUser!.data!.userEmail}-----------");
        addNotification();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey[200],
            content: const Text(
              "User not found",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        );
        Get.back();
      }
    } catch (e) {
      print('error=================$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey[200],
          content: const Text(
            "User not found",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      );
      Get.back();
    }
  }

  TextEditingController selectedDateEditProfile = TextEditingController();

  String selectedDate = '';
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is DateTime) {
      selectedDate = args.value.toString().substring(0, 10);
      selectedDateEditProfile.text = args.value.toString().substring(0, 10);
    }
    update();
  }

  AllEventModelByUser? allEventModelByUser;
  Future<AllCommentsByEventModel?> getAlCommentsByEvent(String? idEvent) async {
    try {
      print('get comm-----------------------$idEvent');
      var response = await dio.get("${AppApi.getAllCommentUrl}$idEvent");
      if (response.statusCode == 200) {
        print('success-----------------------------$response');
        allCommentsByEventModel =
            AllCommentsByEventModel.fromJson(response.data);

        listPhotoUsers = allCommentsByEventModel!.getPhotosUsers();
        print('photo user 22===================>${listPhotoUsers.length}');
        return allCommentsByEventModel;
      }
    } catch (error) {
      print("error==================>$error");
    }
    return null;
  }

  AllNotificationModel? allNotificationsModel;
  Future<AllNotificationModel?> getNotifByReceiver() async {
    try {
      var response = await dio
          .get("${AppApi.sendNotificationUrl}find/${AppStorage.readId()}");
      if (response.statusCode == 200) {
        print('success-----------------------------$response');
        allNotificationsModel = AllNotificationModel.fromJson(response.data);

        return allNotificationsModel;
      }
    } catch (error) {
      print("error==================>$error");
    }
    return null;
  }

  Future<AllEventModelByUser?> getAllEventByUser() async {
    print('get all my event---------------------------');
    try {
      dio_.Response response = await dio.get(
        "${AppApi.getAllEventUrl}${AppStorage.readId()}",
      );
      print('response==my events=================${response.statusMessage}');
      if (response.statusCode == 200) {
        allEventModelByUser = AllEventModelByUser.fromJson(response.data);
        print('data my events==================${allEventModelByUser!.data}');
        //    listPhotoUsers = allEventModel!.getUserProfilePhotos();
        print('photo user===================>$listPhotoUsers');
        return allEventModelByUser;
      }
      //  else if (response.statusCode == 404) {
      //   print("error else=========================>${response.statusMessage}");
      //   return null;
      // }
    } catch (e) {
      print("error catch===================> $e");
      return null;
    }
    return null;
  }

  Future<AllEventModel?> getAllEventByUser1() async {
    print('get all event---------------------------');
    try {
      dio_.Response response = await dio.get(
        "${AppApi.getAllEventUrl}${AppStorage.readId()}",
      );
      print('response===================${response.statusMessage}');
      if (response.statusCode == 200) {
        allEventModel = AllEventModel.fromJson(response.data);
        print('data my events==================${allEventModel!.data}');

        return allEventModel;
      }
      //  else if (response.statusCode == 404) {
      //   print("error else=========================>${response.statusMessage}");
      //   return null;
      // }
    } catch (e) {
      print("error catch===================> $e");
      return null;
    }
    return null;
  }

  List<String>? eventGalleries;
  EventModel? eventModel;
  getEventById(String id) async {
    print('get event by id---------------------------');
    try {
      dio_.Response response = await dio.get(
        "${AppApi.getEventUrl}$id",
      );
      print('response===================${response.statusMessage}');
      if (response.statusCode == 200) {
        eventModel = EventModel.fromJson(response.data);

        timeController.text = eventModel!.eventTime!;
        titleController.text = eventModel!.eventTitle!;
        adressController.text = eventModel!.eventAddress!;
        descriptionController.text = eventModel!.eventDescription!;
        longitudeController.text = eventModel!.eventLongitudeCoordinates!;
        latitudeController.text = eventModel!.eventLatitudeCoordinates!;
        eventGalleries = eventModel!.eventGalleries;
        print('data my events==================${eventGalleries!}');
      }
    } catch (e) {
      print("error catch===================> $e");
    }
  }

  AllCommentsByEventModel? allCommentsByEventModel;
  Future<AllCommentModel?> getAllComments() async {
    print('get comment---------------------------');
    try {
      dio_.Response response = await dio.get(
        AppApi.getAllCommentUrl,
      );
      print(
          'response== careate comment =================${response.statusMessage}');
      if (response.statusCode == 200) {
        allCommentModel = AllCommentModel.fromJson(response.data);
        print('data==================${allEventModel!.data}');
        return allCommentModel;
      }
    } catch (e) {
      print("error catch===================> $e");
      return null;
    }
    return null;
  }

  //-------------------------------image
  List<File?> pickedFiles = [];

  List<File>? images = []; // Liste pour stocker les images sélectionnées
  final picker = ImagePicker();
  List<File> imageFiles = [];
  List<dio_.MultipartFile> files = [];
// Sélectionner plusieurs images depuis la galerie
  // Future<void> getImagesFromGallery() async {
  //   try {
  //     // Sélection multiple d'images depuis la galerie
  //     final List<XFile>? pickedFiles = await picker.pickMultiImage();

  //     // Vérifiez si l'utilisateur a sélectionné des fichiers
  //     if (pickedFiles != null && pickedFiles.isNotEmpty) {
  //       // Conversion des fichiers XFile en objets File
  //       images =
  //           pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
  //       print("Images sélectionnées : $images");

  //       // Préparation des fichiers pour l'envoi avec Dio
  //       for (var file in images!) {
  //         files.add(
  //           await dio_.MultipartFile.fromFile(
  //             file.path,
  //             filename: file.path.split('/').last,
  //           ),
  //         );
  //       }

  //       print("Fichiers Multipart préparés : $files");
  //       update(); // Met à jour l'état si nécessaire (par exemple, avec GetX ou autre gestion d'état)
  //     } else {
  //       print("Aucune image sélectionnée.");
  //     }
  //   } catch (e) {
  //     print("Erreur lors de la sélection des images : $e");
  //   }
  // }

// Affichage des options pour choisir entre la galerie et la caméra
  showOptions(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImagesFromGallery(); // Sélectionner plusieurs images
            },
          ),
          // CupertinoActionSheetAction(
          //   child: const Text('Camera'),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //     getImageFromCamera(); // Capturer une image
          //   },
          // ),
        ],
      ),
    );
    print("show option-------------------------");
    update();
  }

  Future<void> getImagesFromGallery() async {
    try {
      final List<XFile>? pickedFiles = await picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        images =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
        print("Images sélectionnées : $images");

        files.clear(); // Réinitialiser la liste des fichiers
        for (var file in images!) {
          files.add(await dio_.MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ));
        }
        print("Fichiers Multipart préparés : $files");
        update(); // Met à jour l'état si nécessaire
      } else {
        print("Aucune image sélectionnée.");
      }
    } catch (e) {
      print("Erreur lors de la sélection des images : $e");
    }
  }

  Future<void> addNotification() async {
    try {
      var data = {
        "sender_id": AppStorage.readId(),
        "receiver_id": getUser!.data!.sId,
        "body": "${AppStorage.readName()} invite to evenement",
        "title": "invitation",
        "token": getUser!.data!.fcmToken
      };

      var response = await dio.post(
        AppApi.sendNotificationUrl,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        print("Réponse ajout événement : ${response.data}");

        Get.back();
      } else {
        print("Erreur ajout événement : ${response.statusMessage}");
      }
    } catch (e) {
      print("Exception ajout événement : $e");
    }
  }

  Future<void> ajoutEvent() async {
    try {
      var headers = {'Authorization': 'Bearer ${AppStorage.readToken()}'};

      var data = dio_.FormData.fromMap({
        'files': files,
        'event_name': nomEvent.text.trim(),
        'event_place': placeEvent.text.trim(),
        'user_id': AppStorage.readId(),
        'event_title': titleController.text,
        'event_date': selectedDate,
        'event_time': timeController.text,
        'event_address': adressController.text,
        'event_description': descriptionController.text,
        'event_latitude_coordinates': latitudeController.text,
        'event_longitude_coordinates': longitudeController.text,
        'event_type': selectedValue
      });

      print('Data à envoyer : ${data.fields}');
      print('Fichiers à envoyer : ${data.files}');

      var response = await dio.post(
        AppApi.getAllEventUrl,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        print("Réponse ajout événement : ${response.data}");
        formKey.currentState!.reset();

        Get.back();
        update();
      } else {
        print("Erreur ajout événement : ${response.statusMessage}");
      }
    } catch (e) {
      print("Exception ajout événement : $e");
    }
  }

  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();

  ajoutComment(String? comment) async {
    print('add comment event ---------------');
    try {
      Map<String, dynamic> data = {
        "user_id": AppStorage.readId(),
        "event_id": AppStorage.readIdEvent(),
        "comment_message_context": comment,
      };

      var dio = Dio();
      var response = await dio.request(
        AppApi.getAllCommentUrl,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        print(
            "response add comment===========================>${response.data}");

        update();
      }
    } catch (error) {
      print("error======================>$error");
    }
    update();
  }

  updateEvent() async {
    var data = dio_.FormData.fromMap({
      'files': files,
      'event_name': nomEvent.text.trim(),
      'event_place': placeEvent.text.trim(),
      'user_id': AppStorage.readId(),
      'event_title': titleController.text,
      'event_date': selectedDate,
      'event_time': timeController.text,
      'event_address': adressController.text,
      'event_description': descriptionController.text,
      'event_latitude_coordinates': latitudeController.text,
      'event_longitude_coordinates': longitudeController.text,
      'event_type': selectedValue
    });

    try {
      var dio = Dio();
      var response = await dio.request(
        '${AppApi.getAllEventUrl}${AppStorage.readIdEvent()}',
        options: Options(
          method: 'PUT',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print("response===========================>${response.data}");
        // formKey.currentState!.reset();
        // nomEvent.clear();
        // placeEvent.clear();
        // fileBytesList = [];
      }
    } catch (error) {
      print("error======================>$error");
    }
  }

  deleteEvent() async {
    var response = await dio.request(
      '${AppApi.getAllEventUrl}${AppStorage.readIdEvent()}',
      options: Options(
        method: 'DELETE',
      ),
    );

    if (response.statusCode == 200) {
      print("response===========================>${response.data}");

      Get.back();
    } else {
      print("error======================>${response.statusMessage}");
    }
    update();
  }

  deleteNotifi(String id) async {
    var response = await dio.request(
      '${AppApi.sendNotificationUrl}${id}',
      options: Options(
        method: 'DELETE',
      ),
    );
  }

  bool click = false;

  TextEditingController commentaireController = TextEditingController();
  void onChanged(String v) {
    if (v.isNotEmpty) {
      click = true;
    } else {
      click = false;
    }
    print('"click========================$click');
    //  update();
  }
}
