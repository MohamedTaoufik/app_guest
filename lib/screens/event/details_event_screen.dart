import 'package:app_guest/controllers/event_controller.dart';
import 'package:app_guest/core/networking/app_api.dart';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

// ignore: must_be_immutable
class DetailsEventScreen extends StatelessWidget {
  final String? nameEvent;
  final String? adressEvent;
  final String? description;
  final String? cityEvent;
  final String? dateEvent;
  final String? typeEvent;

  final List<String>? imagesEvent;
  bool click = false;
  EventController c = Get.put(EventController());
  DetailsEventScreen({
    super.key,
    this.nameEvent,
    this.imagesEvent,
    this.adressEvent,
    this.description,
    this.cityEvent,
    this.dateEvent,
    this.typeEvent,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              }),
          title: const Text(
            "Event Détails",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: CarouselSlider(
                    options: CarouselOptions(enableInfiniteScroll: false),
                    items: imagesEvent!
                        .map((item) => Container(
                              child: Center(
                                  child: Image.network(
                                      '${AppApi.getImageEventUrl}$item',
                                      fit: BoxFit.cover,
                                      width: 100)),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  nameEvent!,
                  style: const TextStyle(color: Colors.black, fontSize: 30),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Card(
                    shape: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.description,
                        color: Color.fromARGB(255, 88, 97, 105),
                      ),
                    ),
                  ),
                  title: Text(
                    description!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  // subtitle: const Text(
                  //   "Tuesday,4pm",
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 12,
                  //   ),
                  // ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Card(
                    shape: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.location_city,
                        color: Color.fromARGB(255, 88, 97, 105),
                      ),
                    ),
                  ),
                  title: Text(
                    cityEvent!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  // subtitle: const Text(
                  //   "Tuesday,4pm",
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 12,
                  //   ),
                  // ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Card(
                    shape: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.date_range,
                        color: Color.fromARGB(255, 88, 97, 105),
                      ),
                    ),
                  ),
                  title: Text(
                    dateEvent!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  // subtitle: const Text(
                  //   "Tuesday,4pm",
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 12,
                  //   ),
                  // ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Card(
                    shape: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.type_specimen,
                        color: Color.fromARGB(255, 88, 97, 105),
                      ),
                    ),
                  ),
                  title: Text(
                    typeEvent!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  // subtitle: const Text(
                  //   "Tuesday,4pm",
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 12,
                  //   ),
                  // ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
