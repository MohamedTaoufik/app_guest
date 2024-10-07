import 'dart:io';

import 'package:app_guest/controllers/profile_controller.dart';
import 'package:app_guest/core/helperes/spacing.dart';
import 'package:app_guest/core/networking/app_api.dart';
import 'package:app_guest/core/storage/app_storage.dart';
import 'package:app_guest/core/theming/app_colors.dart';
import 'package:app_guest/screens/event/my_events_screen.dart';
import 'package:app_guest/screens/notifications_screen.dart';
import 'package:app_guest/screens/profile/edit_profile_screen.dart';
import 'package:app_guest/screens/profile/new_password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  ProfileController profileController = Get.put(ProfileController());
  String? tempPath;

  @override
  Widget build(BuildContext context) {
    profileController.getMembre(context);
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  //     padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    //  color: APP,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<ProfileController>(
                        builder: (controller) => Text("data"),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(20),
                          Text(
                            '${AppStorage.readName()}', // Afficher dynamiquement le nom d'utilisateur
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${AppStorage.readEmail()}', // Afficher dynamiquement l'e-mail
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    // color: Colors.white, // Couleur de fond du container
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.dark_mode_rounded,
                          color: AppColors.blue,
                        ),

                        title: Text('Dark mode'),
                        //    subtitle: controller.darkModeEnabled ? "Enabled" : "Disabled",
                        trailing: Switch.adaptive(
                          value: true,
                          onChanged: (value) {
                            // controller.toggleDarkMode();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: AppColors.blue,
                        ),
                        title: Text('Language'),
                        subtitle: Text("English"),
                        trailing: Switch.adaptive(
                          value: true,
                          onChanged: (value) {
                            // controller.toggleDarkMode();
                          },
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(const EditProfileScreen());
                        },
                        leading: Icon(
                          Icons.edit_outlined,
                          color: AppColors.blue,
                        ),

                        title: Text("Edit Profile"),
                        //     subtitle:Text("English"),
                        trailing: Switch.adaptive(
                          value: true,
                          onChanged: (value) {
                            // controller.toggleDarkMode();
                          },
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NewPasswordScreen(
                              title: "Changer Password",
                            ),
                          ));
                        },
                        leading: Icon(
                          Icons.lock_rounded,
                          color: AppColors.blue,
                        ),

                        title: Text("Changer Password"),
                        //     subtitle:Text("English"),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.event,
                          color: AppColors.blue,
                        ),
                        title: Text("My Events"),
                        onTap: () {
                          Get.to(MyEventsScreen());
                        },
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(NotificationScreen());
                        },
                        leading: Icon(
                          Icons.notification_add_outlined,
                          color: AppColors.blue,
                        ),

                        title: Text("My Notifications"),
                        //     subtitle:Text("English"),
                        trailing: Switch.adaptive(
                          value: true,
                          onChanged: (value) {
                            // controller.toggleDarkMode();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: AppColors.blue,
              ),
              title: const Text('Log out'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text(
                          'Êtes-vous sûr de vouloir vous déconnecter ?'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Annuler'),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Fermer le AlertDialog
                          },
                        ),
                        ElevatedButton(
                          child: const Text('Déconnexion'),
                          onPressed: () {
                            profileController.logOut();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
