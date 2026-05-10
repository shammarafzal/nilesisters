import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();

  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  void changeIndex(int index) {
    _selectedIndex.value = index;
    // If we are not on the home page, go to it
    if (Get.currentRoute != '/home_page') {
      Get.offAllNamed('/home_page');
    }
  }

  void setIndexSilently(int index) {
    _selectedIndex.value = index;
  }
}
