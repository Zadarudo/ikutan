import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikutan/controller/auth_controller.dart';
import 'package:ikutan/core/routes.dart';
import 'package:ikutan/utils/const.dart';
import 'package:ikutan/utils/helper.dart';
import 'package:ikutan/utils/validator.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _controller = Get.find<AuthController>(); // ✅ use find, not put

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
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

                // 🔹 Name
                TextFormField(
                  validator: Validator.validateName,
                  controller: _controller.nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  onTapOutside: Helper.onTapOutside,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  autofillHints: const [AutofillHints.name],
                ),

                const SizedBox(height: 20),

                // 🔹 Email
                TextFormField(
                  validator: Validator.validateEmail,
                  controller: _controller.emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  onTapOutside: Helper.onTapOutside,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                ),

                const SizedBox(height: 20),

                // 🔹 Password (reactive)
                Obx(() => TextFormField(
                      validator: Validator.validatePassword,
                      controller: _controller.passwordController,
                      obscureText: _controller.isObscure.value,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: const OutlineInputBorder(),
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
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [AutofillHints.password],
                    )),

                const SizedBox(height: 20),

                // 🔹 Confirm Password (reactive)
                Obx(() => TextFormField(
                      validator: (value) =>
                          Validator.validateConfirmPassword(
                        value,
                        _controller.passwordController.text,
                      ),
                      controller:
                          _controller.confirmPasswordController,
                      obscureText:
                          _controller.isObscureConfirm.value,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _controller.isObscureConfirm.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed:
                              _controller.toggleObscureConfirm,
                        ),
                      ),
                      onTapOutside: Helper.onTapOutside,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      autofillHints: const [AutofillHints.password],
                    )),

                const SizedBox(height: 20),

                // 🔹 Button (reactive)
                Obx(() => ElevatedButton(
                      onPressed: _controller.isLoading.value
                          ? null
                          : _controller.register,
                      child: _controller.isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text("Register"),
                    )),

                const SizedBox(height: 20),

                // 🔹 Navigation
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Login",
                        style:
                            const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              Get.toNamed(AppRoutes.login),
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