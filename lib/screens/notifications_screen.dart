
import 'package:app_guest/controllers/event_controller.dart';
import 'package:app_guest/core/networking/app_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Mes Notifications",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: GetBuilder<EventController>(
        builder: (controller) {
          return FutureBuilder(
            future: controller.getNotifByReceiver(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data!.data!.isNotEmpty) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.allNotificationsModel!.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shadowColor: Colors.black45,
                              elevation: 5,
                              color: Colors.purple[200],
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                leading: controller
                                            .allNotificationsModel!
                                            .data![index]
                                            .senderId!
                                            .userProfilePhoto !=
                                        null
                                    ? CircleAvatar(
                                        radius: 24,
                                        backgroundImage: NetworkImage(
                                          "${AppApi.getImageUsersUrl}${controller.allNotificationsModel!.data![index].senderId!.userProfilePhoto}",
                                        ),
                                      )
                                    : const CircleAvatar(
                                        radius: 24,
                                        //   backgroundColor: Colors.grey,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.purple,
                                        ),
                                      ),
                                title: Text(
                                  '${controller.allNotificationsModel!.data![index].senderId!.userFirstName} ${controller.allNotificationsModel!.data![index].senderId!.userLastName} a invité pour evenemnt',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Supprimer'),
                                        content: const Text(
                                            "Êtes-vous sûr de supprimer la notification?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Fermer'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                controller.deleteNotifi(
                                                    controller
                                                        .allNotificationsModel!
                                                        .data![index]
                                                        .sId
                                                        .toString());
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Supprimer'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                onTap: () {
                                  // controller.getListProdByUserAndType(
                                  //   context,
                                  //   notification.sender!.id!,
                                  //   notification.listPartage!.type!,
                                  // );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              }
              return const Center(
                child: Text(
                  'Pas de notifications.',
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
