
import 'package:app_guest/controllers/profile_controller.dart';
import 'package:app_guest/core/components/profile/app_button.dart';
import 'package:app_guest/core/components/profile/app_text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatefulWidget {
  final String? title;
  final String? code;
  const NewPasswordScreen({super.key, this.title, this.code});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  bool isObscureText = true;
  bool isObscureTextConfirmPwd = true;
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.title}",
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Create a New Password",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                AppTextFormField(
                  hintText: "New Password",
                  controller: profileController.newPassworsController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return "Please enter a valid password";
                    }
                  },
                  obscureText: isObscureText,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                AppTextFormField(
                  hintText: "Confirm New Password",
                  controller: profileController.confirmNewPassworsController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value !=
                            profileController.newPassworsController!.text) {
                      return "Please enter a valid password";
                    }
                  },
                  obscureText: isObscureTextConfirmPwd,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscureTextConfirmPwd = !isObscureTextConfirmPwd;
                      });
                    },
                    child: Icon(
                      isObscureTextConfirmPwd
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 30,
                ),
                AppTextButton(
                  text: "Update",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print('valide');
                      profileController.verifyCode(context,widget.code! );
                    }
                    // validateThenDoLogin(context);
                  },
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
