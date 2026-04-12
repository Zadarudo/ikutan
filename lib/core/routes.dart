import 'package:get/get.dart';
import 'package:ikutan/bindings/auth_binding.dart';
import 'package:ikutan/pages/login_page.dart';
import 'package:ikutan/pages/register_page.dart';
import 'package:ikutan/pages/splash_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = "login";
  static const String register = "/register";

  //initial route
  static const String initialRoute = login;
  //pages
  static List<GetPage> pages = [
    GetPage(name: splash, page: () =>  SplashPage()),
    GetPage(name: '/login', page: () =>  LoginPage(), binding: AuthBinding()),
    GetPage(name: '/register', page: () =>  RegisterPage(), binding: AuthBinding()),
  ];

}