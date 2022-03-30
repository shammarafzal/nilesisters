import 'package:get/get.dart';
import 'package:nilesisters/screens/Auth/forgotPassword.dart';
import 'package:nilesisters/screens/Auth/login_screen.dart';
import 'package:nilesisters/screens/Auth/newPassword.dart';
import 'package:nilesisters/screens/Auth/signup.dart';
import 'package:nilesisters/screens/Auth/verifyToken.dart';
import 'package:nilesisters/screens/HomePage.dart';

class Routes{
  static final routes = [
    GetPage(
      name: '/signup',
      page: () => Signup(),
    ),
    GetPage(
      name: '/login',
      page: () => Login(),
    ),
    GetPage(
      name: '/forgot_password',
      page: () => ForgotPassword(),
    ),
    GetPage(
      name: '/home_page',
      page: () => HomePage(),
    ),
    GetPage(
      name: '/forgot_password',
      page: () => ForgotPassword(),
    ),
    GetPage(
      name: '/verify_token',
      page: () => VerifyToken(),
    ),
    GetPage(
      name: '/new_password',
      page: () => NewPassword(),
    ),
  ];
}
