import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ikutan/core/routes.dart';
import 'package:ikutan/providers/auth_provider.dart';
import 'package:ikutan/utils/const.dart';
import 'package:ikutan/models/user_models.dart';

class AuthServices extends GetxService {
final AuthProvider _authProvider = Get.find<AuthProvider>();
final _storage = FlutterSecureStorage();
RxBool isLogin = false.obs;
Rx<User?> user = Rx<User?>(null);

@override
void onInit() {
  super.onInit();
  init();
}

Future<String?> get token => _storage.read(key: Const.tokenKey);

Future<void> saveToken({required String token, required User userData}) async {
  await _storage.write(key: Const.tokenKey, value: token);
  user.value = userData;
  isLogin(true);
}

Future<void> deleteToken() async {
  await _storage.delete(key: Const.tokenKey);
  isLogin(false);
}

// In AuthServices - remove the delayed navigation entirely
Future<void> init() async {
  final token = await this.token;

  if (token != null) {
    try {
      final res = await _authProvider.me();
      if (res.statusCode == 200) {
        user.value = User.fromJson(res.body);
        isLogin(true);
      } else {
        await deleteToken();
      }
    } catch (e) {
      await deleteToken();
    }
  }

}

Future<void> logout() async {
  await _authProvider.logout();
  await deleteToken();
  Get.offAllNamed(AppRoutes.login);
}
}