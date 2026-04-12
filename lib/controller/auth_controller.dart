

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isObscure = true.obs;
  RxBool isObscureConfirm = true.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  void toggleObscureConfirm() {
    isObscureConfirm.value = !isObscureConfirm.value;
  }

  Future<void> login() async {
    // isLoading.value = true;
  }

  Future<void> register() async {
    // isLoading.value = true;
  }
}
