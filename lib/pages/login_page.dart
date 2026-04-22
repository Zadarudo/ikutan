import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikutan/controller/auth_controller.dart';
import 'package:ikutan/core/routes.dart';
import 'package:ikutan/utils/const.dart';
import 'package:ikutan/utils/helper.dart';
import 'package:ikutan/utils/validator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _controller.loginFormKey,
            child: Column(
              children: [
                Text(
                  Const.appName,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  "Login To Continue",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: Validator.validateEmail,
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
                Obx(
                  () => TextFormField(
                    validator: Validator.validatePassword,
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
                    onFieldSubmitted: (_) => _controller.login(),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  final isLoading =
                      _controller.isLoading.value; // read here, inside Obx
                  return ElevatedButton(
                    onPressed: isLoading ? null : _controller.login,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Login"),
                  );
                }),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Register",
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.offNamed(AppRoutes.register),
                        // Handle navigation to register page here,
                        // Add gesture recognizer for navigation to register page
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
