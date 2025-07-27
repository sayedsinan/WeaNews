import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:jitak_machine/model/user_model.dart';
import 'package:jitak_machine/view/login_page.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Rxn<UserModel> loggedInUser = Rxn<UserModel>(); // observable user

  Future<bool> loginUser() async {
    final box = await Hive.openBox<UserModel>('users');

    final user = box.values.firstWhereOrNull(
      (u) =>
          u.email == emailController.text.trim() &&
          u.password == passwordController.text,
    );

    if (user != null) {
      final authBox = await Hive.openBox('auth');
      await authBox.put('loggedInUser', user.email);
      loggedInUser.value = user;
      return true;
    }

    return false;
  }

  Future<void> logoutUser() async {
    final authBox = await Hive.openBox('auth');
    await authBox.delete('loggedInUser');
    loggedInUser.value = null;
    Get.offAll(LoginPage());
  }

  Future<bool> isUserLoggedIn() async {
    final authBox = await Hive.openBox('auth');
    return authBox.containsKey('loggedInUser');
  }

  Future<String?> getLoggedInUserEmail() async {
    final authBox = await Hive.openBox('auth');
    return authBox.get('loggedInUser');
  }

  Future<void> loadLoggedInUser() async {
    final authBox = await Hive.openBox('auth');
    final email = authBox.get('loggedInUser');
    if (email != null) {
      final userBox = await Hive.openBox<UserModel>('users');
      final user = userBox.values.firstWhereOrNull((u) => u.email == email);
      loggedInUser.value = user;
    }
  }
}
