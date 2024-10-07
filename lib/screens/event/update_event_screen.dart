
import 'package:app_guest/controllers/event_controller.dart';
import 'package:app_guest/core/components/profile/app_button.dart';
import 'package:app_guest/core/components/profile/app_text_form_field.dart';
import 'package:app_guest/core/components/profile/custom_drop_dow_button.dart';
import 'package:app_guest/core/networking/app_api.dart';
import 'package:app_guest/core/theming/app_colors.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UpdateEventScreen extends GetView<EventController> {
  // final String? nameEvent;
  // final String? adressEvent;
  List<String> typeEvent = [
    "on line",
    "off line",
  ];
  final List<String>? imagesEvent;
  UpdateEventScreen(this.imagesEvent, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              controller.formKey.currentState!.reset();

              Get.back();
            }),
        title: const Text(
          "Update Event",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
            child: Form(
              key: controller.formKey,
              child: ListBody(
                mainAxis: Axis.vertical,
                children: <Widget>[
                  InkWell(
                    child: GetBuilder<EventController>(
                        builder: (controller) => controller.images!.isNotEmpty
                            ? Container(
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                      enableInfiniteScroll: false),
                                  items: controller.images!
                                      .map((item) => Container(
                                            child: Center(
                                                child: Image.file(item,
                                                    fit: BoxFit.cover,
                                                    width: 1000)),
                                          ))
                                      .toList(),
                                ),
                              )
                            : imagesEvent!.length > 0
                                ? Container(
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                          enableInfiniteScroll: false),
                                      items: imagesEvent!
                                          .map((item) => Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Image.network(
                                                        "${AppApi.getImageEventUrl}$item",
                                                        fit: BoxFit.cover,
                                                        width: 1000)),
                                              ))
                                          .toList(),
                                    ),
                                  )
                                : const SizedBox.shrink()),
                    onTap: () {
                      controller.showOptions(context);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextFormField(
                    controller: controller.titleController,
                    validator: (nom) {
                      if (nom!.isEmpty) {
                        return "Entrer  titre event  !";
                      }
                      return null;
                    },
                    // labelText: "Nom Evenement",
                    hintText: "Titre Evénement:",
                    suffixIcon: const Icon(Icons.event),
                    // controller: controller.nomEventontroller,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextFormField(
                    controller: controller.timeController,
                    validator: (nom) {
                      if (nom!.isEmpty) {
                        return "Entrer  time event  !";
                      }
                      return null;
                    },
                    // labelText: "Nom Evenement",
                    hintText: "Time  Evénement:",
                    suffixIcon: const Icon(Icons.browse_gallery_outlined),
                    // controller: controller.nomEventontroller,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextFormField(
                    controller: controller.adressController,
                    validator: (nom) {
                      if (nom!.isEmpty) {
                        return "Entrer  adress event  !";
                      }
                      return null;
                    },
                    // labelText: "Nom Evenement",
                    hintText: "Adress Evénement:",
                    suffixIcon: const Icon(Icons.location_city),
                    // controller: controller.nomEventontroller,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextFormField(
                    controller: controller.descriptionController,
                    validator: (nom) {
                      if (nom!.isEmpty) {
                        return "Entrer  description event  !";
                      }
                      return null;
                    },
                    // labelText: "Nom Evenement",
                    hintText: "Description Evénement:",
                    suffixIcon: const Icon(Icons.description),
                    // controller: controller.nomEventontroller,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<EventController>(
                    builder: (controller) {
                      return CustomDropDowButton(
                        hintText: "type event",
                        selectedValue: controller.selectedValue,
                        list: typeEvent,
                        onChanged: (p0) => controller.onChnagedDropDown(p0!),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<EventController>(
                    builder: (controller) => InkWell(
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
                                    "Date evenement",
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
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextFormField(
                    controller: controller.latitudeController,
                    validator: (nom) {
                      if (nom!.isEmpty) {
                        return "Entrer latitude coordinates event  !";
                      }
                      return null;
                    },
                    // labelText: "Nom Evenement",
                    hintText: "Latitude Coordinates Evénement:",
                    suffixIcon: const Icon(Icons.location_on),
                    // controller: controller.nomEventontroller,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextFormField(
                    controller: controller.longitudeController,
                    validator: (nom) {
                      if (nom!.isEmpty) {
                        return "Entrer longitude coordinates event  !";
                      }
                      return null;
                    },
                    // labelText: "Nom Evenement",
                    hintText: "Longitude Coordinates Evénement:",
                    suffixIcon: const Icon(Icons.location_on),
                    // controller: controller.nomEventontroller,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  AppTextButton(
                    text: "Update",
                    onPressed: () {
                      print('valide----------------------------');
                      if (controller.formKey.currentState!.validate()) {
                        print('valide------------------------------');
                        controller.updateEvent();
                      }
                      // validateThenDoLogin(context);
                    },
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
