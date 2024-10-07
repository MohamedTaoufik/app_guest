import 'package:app_guest/controllers/comments_event_controller.dart';
import 'package:app_guest/controllers/event_controller.dart';
import 'package:app_guest/core/components/profile/app_text_form_field.dart';
import 'package:app_guest/core/networking/app_api.dart';
import 'package:app_guest/core/theming/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventCommentsScreen extends GetView<EventController> {
  final String? idEvent;
  const EventCommentsScreen(this.idEvent, {super.key});

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
              controller.commentaireController.clear();
              Get.back();
            }),
        title: const Text(
          "Event Comments",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: SizedBox(
          child:GetBuilder<EventController>(
                    builder: (c) => FutureBuilder(
            future: controller.getAlCommentsByEvent(idEvent),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data!.data!.isNotEmpty) {
                  return GetBuilder<EventController>(
                    builder: (c) => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: c.allCommentsByEventModel!.data!.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: c.allCommentsByEventModel!.data![index].userId!
                                    .userProfilePhoto !=
                                null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${AppApi.getImageUsersUrl}${c.allCommentsByEventModel!.data![index].userId!.userProfilePhoto!}"),
                              )
                            : const Icon(Icons
                                .person), // icône par défaut si pas d'image

                        subtitle: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.allCommentsByEventModel!.data![index]
                                  .userId!.userFirstName!),
                              const SizedBox(height: 5),
                              Text(c.allCommentsByEventModel!.data![index]
                                  .commentMessageContext!),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: [
                        Image.asset("assets/images/no_data.jpg"),
                        const Text(
                          'Créer votre premiére comment.',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }
              }
              return Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/no_data.jpg"),
                    const Text(
                      'Créer votre premiére comment.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            },
          ),
        ),),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GetBuilder<EventController>(
          builder: (con) {
            return TextFormField(
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
                  hintText: "ecrire votre commentaire",
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.ajoutComment(con.commentaireController.text);
                      controller.commentaireController.clear();
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
              controller: con.commentaireController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a comment";
                }
                return null;
              },
              onChanged: (p0) {
                con.onChanged(p0);
              },
            );
          },
        ),
      ),
    );
  }
}
