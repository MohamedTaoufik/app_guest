import 'package:app_guest/controllers/profile_controller.dart';
import 'package:app_guest/core/helperes/spacing.dart';
import 'package:app_guest/core/networking/app_api.dart';
import 'package:app_guest/core/storage/app_storage.dart';
import 'package:app_guest/core/theming/app_colors.dart';
import 'package:app_guest/screens/event/my_events_screen.dart';
import 'package:app_guest/screens/notifications_screen.dart';
import 'package:app_guest/screens/profile/edit_profile_screen.dart';
import 'package:app_guest/screens/profile/new_password_screen.dart';
import 'package:app_guest/screens/profile/update_password_screen.dart';
import 'package:app_guest/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    profileController.getMembre();
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                            builder: (controller) => Expanded(
                              child: Stack(
                                children: [
                                  profileController.userMembreModel!
                                          .userProfilePhoto!.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 50.0,
                                          backgroundImage: NetworkImage(
                                            "${AppApi.getImageUsersUrl}${profileController.userMembreModel!.userProfilePhoto!}",
                                          ),
                                        )
                                      : profileController.image != null
                                          ? CircleAvatar(
                                              radius: 50.0,
                                              backgroundImage: FileImage(
                                                profileController.image!,
                                              ),
                                            )
                                          : const CircleAvatar(
                                              radius: 50.0,
                                              backgroundColor:
                                                  AppColors.lightGrey,
                                            ),
                                  Positioned(
                                    bottom: 5, left: 10,
                                    //right: 18,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.add_a_photo,
                                      ),
                                      onPressed: () {
                                        profileController.showOptions(context);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalSpace(20),
                                Text(
                                  '${profileController.firstNameController.text}${profileController.lastNameController.text}', // Afficher dynamiquement le nom d'utilisateur
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${profileController.emailController.text}', // Afficher dynamiquement l'e-mail
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.event),
                      title: Text("My Events"),
                      onTap: () {
                        Get.to(MyEventsScreen());
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(NotificationScreen());
                      },
                      leading: Icon(
                        Icons.notification_add_outlined,
                      ),
                      title: Text(
                        "My Notifications",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(EditProfileScreen());
                      },
                      leading: Icon(
                        Icons.person,
                      ),
                      title: Text(
                        "My profile",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(UpdatePasswordScreen());
                      },
                      leading: Icon(
                        Icons.password,
                      ),
                      title: Text(
                        "Update password",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(SettingsScreen());
                      },
                      leading: Icon(
                        Icons.settings,
                      ),
                      title: Text(
                        "Settings",
                      ),
                    ),
                  ],
                ),
              ),
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
