import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/service/remote_service/remote_booking_service.dart';

import '../model/booking.dart';
import '../model/customer.dart';
import '../service/local_service/local_auth_service.dart';

class BookingController extends GetxController {
  static BookingController instance = Get.find();
  final BookingService _bookingService = BookingService();
  Rxn<Customer> customer = Rxn<Customer>();
  int _page = 1;
  int _size = 20;

  final LocalAuthService _localAuthService = LocalAuthService();

  var hasMore = true.obs;
  var bookingHistory = <BookingHistory>[].obs;

  void onInit() async {
    await _localAuthService.init();
    customer.value = await _localAuthService.getCustomer();
    super.onInit();
  }

  Future getHistoryBooking() async {
    try {
      var id = authController.customer.value?.idCustomer;
      // print("Refresh" + id.toString());
      List<BookingHistory> result = await _bookingService.fetchBookingHistory(
          _page.toString(),
          id.toString(),
          _size.toString(),
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImN1c3RvbWVyIiwiaWF0IjoxNjk4NjQyNTQ4LCJleHAiOjE2OTkxNjA5NDh9.yuhGmNrwj7s9ZOAmhLu-3nOc_Q3DEtrrHvoFdKGSksg");
      print("Refresh $id ${result.length} $_page ${hasMore.value}");
      if (result.length < _size - 1) {
        hasMore.value = false;
      }

      print("Refresh $id ${result.length} $_page ${hasMore.value}");
      bookingHistory.addAll(result);
      _page++;
    } catch (e) {
      print(e.toString() + " Error");
    }
  }

  Future refreshData() async {
    _page = 1;
    hasMore.value = true;
    bookingHistory.value = [];

    await getHistoryBooking();
  }
}
