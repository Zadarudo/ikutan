import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ikutan/core/routes.dart';
import 'package:ikutan/providers/auth_provider.dart';
import 'package:ikutan/services/auth_service.dart';
import 'package:ikutan/utils/show_snack.dart';
import 'package:ikutan/models/user_models.dart';

class AuthController extends GetxController {
  late final AuthProvider _auth;
  late final AuthServices _authServices;

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
  void onInit() {
    super.onInit();
    _auth = Get.find<AuthProvider>();
    _authServices = Get.find<AuthServices>();
  }

  // ✅ Do NOT dispose TextEditingControllers here —
  // GetX may reuse this instance across routes via fenix.
  // Flutter will clean them up when the widget tree is gone.

  void toggleObscure() => isObscure.value = !isObscure.value;
  void toggleObscureConfirm() => isObscureConfirm.value = !isObscureConfirm.value;

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    isLoading(true);
    try {
      final res = await _auth.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      if (res.statusCode == 200) {
        await _authServices.saveToken(
          token: res.body['data']['token'],
          userData: User.fromJson(res.body['data']['user']),
        );
        Get.offAllNamed(AppRoutes.home);
      } else {
        throw res.body['message'];
      }
    } catch (e) {
      ShowSnack.errors(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;
    isLoading(true);
    try {
      final res = await _auth.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        ShowSnack.success('Account created! Please log in.');
        Get.offAllNamed(AppRoutes.login);
      } else {
        final errors = res.body['errors'];
        if (errors is! Map) {
          throw res.body['message'];
        } else {
          throw errors.values.first[0];
        }
      }
    } catch (e) {
      ShowSnack.errors(e.toString());
    } finally {
      isLoading(false);
    }
  }
}