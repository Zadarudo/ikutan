import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikutan/models/nav_item.dart';
import 'package:ikutan/pages/nav/events_tab.dart';
import 'package:ikutan/pages/nav/main_tab.dart';
import 'package:ikutan/pages/nav/my_tickets_tab.dart';
import 'package:ikutan/pages/nav/profile_tab.dart';
import 'package:ikutan/pages/nav/scan_tab.dart';
import 'package:ikutan/services/auth_service.dart';

class NavController extends GetxController {
  final AuthServices _authServices = Get.find();
  RxInt currentIndex = 0.obs;

  late List<NavItem> navItem;

  @override
  void onInit() {
    super.onInit();
    final role = _authServices.user.value?.role;

    if (role == 'attendee') {
      navItem = [
        NavItem(label: 'Home', icon: const Icon(Icons.home), screen: const MainTab()),
        NavItem(label: 'My Tickets', icon: const Icon(Icons.confirmation_num), screen: const MyTicketsTab()),
        NavItem(label: 'Profile', icon: const Icon(Icons.person), screen: ProfileTab()),
      ];
    } else {
      // admin or organizer
      navItem = [
        NavItem(label: 'Home', icon: const Icon(Icons.home), screen: const MainTab()),
        NavItem(label: 'Events', icon: const Icon(Icons.campaign), screen: const EventsTab()),
        NavItem(label: 'Scan', icon: const Icon(Icons.qr_code_scanner), screen: const ScanTab()),
        NavItem(label: 'Profile', icon: const Icon(Icons.person), screen: ProfileTab()),
      ];
    }
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}