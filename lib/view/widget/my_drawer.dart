import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitak_machine/controller/login_controller.dart';
import 'package:jitak_machine/view/favorites_page.dart';


class MyAppDrawer extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();

  MyAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Obx(() {
              final user = loginController.loggedInUser.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: user?.imagePath != null
                        ? NetworkImage(user!.imagePath)
                        : const AssetImage("assets/profile.png")
                            as ImageProvider,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Hello, ${user?.name ?? 'User'}!",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              );
            }),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favorites"),
            onTap: () {
              Get.to(() => FavoritesView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              loginController.logoutUser();
            },
          ),
        ],
      ),
    );
  }
}
