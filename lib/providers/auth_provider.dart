import 'package:get/get_connect/connect.dart';
import 'package:ikutan/providers/api_provider.dart';

class AuthProvider extends ApiProvider {

  Future<Response> me() async {
    return get('/me');
  }
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return post('/login', {'email': email, 'password': password});
  }

  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    return post('/register', {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
  }
}
