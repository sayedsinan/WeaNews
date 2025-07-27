import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitak_machine/controller/register_controller.dart';
import 'package:jitak_machine/view/widget/custom_button.dart';
import 'package:jitak_machine/view/widget/text_frorm_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Obx(() => GestureDetector(
                    onTap: controller.pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: controller.selectedImage.value != null
                          ? FileImage(controller.selectedImage.value!)
                          : null,
                      child: controller.selectedImage.value == null
                          ? const Icon(Icons.add_a_photo, size: 30)
                          : null,
                    ),
                  )),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: 'Email',
                hintText: 'Enter your email',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
                validator: (value) => value == null || value.isEmpty
                    ? 'This field is required'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: 'Password',
                hintText: 'Enter your password',
                controller: controller.passwordController,
                isPassword: true,
                prefixIcon: Icons.lock,
                validator: (value) => value == null || value.length < 6
                    ? 'Min 6 characters'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                labelText: 'Confirm Password',
                hintText: 'Re-enter your password',
                controller: controller.confirmPasswordController,
                isPassword: true,
                prefixIcon: Icons.lock,
                
                validator: (value) => value != controller.passwordController.text
                    ? 'Passwords do not match'
                    : null,
              ),
              const SizedBox(height: 20),
              CustomButton(text: "Register", onPressed: controller.registerUser),
            ],
          ),
        ),
      ),
    );
  }
}
