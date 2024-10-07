import 'dart:typed_data';
import 'package:app_guest/core/components/profile/app_button.dart';
import 'package:app_guest/core/components/profile/app_text_form_field.dart';
import 'package:app_guest/core/networking/app_api.dart';
import 'package:app_guest/core/storage/app_storage.dart';
import 'package:app_guest/core/theming/app_colors.dart';
import 'package:app_guest/screens/event/event_comments_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:app_guest/controllers/event_controller.dart';
import 'package:app_guest/core/components/custom_drawer.dart';
import 'package:app_guest/core/components/event/custom_event_card.dart';
import 'package:app_guest/core/components/profile/custom_drop_dow_button.dart';
import 'package:app_guest/screens/event/details_event_screen.dart';
import 'package:app_guest/screens/event/update_event_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<EventController> {
  HomeScreen({super.key});
  List<String> typeEvent = [
    "on line",
    "off line",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: const Text(
            "Events",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue[700],
          elevation: 0,
        ),
        drawerScrimColor: Colors.white,
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "UpComing Events",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GetBuilder<EventController>(
              builder: (controller) => FutureBuilder(
                  future: controller.getAllEvent(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data!.data!.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.only(left: 10),
                            itemCount: controller.allEventModel!.data!.length,
                            itemBuilder: (context, index) {
                              // controller.getAlCommentsByEvent(
                              //     controller.allEventModel!.data![index].sId);

                              return GetBuilder<EventController>(
                                builder: (controller) => CustomEventCard(
                                  // widget:
                                  //     // controller.listPhotoUsers != []
                                  //     // ?
                                  //     Expanded(
                                  //   child: SizedBox(
                                  //     height: 35,
                                  //     child: ListView.builder(
                                  //       scrollDirection: Axis.horizontal,
                                  //       shrinkWrap: true,
                                  //       itemBuilder: (context, index) =>
                                  //           Container(
                                  //               padding: const EdgeInsets.all(
                                  //                   3), // Ajustez le padding pour définir l'épaisseur de la bordure
                                  //               decoration: const BoxDecoration(
                                  //                 color: Colors
                                  //                     .white, // Couleur de la bordure
                                  //                 shape: BoxShape
                                  //                     .circle, // Forme du conteneur
                                  //               ),
                                  //               child: const Text('dddd')
                                  //               //  CircleAvatar(
                                  //               //   radius: 15,
                                  //               //   backgroundImage:
                                  //               //       NetworkImage(
                                  //               //     "${AppApi.getImageUsersUrl}${controller.listPhotoUsers[index]}",
                                  //               //     // width: width,
                                  //               //     // height: 300.0,
                                  //               //   ),
                                  //               // ),
                                  //               ),
                                  //       itemCount: 3,
                                  //     ),
                                  //   ),
                                  // ),

                                  // :
                                  // const SizedBox.shrink(),
                                  inviter: () {},
                                  width: 250,
                                  title: controller
                                      .allEventModel!.data![index].eventTitle,

                                  onPressedIcon: () {
                                    print(
                                        'id ================>${controller.allEventModel!.data![index].sId}');
                                    AppStorage.saveIdEvent(controller
                                        .allEventModel!.data![index].sId);

                                    Get.to(EventCommentsScreen(
                                      controller
                                          .allEventModel!.data![index].sId,
                                    ));
                                  },
                                  onPressed: () {
                                    print('click btn------------');
                                    Get.to(
                                      DetailsEventScreen(
                                        nameEvent:
                                            '${controller.allEventModel!.data![index].eventTitle}',
                                        adressEvent:
                                            '${controller.allEventModel!.data![index].eventPlace}',
                                        imagesEvent: controller.allEventModel!
                                            .data![index].eventGalleries!,
                                        cityEvent:
                                            '${controller.allEventModel!.data![index].eventAddress}',
                                        dateEvent:
                                            '${controller.allEventModel!.data![index].eventDate}',
                                        description:
                                            '${controller.allEventModel!.data![index].eventDescription}',
                                        typeEvent:
                                            '${controller.allEventModel!.data![index].eventType}',
                                      ),
                                    );
                                  },
                                  imageUrl:
                                      '${AppApi.getImageEventUrl}${controller.allEventModel!.data![index].eventGalleries![0]}',
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset("assets/images/no_data.jpg"),
                                const Text(
                                  'Créer votre premiére event.',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                    return Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Expanded(
                                child:
                                    Image.asset("assets/images/no_data.jpg")),
                            const Text(
                              'Créer votre premiére event.',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "My Events",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<EventController>(
                builder: (controller) => FutureBuilder(
                    future: controller.getAllEventByUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.data!.isNotEmpty) {
                          return SizedBox(
                            height: 330,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.only(left: 10),
                              itemCount:
                                  controller.allEventModelByUser!.data!.length,
                              itemBuilder: (context, index) {
                                // controller.getAlCommentsByEvent(
                                //     controller.allEventModel!.data![index].sId);
                                return GetBuilder<EventController>(
                                  builder: (controller) => CustomEventCard(
                                    // widget: controller.listPhotoUsers.isNotEmpty
                                    //     ? Expanded(
                                    //         child: SizedBox(
                                    //           height: 50,
                                    //           child: ListView.builder(
                                    //             scrollDirection:
                                    //                 Axis.horizontal,
                                    //             shrinkWrap: true,
                                    //             itemBuilder: (context, index) =>
                                    //                 Container(
                                    //               padding: const EdgeInsets.all(
                                    //                   3), // Ajustez le padding pour définir l'épaisseur de la bordure
                                    //               decoration:
                                    //                   const BoxDecoration(
                                    //                 color: Colors
                                    //                     .white, // Couleur de la bordure
                                    //                 shape: BoxShape
                                    //                     .circle, // Forme du conteneur
                                    //               ),
                                    //               child: CircleAvatar(
                                    //                 radius: 15,
                                    //                 backgroundImage:
                                    //                     NetworkImage(
                                    //                   "${AppApi.getImageUsersUrl}${controller.listPhotoUsers[index]}",
                                    //                   // width: width,
                                    //                   // height: 300.0,
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //             itemCount: controller
                                    //                 .listPhotoUsers.length,
                                    //           ),
                                    //         ),
                                    //       )
                                    //     : const SizedBox.shrink(),

                                    width: 300,
                                    title:
                                        '${controller.allEventModelByUser!.data![index].eventTitle}',
                                    // dispoDate: controller.allEventModel!
                                    //     .data![index].eventPlace!,
                                    onPressed: () {
                                      print('click btn------------');
                                      Get.to(
                                        DetailsEventScreen(
                                          nameEvent:
                                              '${controller.allEventModel!.data![index].eventTitle}',
                                          adressEvent:
                                              '${controller.allEventModel!.data![index].eventPlace}',
                                          imagesEvent: controller.allEventModel!
                                              .data![index].eventGalleries!,
                                          cityEvent:
                                              '${controller.allEventModel!.data![index].eventAddress}',
                                          dateEvent:
                                              '${controller.allEventModel!.data![index].eventDate}',
                                          description:
                                              '${controller.allEventModel!.data![index].eventDescription}',
                                          typeEvent:
                                              '${controller.allEventModel!.data![index].eventType}',
                                        ),
                                      );
                                    },

                                    onPressedIcon: () =>
                                        Get.to(EventCommentsScreen(
                                      controller.allEventModelByUser!
                                          .data![index].sId,
                                    )),
                                    imageUrl:
                                        '${AppApi.getImageEventUrl}${controller.allEventModelByUser!.data![index].eventGalleries![0]}',
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                Expanded(
                                    child: Image.asset(
                                        "assets/images/no_data.jpg")),
                                const Text(
                                  'Créer votre premiére event.',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  "assets/images/no_data.avif",
                                ),
                              ),
                              const Text(
                                'Créer votre premiére event.',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          // icon: Icon(Icons.add_outlined),
          label: const Text('Créer Evénement'),
          onPressed: () {
            Get.dialog(AlertDialog(
              title: const Text("Nouvelle Evénement",
                  style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: ListBody(
                    mainAxis: Axis.vertical,
                    children: <Widget>[
                      //event title

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
                            onChanged: (p0) =>
                                controller.onChnagedDropDown(p0!),
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
                            padding: EdgeInsets.only(
                                left: 18.w, top: 8.h, bottom: 8.h),
                            decoration: BoxDecoration(
                              color: AppColors.moreLightGrey,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.veryLightGrey,
                                width: 1,
                              ),
                            ),
                            child: controller
                                    .selectedDateEditProfile.text.isNotEmpty
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
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 18,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                16,
                              ),
                            ),
                            color: Colors.white,
                            // borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text('Ajout images'),
                        ),
                        onTap: () {
                          controller.showOptions(context);
                        },
                      ),
                      GetBuilder<EventController>(
                          builder: (controller) => controller.images!.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      controller.images!.length,
                                      (index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.file(
                                            controller.images![index],
                                            width: 70,
                                            height: 80,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink()),

                      const SizedBox(
                        height: 18,
                      ),
                      AppTextButton(
                        text: "Ajout ",
                        onPressed: () {
                          if (controller.formKey.currentState!.validate() &&
                              controller.images!.isNotEmpty) {
                            print('valide-----------------');
                            controller.ajoutEvent();
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
              actions: const <Widget>[
                // GetBuilder<EventController>(
                //   builder: (controller) {
                //     return TextButton(
                //       child: Text(
                //         'Add',
                //         style: TextStyle(color: AppColor.secondary, fontSize: 20),
                //       ),
                //       onPressed: () {
                //         controller.createEvent();
                //         Get.to(EventListView());
                //         Navigator.of(context).pop();
                //       },
                //     );
                //   },
                // )
              ],
            ));
          },
        ),
      ),
    );
  }
}
