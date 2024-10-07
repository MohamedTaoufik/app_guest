import 'dart:io';

import 'package:app_guest/core/networking/app_api.dart';
import 'package:app_guest/core/storage/app_storage.dart';
import 'package:app_guest/models/get_user.dart';
import 'package:app_guest/models/login_user_model.dart';
import 'package:app_guest/models/user_membre_model.dart';
import 'package:app_guest/screens/event/home_screen.dart';
import 'package:app_guest/screens/profile/login_screen.dart';
import 'package:app_guest/screens/profile/new_password_screen.dart';
import 'package:app_guest/screens/profile/verify_code_screen.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as di;
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ProfileController extends GetxController {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  GlobalKey<FormState> keyFormForgot = GlobalKey<FormState>();

  GlobalKey<FormState> keyFormVeify = GlobalKey<FormState>();
  GlobalKey<FormState> keyFormNewP = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController? passworsController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();

  TextEditingController? phoneController = TextEditingController();
  TextEditingController? confirmPassworsController = TextEditingController();
  TextEditingController code1Controller = TextEditingController();
  TextEditingController code2Controller = TextEditingController();
  TextEditingController code3Controller = TextEditingController();
  TextEditingController code4Controller = TextEditingController();
  TextEditingController code5Controller = TextEditingController();
  TextEditingController code6Controller = TextEditingController();
  TextEditingController photoUserController = TextEditingController();
  TextEditingController? confirmNewPassworsController = TextEditingController();
  TextEditingController? newPassworsController = TextEditingController();

  bool isVisible = true;

  void showPassword() {
    isVisible = !isVisible;
    update(); // refrsh l page
  }

  void showPassword2() {
    isObscureText = !isObscureText;
    update(); // refrsh l page
  }

  bool isVisibleConfirmPwd = true;
  void showConfirmPwd() {
    isVisibleConfirmPwd = !isVisibleConfirmPwd;
    update(); // refrsh l page
  }

  bool visibility = true;
  String? selectedValue;
  String? selectedValueMaritalStatus;

  String? selectedValueCivilityTitle;
  bool showOtherField = false;
  final formKey = GlobalKey<FormState>();

  bool isObscureText = true;

  List<String> listRole = ["Vendeur", "Client"];
  String? tempPath;
  List<File> images = [];
  File? image;
  final picker = ImagePicker();

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("image user -----------$image");
      image = await File(pickedFile.path);
      updateUser();
      update(); // Update the UI to reflect the selected image
    }
  }

  // Image Picker function to get image from camera
  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      print("image user -----------$image");
      image = await File(pickedFile.path);
      updateUser();
      update(); // Update the UI to reflect the selected image
    }
  }

  // Show options to get image from camera or gallery
  showOptions(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();

              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  void onChnagedDropDown(String value) {
    selectedValue = value;
    update();
  }

  void onChnagedDropDownMaritalStatus(String value) {
    selectedValueMaritalStatus = value;
    update();
  }

  void onChnagedDropDownCivilityTitle(String value) {
    selectedValueCivilityTitle = value;
    update();
  }

  //-----------------------date -------------------------
  String selectedDate = '';
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is DateTime) {
      selectedDate = args.value.toString().substring(0, 10);
      selectedDateEditProfile.text = args.value.toString().substring(0, 10);
    }
    update();
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
  //--------------------------------------register ------------------------------
  UserMembreModel? userMembreModel;
  signUp(BuildContext context) async {
    try {
      print('---------------------------signup-------------------');
      Map<String, dynamic> data = {
        // 'user_civility_title': selectedValueCivilityTitle,
        'user_first_name': firstNameController.text,
        //'user_middle_name': middleNameController.text.trim(),
        'user_last_name': lastNameController.text.trim(),
        // 'user_pseudonym': pseudoNameController.text.trim(),
        'user_birth_date': selectedDate,
        //'user_gender': selectedValue,
        // 'user_martial_status': selectedValueMaritalStatus,
        'user_email': emailController.text.trim(),
        'user_password': passworsController!.text.trim(),
        'role': 'membres'
      };

      var response = await dio.request(
        AppApi.createMembreUrl,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      print("signup---------------------------------------");
      if (response.statusCode == 201) {
        userMembreModel = UserMembreModel.fromJson(response.data);
        AppStorage.saveId(userMembreModel!.sId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey[200],
            content: const Text(
              "Merci d'avoir créé un compte avec nous ! Pour finaliser votre inscription, veuillez vérifier votre boîte de réception.",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        );
        Get.to(const LoginScreen());
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('error=================$e');
    }
  }

  LoginUserModel? loginUserModel;
  signIn(BuildContext context) async {
    try {
      Map<String, dynamic> data = {
        'user_email': emailController.text.trim(),
        'user_password': passworsController!.text.trim(),
      };
      print('---------------------------signIn------------------}-');

      var response = await dio.request(
        AppApi.signInUrl,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      print("signIn---------------------------------------");
      if (response.statusCode == 201) {
        print('login success/-------------------------');
        loginUserModel = LoginUserModel.fromJson(response.data);
        AppStorage.saveId(loginUserModel!.user!.sId);
        AppStorage.saveEmail(loginUserModel!.user!.userEmail.toString());
        AppStorage.saveFullname(loginUserModel!.user!.userFirstName);
        AppStorage.saveToken(loginUserModel!.tokens!.accessToken.toString());
        emailController.clear();
        passworsController!.clear();
        getMembre(context);
        Get.to(HomeScreen());
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey[200],
            content: const Text(
              "pas encore verifier ,s'il vous plait verifiez votre boîte de réception",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        );
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey[200],
          content: const Text(
            "pas encore verifier ,s'il vous plait verifiez votre boîte de réception",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      );
      print('error=================$e');
    }
  }

  forgotPassword(BuildContext context) async {
    try {
      Map<String, dynamic> data = {
        "to": emailController.text,
        "from": "tekaya.taoufik.mohamed@gmail.com",
        "subject": "reset password ",
        "text": "votre code reset "
      };
      print('---------------------------send mail------------------}-');

      var response = await dio.request(
        AppApi.forgotPasswordUrl,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        print('success/-------------------------');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey[200],
            content: const Text(
              "s'il vous plait verifiez votre boîte de réception",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        );
        Get.to(VerifyCodeScreen());
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.grey[200],
      //     content: const Text(
      //       "pas encore verifier ,s'il vous plait verifiez votre boîte de réception",
      //       style: TextStyle(color: Colors.blue),
      //     ),
      //   ),
      // );
      print('error=================$e');
    }
  }

  TextEditingController selectedDateEditProfile = TextEditingController();
  getMembre(BuildContext context) async {
    try {
      print('---------------------------get-------------------');

      var response = await dio.request(
        '${AppApi.getUserUrl}${AppStorage.readId()}',
        options: Options(
          method: 'GET',
        ),
      );
      print("get---------------------------------------");
      if (response.statusCode == 200) {
        print("getee----------------------------");

        userMembreModel = UserMembreModel.fromJson(response.data);
        firstNameController.text = userMembreModel!.userFirstName!;
        lastNameController.text = userMembreModel!.userLastName!;
        print('selectDate=========================>');
        selectedDateEditProfile.text = userMembreModel!.userBirthDate!;
        emailController.text = userMembreModel!.userEmail!;
        photoUserController.text = userMembreModel!.userProfilePhoto!;
        print('selectDate=========================>$selectedDateEditProfile.');
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('error=================$e');
    }
  }

  GetUser? getUser;
  verifyCode(BuildContext context) async {
    try {
      print('---------------------------verify-------------------');

      var response = await dio.request(
        '${AppApi.verifyCodeUrl}${code1Controller.text}${code2Controller.text}${code3Controller.text}${code4Controller.text}${code5Controller.text}${code6Controller.text}',
        options: Options(
          method: 'GET',
        ),
      );
      print(
          "get--------------------------------${AppApi.verifyCodeUrl}${code1Controller.text}${code2Controller.text}${code3Controller.text}${code4Controller.text}${code5Controller.text}${code6Controller.text}------");
      if (response.statusCode == 200) {
        getUser = GetUser.fromJson(response.data);
        AppStorage.saveId(getUser!.data!.sId);
        print("verify code ------------------- ${response}---------");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NewPasswordScreen(
              title: "Forgot Password ",
            ),
          ),
        );
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.grey[200],
      //     content: const Text(
      //       "pas encore verifier ,s'il vous plait tapez un code valide",
      //       style: TextStyle(color: Colors.blue),
      //     ),
      //   ),
      // );
      print('error=================$e');
    }
  }

  // List<String> gender = ['Wome', "Men", "Prefer Not to say"];
  //   List<String> civilityTitle = ['Mr.', "Mrs.", "Miss.", "Not Specified"];
  //   String? tempPath;
  //   List<File> images = [];
  //   XFile? image;
  //   html.File? pickedFile;
  //   Uint8List? fileBytes;
  //   void pickFile() {
  //     html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  //     uploadInput.click();
  //     uploadInput.onChange.listen((event) {
  //       final files = uploadInput.files;
  //       if (files != null && files.isNotEmpty) {
  //         final reader = html.FileReader();
  //         reader.readAsArrayBuffer(files[0]);
  //         reader.onLoadEnd.listen((event) {
  //           //      setState(() {
  //           pickedFile = files[0];
  //           print('file=========================$pickedFile');
  //           fileBytes = reader.result as Uint8List?;
  //           print('filebyte=========================$fileBytes');
  //           //    });
  //         });
  //       }
  //     });
  //   }
  updateUser() async {
    try {
      print('---------------------------update---------$image----------');
      var data = di.FormData.fromMap({
        "file": await di.MultipartFile.fromFile(
          image!.path,
          filename: image!.path.split('/').last,
        ),

        // 'user_civility_title': selectedValueCivilityTitle,
        'user_first_name': firstNameController.text,
        //'user_middle_name': middleNameController.text.trim(),
        'user_last_name': lastNameController.text.trim(),
        // 'user_pseudonym': pseudoNameController.text.trim(),
        'user_birth_date': selectedDateEditProfile.text,
        //'user_gender': selectedValue,
        // 'user_martial_status': selectedValueMaritalStatus,
        'user_email': emailController.text.trim(),
        // 'user_password': passworsController!.text.trim(),
        'role': 'membres'
      });
      // di.FormData data_ = di.FormData.fromMap({
      //   "file": image != null
      //       ? di.MultipartFile.fromFile(
      //           image!.path,
      //           filename: image!.path.split('/').last,
      //         )
      //       : di.MultipartFile.fromString(
      //           phoneController!.text,
      //           //  filename: pickedFile!.name,
      //         ),
      // });
      var response = await dio.request(
        "${AppApi.getUserUrl}${AppStorage.readId()}",
        options: Options(
          method: 'PUT',
        ),
        data: data,
      );
      print("update---------------------------------------");
      if (response.statusCode == 200) {
        print("update success=====================${response.data}");
        userMembreModel!.userProfilePhoto = "";
        // photoUserController.clear();
        // Get.showSnackbar(
        //   GetSnackBar(
        //     backgroundColor: Colors.grey,
        //     title: "Votre profil a été mis à jour avec succès !",
        //   ),
        // );
      } else {
        print("response.statusMessage${response.statusMessage}");
      }
      update();
    } catch (e) {
      print('error=================$e');
    }
  }

//------------------------updatePassword
  updatePassword(BuildContext context) async {
    try {
      print('---------------------------update password-------------------');
      Map<String, dynamic> data = {
        "user_password": newPassworsController!.text
      };
      String? accessToken = AppStorage.readToken();

      // Options options = Options(headers: {
      //   'Authorization': 'Bearer $accessToken',
      // }, method: 'PATCH');

      var response = await dio.patch(
        "${AppApi.updatePasswordUrl}${AppStorage.readId()}",
        // options: options,
        data: data,
      );
      print("update---------------------------------------");
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey[200],
            content: const Text(
              "Votre mot de passe a été mis à jour avec succès !",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        );
        Get.to(const LoginScreen());
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('error=================$e');
    }
  }

//logout
  Future<void> logOut() async {
    String? accessToken = AppStorage.readToken();
    print('Access Token ==> $accessToken');

    if (accessToken != null) {
      Dio dio = Dio();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      try {
        await dio.get(
          AppApi.logOutUrl,
          options: options,
        );

        // AppStorage.clearUserData();
        Get.to(const LoginScreen());
        print('Déconnexion réussie');
      } catch (error) {
        print('Erreur lors de la déconnexion: $error');
      }
    } else {
      print('Token d\'accès introuvable');
    }
  }
}
