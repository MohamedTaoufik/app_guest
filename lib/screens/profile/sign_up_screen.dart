
import 'package:app_guest/controllers/profile_controller.dart';
import 'package:app_guest/core/components/profile/app_button.dart';
import 'package:app_guest/core/components/profile/app_text_form_field.dart';
import 'package:app_guest/core/helperes/spacing.dart';
import 'package:app_guest/core/theming/app_colors.dart';
import 'package:app_guest/screens/profile/login_screen.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SignUpScreen extends GetView<ProfileController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> gender = [
      "Women",
      "Men",
      "Not Specified",
      "Prefer Not to say"
    ];
    List<String> civilityTitle = [
      "Ms",
      "Mrs.",
      "Mr.",
      "Miss.",
      "Not Specified",
      "Prefer Not to say"
    ];
    List<String> maritalStatus = ["Single", "Maried", "Other"];

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              verticalSpace(
                18,
              ),
              Text(
                "Create Account",
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
                "Sign up now and start exploring all that our app has to offer. We're excited to welcome you to our community!",
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
                hintText: "First Name",
                controller: controller.firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a first name";
                  }
                },
                // controller: context.read<LoginCubit>().emailController,
              ),
              verticalSpace(
                10,
              ),
              // AppTextFormField(
              //   hintText: "Middle Name",
              //   controller: controller.middleNameController,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Please enter a Middle Name";
              //     }
              //   },
              //   // controller: context.read<LoginCubit>().emailController,
              // ),
              verticalSpace(
                10,
              ),
              AppTextFormField(
                hintText: "Last Name",
                controller: controller.lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a last name";
                  }
                },
                // controller: context.read<LoginCubit>().emailController,
              ),
              verticalSpace(
                10,
              ),
              // AppTextFormField(
              //   hintText: "PseudoName",
              //   controller: controller.pseudoNameController,
              //   validator: (value) {
              //     if (value == null ||
              //         value.isEmpty ||
              //         !EmailValidator.validate(value)) {
              //       return "Please enter a PseudoName";
              //     }
              //   },
              //   // controller: context.read<LoginCubit>().emailController,
              // ),
              // verticalSpace(
              //   10,
              // ),
              // GetBuilder<ProfileController>(builder: (controller) {
              //   return CustomDropDowButton(
              //     hintText: "marital status",
              //     selectedValue: controller.selectedValueMaritalStatus,
              //     list: maritalStatus,
              //     onChanged: (p0) =>
              //         controller.onChnagedDropDownMaritalStatus(p0!),
              //   );
              // }),
              // verticalSpace(
              //   10,
              // ),
              // GetBuilder<ProfileController>(builder: (controller) {
              //   return CustomDropDowButton(
              //     hintText: "gender",
              //     selectedValue: controller.selectedValue,
              //     list: gender,
              //     onChanged: (p0) => controller.onChnagedDropDown(p0!),
              //   );
              // }),
              // verticalSpace(
              //   10,
              // ),

              GetBuilder<ProfileController>(builder: (controller) {
                return Column(
                  children: [
                    InkWell(
                      child: Container(
                        height: 40.h,
                        width: MediaQuery.sizeOf(context).width,
                        padding:
                            EdgeInsets.only(left: 18.w, top: 8.h, bottom: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.moreLightGrey,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.veryLightGrey,
                            width: 1,
                          ),
                        ),
                        child: controller.selectedDate.isEmpty
                            ? Text(
                                "selectionner date",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.eerieBlack,
                                ),
                              )
                            : Text(
                                controller.selectedDate.toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.eerieBlack,
                                ),
                              ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                                height: 250,
                                child: Card(
                                    child: SfDateRangePicker(
                                  showActionButtons: true,
                                  onSubmit: (p0) {
                                    print('value=============>$p0');
                                    Navigator.pop(context);
                                  },
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                  cancelText: "fermer",
                                  confirmText: "confirmer",
                                  onSelectionChanged:
                                      controller.onSelectionChanged,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                )));
                          },
                        );
                      },
                    ),
                    verticalSpace(
                      10,
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
                      10,
                    ),
                    GetBuilder<ProfileController>(builder: (controller) {
                      return AppTextFormField(
                        controller: controller.passworsController,
                        hintText: "Password",
                        //   controller: context.read<LoginCubit>().passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a valid password";
                          }
                        },
                        obscureText: controller.isVisible,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.showPassword();
                          },
                          child: Icon(
                            controller.isVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      );
                    }),
                    verticalSpace(
                      10,
                    ),
                    GetBuilder<ProfileController>(builder: (controller) {
                      return AppTextFormField(
                        hintText: "Confirm Password",
                        //   controller: context.read<LoginCubit>().passwordController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value != controller.passworsController!.text) {
                            return "Please enter a valid password";
                          }
                        },
                        obscureText: controller.isVisibleConfirmPwd,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.showConfirmPwd();
                          },
                          child: Icon(
                            controller.isVisibleConfirmPwd
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }),
              verticalSpace(62),
              AppTextButton(
                text: " Sign Up",
                onPressed: () {
                  controller.signUp(context);
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
                        text: "Already have an account ? ",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.eerieBlack,
                        ),
                      ),
                      TextSpan(
                          text: "Login",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.cyanBlue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            }),
                    ],
                  ),
                ),
              ),
              // CustomShowOther(
              //   listAttributs: [
              //     GetBuilder<ProfileController>(builder: (controller) {
              //       return CustomDropDowButton(
              //         hintText: "civility tilte",
              //         selectedValue: controller.selectedValueCivilityTitle,
              //         list: civilityTitle,
              //         onChanged: (p0) =>
              //             controller.onChnagedDropDownCivilityTitle(p0!),
              //       );
              //     }),
              //     verticalSpace(
              //       10,
              //     ),
              //     GetBuilder<ProfileController>(builder: (controller) {
              //       return Column(
              //         children: [
              //           InkWell(
              //             child: controller.selectedDate.isEmpty
              //                 ? const Text("selectionner date")
              //                 : Text(controller.selectedDate.toString()),
              //             onTap: () {
              //               showDialog(
              //                 context: context,
              //                 builder: (BuildContext context) {
              //                   return SizedBox(
              //                       height: 250,
              //                       child: Card(
              //                           child: SfDateRangePicker(
              //                         showActionButtons: true,
              //                         onSubmit: (p0) {
              //                           print('value=============>$p0');
              //                           Navigator.pop(context);
              //                         },
              //                         onCancel: () {
              //                           Navigator.pop(context);
              //                         },
              //                         cancelText: "fermer",
              //                         confirmText: "confirmer",
              //                         onSelectionChanged:
              //                             controller.onSelectionChanged,
              //                         selectionMode:
              //                             DateRangePickerSelectionMode.single,
              //                       )));
              //                 },
              //               );
              //             },
              //           ),
              //           verticalSpace(
              //             10,
              //           ),
              //           AppTextFormField(
              //             hintText: "Email",
              //             controller: controller.emailController,
              //             validator: (value) {
              //               if (value == null ||
              //                   value.isEmpty ||
              //                   !EmailValidator.validate(value)) {
              //                 return "Please enter a valid email";
              //               }
              //             },
              //             // controller: context.read<LoginCubit>().emailController,
              //           ),
              //           verticalSpace(
              //             10,
              //           ),
              //           GetBuilder<ProfileController>(builder: (controller) {
              //             return AppTextFormField(
              //               controller: controller.passworsController,
              //               hintText: "Password",
              //               //   controller: context.read<LoginCubit>().passwordController,
              //               validator: (value) {
              //                 if (value == null || value.isEmpty) {
              //                   return "Please enter a valid password";
              //                 }
              //               },
              //               obscureText: controller.isVisible,
              //               suffixIcon: GestureDetector(
              //                 onTap: () {
              //                   controller.showPassword();
              //                 },
              //                 child: Icon(
              //                   controller.isVisible
              //                       ? Icons.visibility_off
              //                       : Icons.visibility,
              //                 ),
              //               ),
              //             );
              //           }),
              //           verticalSpace(
              //             10,
              //           ),
              //           GetBuilder<ProfileController>(builder: (controller) {
              //             return AppTextFormField(
              //               hintText: "Confirm Password",
              //               //   controller: context.read<LoginCubit>().passwordController,
              //               validator: (value) {
              //                 if (value == null ||
              //                     value.isEmpty ||
              //                     value !=
              //                         controller.passworsController!.text) {
              //                   return "Please enter a valid password";
              //                 }
              //               },
              //               obscureText: controller.isVisibleConfirmPwd,
              //               suffixIcon: GestureDetector(
              //                 onTap: () {
              //                   controller.showConfirmPwd();
              //                 },
              //                 child: Icon(
              //                   controller.isVisibleConfirmPwd
              //                       ? Icons.visibility_off
              //                       : Icons.visibility,
              //                 ),
              //               ),
              //             );
              //           }),
              //         ],
              //       );
              //     }),
              //     verticalSpace(62),
              //     AppTextButton(
              //       text: " Sign Up",
              //       onPressed: () {
              //         controller.signUp(context);
              //       },
              //       textStyle: TextStyle(
              //         fontSize: 18.sp,
              //         fontWeight: FontWeight.w800,
              //         color: Colors.white,
              //       ),
              //     ),
              //     verticalSpace(50),
              //     Center(
              //       child: RichText(
              //         textAlign: TextAlign.center,
              //         text: TextSpan(
              //           children: [
              //             TextSpan(
              //               text: "Already have an account ? ",
              //               style: TextStyle(
              //                 fontSize: 13.sp,
              //                 fontWeight: FontWeight.w600,
              //                 color: AppColors.eerieBlack,
              //               ),
              //             ),
              //             TextSpan(
              //                 text: "Login",
              //                 style: TextStyle(
              //                   fontSize: 13.sp,
              //                   fontWeight: FontWeight.w600,
              //                   color: AppColors.cyanBlue,
              //                 ),
              //                 recognizer: TapGestureRecognizer()
              //                   ..onTap = () {
              //                     Navigator.of(context).push(
              //                       MaterialPageRoute(
              //                         builder: (context) => const LoginScreen(),
              //                       ),
              //                     );
              //                   }),
              //           ],
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ]),
          ),
        ),
      ),
    );
  }
}
