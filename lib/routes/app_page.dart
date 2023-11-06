import 'package:p3l_gah_android/routes/app_route.dart';
// import 'package:commerce_app/view/dashboard/dashboard_binding.dart';
// import 'package:commerce_app/view/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/view/account/account_screen.dart';
import 'package:p3l_gah_android/view/account/auth/customer_edit_screen.dart';
import 'package:p3l_gah_android/view/account/auth/edit_password_screen.dart';
import 'package:p3l_gah_android/view/account/auth/sign_in_screen.dart';
import 'package:p3l_gah_android/view/account/book/book_history_screen.dart';
import 'package:p3l_gah_android/view/dashboard/dashboard_binding.dart';
import 'package:p3l_gah_android/view/dashboard/dashboard_screen.dart';
import 'package:p3l_gah_android/view/home/home_screen.dart';
import 'package:p3l_gah_android/view/splash_screen/splash_screen.dart';

import '../view/account/book/book_detail_screen.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashboardScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: AppRoute.home,
        page: () => HotelHomeScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: AppRoute.account,
        page: () => const AccountScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: AppRoute.login,
        page: () => const SignInScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: AppRoute.historyBooking,
        page: () => const BookingHistoryScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: AppRoute.bookingDetail,
        page: () => const DetailBookingScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: AppRoute.profileEdit,
        page: () => const CustomerEditScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: AppRoute.profileEditPassword,
        page: () => const EditPasswordScreen(),
        binding: DashboardBinding()),
    GetPage(
        name: AppRoute.splashScreen,
        page: () => SplashScreen(),
        binding: DashboardBinding()),
  ];
}
