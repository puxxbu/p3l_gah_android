import 'package:get/get.dart';
import 'package:p3l_gah_android/controller/auth_controller.dart';
import 'package:p3l_gah_android/controller/booking_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(BookingController());
  }
}
