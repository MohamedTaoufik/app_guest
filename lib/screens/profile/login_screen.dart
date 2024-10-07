
import 'package:app_guest/controllers/profile_controller.dart';
import 'package:app_guest/core/components/profile/app_button.dart';
import 'package:app_guest/core/components/profile/app_text_form_field.dart';
import 'package:app_guest/core/helperes/spacing.dart';
import 'package:app_guest/core/theming/app_colors.dart';
import 'package:app_guest/screens/profile/forgot_password_screen.dart';
import 'package:app_guest/screens/profile/sign_up_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<ProfileController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(
                  18,
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue,
                  ),
                ),
                verticalSpace(
                  18,
                ),
                Text(
                  "We're excited to have you back, can't wait to see what you've been up to since you last logged in.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w200,
                    color: AppColors.grey,
                  ),
                ),
                verticalSpace(
                  56,
                ),
                AppTextFormField(
                  hintText: "Email",
                  controller: controller.emailController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !EmailValidator.validate(value)) {
                      return "Please enter a valid email";
                    }
                  },
                  // controller: context.read<LoginCubit>().emailController,
                ),
                verticalSpace(
                  18,
                ),
                GetBuilder<ProfileController>(
                  builder: (controller) {
                    return AppTextFormField(
                      hintText: "Password",
                      controller: controller.passworsController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return "Please enter a valid password";
                        }
                      },
                      obscureText: controller.isObscureText,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.showPassword2();
                          print('login-----------icon');
                        },
                        child: Icon(
                          controller.isObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    );
                  },
                ),
                verticalSpace(12),
                InkWell(
                  onTap: () => Get.to(ForgotPasswordScreen()),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                ),
                verticalSpace(62),
                AppTextButton(
                  text: "Login",
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      print('valide');
                      controller.signIn(context);
                    }
                    // validateThenDoLogin(context);
                  },
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                verticalSpace(50),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account ? ",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.eerieBlack,
                          ),
                        ),
                        TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.cyanBlue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
