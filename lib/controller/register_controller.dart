import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jitak_machine/model/user_model.dart';
import 'package:collection/collection.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedImage.value == null) {
      Get.snackbar("Error", "Please select an image");
      return;
    }

    final box = await Hive.openBox<UserModel>('users');
    final existingUser = box.values
        .firstWhereOrNull((u) => u.email == emailController.text.trim());

    if (existingUser != null) {
      Get.snackbar("Error", "User already exists");
      return;
    }

    final newUser = UserModel(
      email: emailController.text.trim(),
      password: passwordController.text,
      imagePath: selectedImage.value!.path,
    );

    await box.add(newUser);
    Get.back();
    Get.snackbar("Success", "Registration complete");
  }
}
