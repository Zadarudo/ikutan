import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikutan/controller/auth_controller.dart';
import 'package:ikutan/core/routes.dart';
import 'package:ikutan/utils/const.dart';
import 'package:ikutan/utils/helper.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Form(
              key: _controller.registerFormKey,
              child: Column(
                children: [
                  Text(
                    Const.appName,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Text(
                    "Register To Make an account",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _controller.nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                    onTapOutside: Helper.onTapOutside,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.name],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _controller.emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    onTapOutside: Helper.onTapOutside,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _controller.passwordController,
                    obscureText: _controller.isObscure.value,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _controller.isObscure.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _controller.toggleObscure,
                      ),
                    ),
                    onTapOutside: Helper.onTapOutside,
                    textInputAction: TextInputAction.send,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: const [AutofillHints.password],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller.confirmPasswordController,
                    obscureText: _controller.isObscureConfirm.value,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _controller.isObscureConfirm.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _controller.toggleObscureConfirm,
                      ),
                    ),
                    onTapOutside: Helper.onTapOutside,
                    textInputAction: TextInputAction.send,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: const [AutofillHints.password],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _controller.isLoading.value
                        ? null
                        : _controller.register,
                    child: const Text("Register"),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.toNamed(AppRoutes.login),
                          // Handle navigation to login page here,
                          // Add gesture recognizer for navigation to login page
                        ),
                      ],
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
