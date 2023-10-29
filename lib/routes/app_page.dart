import 'package:p3l_gah_android/routes/app_route.dart';
// import 'package:commerce_app/view/dashboard/dashboard_binding.dart';
// import 'package:commerce_app/view/dashboard/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/view/account/account_screen.dart';
import 'package:p3l_gah_android/view/dashboard/dashboard_binding.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.account,
        page: () => const AccountScreen(),
        binding: DashboardBinding()),
  ];
}
