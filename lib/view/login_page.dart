import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitak_machine/controller/login_controller.dart';
import 'package:jitak_machine/view/home_page.dart';
import 'package:jitak_machine/view/register_page.dart';
import 'package:jitak_machine/view/widget/custom_button.dart';
import 'widget/text_frorm_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/logo.png', height: 100),
                  const SizedBox(height: 24),

             
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Email Field
                  CustomTextFormField(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'This field is required'
                                : null,
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  CustomTextFormField(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    controller: controller.passwordController,
                    isPassword: true,
                    prefixIcon: Icons.lock,
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'This field is required'
                                : null,
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  CustomButton(
                    text: "Login",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final success = await controller.loginUser();
                        if (success) {
                          Get.offAll(() => const HomeView());
                        } else {
                          Get.snackbar(
                            'Error',
                            'Invalid credentials',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () => Get.to(() => RegisterPage()),
                    child: const Text(
                      'Don’t have an account? Register',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
