import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitak_machine/controller/login_controller.dart';
import 'package:jitak_machine/view/home_page.dart';
import 'package:jitak_machine/view/widget/custom_button.dart';

import 'widget/text_frorm_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    
    return Scaffold(

      body: Column(
        children: [
          Text('Login Page'),
          // Add your login form or widgets he
          CustomTextFormField(
            labelText: 'Email',
            hintText: 'Enter your email',
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          CustomTextFormField(
            labelText: 'Password',
            hintText: 'Enter your password',
            controller: controller.passwordController,
            isPassword: true,
            prefixIcon: Icons.lock,
            suffixIcon: Icons.visibility,
            onSuffixTap: () {
              // Handle visibility toggle
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
          CustomButton(text: "Login", onPressed: (){
            Get.to( HomeView());
          })
        ],
      ),
    );
  }
}
