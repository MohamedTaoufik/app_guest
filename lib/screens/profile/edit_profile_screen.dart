import 'package:app_guest/controllers/profile_controller.dart';
import 'package:app_guest/core/components/profile/app_button.dart';
import 'package:app_guest/core/components/profile/app_text_form_field.dart';
import 'package:app_guest/core/helperes/spacing.dart';
import 'package:app_guest/core/networking/app_api.dart';
import 'package:app_guest/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:get/state_manager.dart';
import 'dart:typed_data';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(
                    18,
                  ),
                  GetBuilder<ProfileController>(
                    builder: (controller) => Center(
                      child: Stack(
                        children: [
                          controller.image != null
                              ? CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: FileImage(
                                    controller.image!,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: NetworkImage(
                                      "${AppApi.getImageUsersUrl}${controller.photoUserController.text}"),
                                ),
                          Positioned(
                            bottom: 5, left: 10,
                            //right: 18,
                            child: IconButton(
                              icon: const Icon(
                                Icons.add_a_photo,
                              ),
                              onPressed: () {
                                controller.showOptions(context);
                              },
                            ),
                          )
                        ],
                      ),
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
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Please enter a Middle Name";
                  //     }
                  //   },
                  //   // controller: context.read<LoginCubit>().emailController,
                  // ),
                  // verticalSpace(
                  //   10,
                  // ),
                  // AppTextFormField(
                  //   hintText: "PseudoName",
                  //   validator: (value) {},
                  //   // controller: context.read<LoginCubit>().emailController,
                  // ),
                  // verticalSpace(
                  //   10,
                  // ),
                  AppTextFormField(
                    hintText: "Last Name",
                    controller: controller.lastNameController,
                    validator: (value) {},
                    // controller: context.read<LoginCubit>().emailController,
                  ),
                  verticalSpace(
                    10,
                  ),
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
                  //     AppTextFormField(
                  //       hintText: "Email",
                  //       validator: (value) {},
                  //       // controller: context.read<LoginCubit>().emailController,
                  //     ),
                  //     verticalSpace(
                  //       10,
                  //     ),
                  //   ],
                  // ),
                  GetBuilder<ProfileController>(builder: (c) {
                    print('date-----++++++++++${c.emailController.text}');
                    return InkWell(
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
                        child:
                            controller.selectedDateEditProfile.text.isNotEmpty
                                ? Text(
                                    controller.selectedDateEditProfile.text,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.eerieBlack,
                                    ),
                                  )
                                : Text(
                                    controller.selectedDateEditProfile.text,
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
                                  onSelectionChanged: c.onSelectionChanged,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                )));
                          },
                        );
                      },
                    );
                  }),
                  verticalSpace(
                    10,
                  ),
                  AppTextFormField(
                    hintText: "Email",
                    validator: (value) {},
                    controller: controller.emailController,
                  ),
                  verticalSpace(
                    10,
                  ),
                  verticalSpace(62),
                  AppTextButton(
                    text: " Update",
                    onPressed: () {
                      controller.updateUser();
                    },
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  verticalSpace(50),
                ],
              ),
            ),
          ),
        ));
  }
}
