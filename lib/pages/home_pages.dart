import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ikutan/controller/nav_controller.dart';

class HomePages extends StatelessWidget {
  HomePages({super.key});

  final _navController = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: _navController.currentIndex.value,
          children: _navController.navItem.map((e) => e.screen).toList(),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: _navController.currentIndex.value,
          onTap: (value) => _navController.changeIndex(value),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepPurpleAccent,
          unselectedItemColor: Colors.grey,
          backgroundColor: const Color(0xFF1E1E1E),
          items: _navController.navItem
              .map((e) => BottomNavigationBarItem(
                    icon: e.icon,
                    label: e.label,
                  ))
              .toList(),
        ),
      ),
    );
  }
}