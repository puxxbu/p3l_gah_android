import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/view/home/home_screen.dart';

import '../../controller/dashboard_controller.dart';
import '../account/account_screen.dart';
import '../booking/detail_booking_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [
              HotelHomeScreen(),
              SingleOrder(),
              AccountScreen(),
              AccountScreen()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          unselectedIconTheme: IconThemeData(
            color: Color.fromRGBO(202, 205, 219, 1),
          ),
          selectedIconTheme: IconThemeData(
            color: Color.fromRGBO(255, 99, 128, 1.0),
          ),
          currentIndex: controller.tabIndex,
          onTap: (val) {
            controller.updateIndex(val);
          },
          items: const [
            BottomNavigationBarItem(
              label: "",
              icon: Icon(CupertinoIcons.home),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(
                CupertinoIcons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(
                CupertinoIcons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(
                CupertinoIcons.home,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
