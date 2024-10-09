import 'dart:io';
import 'dart:typed_data';

import 'package:app_guest/controllers/event_controller.dart';
import 'package:app_guest/core/components/event/custom_event_card.dart';
import 'package:app_guest/core/components/event/custom_my_event.dart';
import 'package:app_guest/core/components/profile/app_button.dart';

import 'package:app_guest/core/components/profile/app_text_form_field.dart';
import 'package:app_guest/core/components/profile/custom_drop_dow_button.dart';
import 'package:app_guest/core/networking/app_api.dart';

import 'package:app_guest/core/storage/app_storage.dart';
import 'package:app_guest/core/theming/app_colors.dart';
import 'package:app_guest/screens/event/details_event_screen.dart';
import 'package:app_guest/screens/event/event_comments_screen.dart';
import 'package:app_guest/screens/event/update_event_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MyEventsScreen extends GetView<EventController> {
  MyEventsScreen({super.key});
  List<String> typeEvent = [
    "on line",
    "off line",
  ];
  TextEditingController commentaireController = TextEditingController();
  void _showSharePopup(BuildContext context, String idProdList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inviter un membre '),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                focusNode: controller.focusNode,
                decoration: InputDecoration(

                    //uses less vertical space
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 18.h,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.blue,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.veryLightGrey,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.circular(16.0)),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.eerieBlack,
                    ),
                    hintText: "email",
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.getMembreByemail(
                            context, commentaireController.text);
                        // controller.ajoutComment(con.commentaireController.text);
                        // controller.commentaireController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                    fillColor: AppColors.moreLightGrey,
                    filled: true),
                obscureText: false,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.eerieBlack,
                ),
                controller: commentaireController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a email";
                  }
                  return null;
                },
                onChanged: (p0) {
                  //   con.onChanged(p0);
                },
              ),
            ],
          ),
          // actions: [
          //   ElevatedButton(
          //     onPressed: () async {
          //       // await profileController.getUserByEmail(
          //       //     emailController.text, context, widget.idList);
          //     },
          //     child: const Text('Inviter'),
          //   ),
          // ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: const Text(
            "My Events",
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
        body: GetBuilder<EventController>(
          builder: (controller) => Expanded(
            child: FutureBuilder(
                future: controller.getAllEventByUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.data!.isNotEmpty) {
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.only(left: 10),
                        itemCount: controller.allEventModelByUser!.data!.length,
                        itemBuilder: (context, index) {
                          return GetBuilder<EventController>(
                            builder: (controller) => Slidable(
                              startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        width: 80,
                                        child: SlidableAction(
                                          onPressed: (BuildContext context) {
                                            print(
                                                'click update---------------------------------');
                                            AppStorage.saveIdEvent(controller
                                                .allEventModelByUser!
                                                .data![index]
                                                .sId
                                                .toString());
                                            //controller.getServiceById();
                                            controller.nomEvent.text =
                                                '${controller.allEventModelByUser!.data![index].eventTitle}';
                                            controller.placeEvent.text =
                                                '${controller.allEventModelByUser!.data![index].eventDescription}';
                                            controller.getEventById(controller
                                                .allEventModelByUser!
                                                .data![index]
                                                .sId!);
                                            Get.to(UpdateEventScreen(
                                              // '${controller.allEventModel!.data![index].eventName}',
                                              // '${controller.allEventModel!.data![index].eventPlace}',
                                              controller.allEventModelByUser!
                                                  .data![index].eventGalleries!,
                                            ));
                                          },
                                          backgroundColor: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          padding: const EdgeInsets.all(10),
                                          label: 'Update',
                                        ),
                                      ),
                                    ),
                                  ]),
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    Expanded(
                                        child: SizedBox(
                                      height: 50,
                                      width: 80,
                                      child: SlidableAction(
                                        onPressed: (BuildContext context) {
                                          AppStorage.saveIdEvent(controller
                                              .allEventModel!.data![index].sId
                                              .toString());

                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                //   GetBuilder<
                                                //       ServiceController>(
                                                // init: ServiceController(),
                                                // builder: (controller) =>
                                                AlertDialog(
                                              title: const Text(
                                                  'supprimer evenment'),
                                              content: const Text(
                                                  "êtes-vous sûr de supprimer l'événement?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    //       Get.back(); // Close the dialog
                                                  },
                                                  child: const Text('fermer'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // setState(() {
                                                    controller.deleteEvent();
                                                    //   });
                                                  },
                                                  child:
                                                      const Text('Supprimer'),
                                                ),
                                              ],
                                              //  ),
                                            ),
                                          );
                                        },
                                        backgroundColor: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                        padding: const EdgeInsets.all(10),
                                        label: 'Delete',
                                      ),
                                    )),
                                  ]),
                              child: CustomMyEventCard(
                                inviter: () {
                                  _showSharePopup(context, "idProdList");
                                },
                                onPressedIcon: () => Get.to(EventCommentsScreen(
                                  controller
                                      .allEventModelByUser!.data![index].sId,
                                )),
                                // widget: controller.listPhotoUsers.isNotEmpty
                                //     ? Expanded(
                                //         child: SizedBox(
                                //           height: 50,
                                //           child: ListView.builder(
                                //             scrollDirection: Axis.horizontal,
                                //             shrinkWrap: true,
                                //             itemBuilder: (context, index) =>
                                //                 Container(
                                //               padding: const EdgeInsets.all(
                                //                   3), // Ajustez le padding pour définir l'épaisseur de la bordure
                                //               decoration: const BoxDecoration(
                                //                 color: Colors
                                //                     .white, // Couleur de la bordure
                                //                 shape: BoxShape
                                //                     .circle, // Forme du conteneur
                                //               ),
                                //               child: CircleAvatar(
                                //                 radius: 15,
                                //                 backgroundImage: NetworkImage(
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

                                width: 400,
                                height: 300,
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
                                imageUrl:
                                    '${AppApi.getImageEventUrl}${controller.allEventModelByUser!.data![index].eventGalleries![0]}',
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 15,
                          );
                        },
                      );
                    }
                    return Center(
                      child: Column(
                        children: [
                          Image.asset("assets/images/no_data.jpg"),
                          const Text(
                            'Créer votre premiére event.',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: Column(
                      children: [
                        Image.asset("assets/images/no_data.jpg"),
                        const Text(
                          'Créer votre premiére event.',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }),
          ),
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
                      //---------------------------------------------------------declaration type event----------------------------------------------------------
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
                      //---------------------------------------------------------declaration type event----------------------------------------------------------

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
