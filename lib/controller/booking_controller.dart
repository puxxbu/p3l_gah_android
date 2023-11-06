import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/model/kamar.dart';
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

  TextEditingController searchTextEditController = TextEditingController();
  RxString searchVal = ''.obs;
  RxList<Data> kamarList = List<Data>.empty(growable: true).obs;
  RxBool isKamarLoading = false.obs;

  final LocalAuthService _localAuthService = LocalAuthService();

  var hasMore = true.obs;
  var bookingHistory = <BookingHistory>[].obs;
  Rxn<BookingData> detailBooking = Rxn<BookingData>();

  void onInit() async {
    await _localAuthService.init();
    customer.value = await _localAuthService.getCustomer();
    getKamarList();
    super.onInit();
  }

  Future getHistoryBooking() async {
    try {
      var id = authController.customer.value?.idCustomer;
      var token = authController.user.value?.data?.token;
      // print("Refresh" + id.toString());
      List<BookingHistory> result = await _bookingService.fetchBookingHistory(
          _page.toString(), id.toString(), _size.toString(), token.toString());
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

  void getKamarList({String keyword = ''}) async {
    try {
      isKamarLoading(true);
      var token = authController.user.value?.data?.token;
      var result =
          await _bookingService.getListKamar(token.toString(), keyword);
      if (result != null) {
        kamarList.assignAll(result.data!);
      }
    } finally {
      isKamarLoading(false);
      print(kamarList.length);
    }
  }

  Future getDetailBooking(String id) async {
    try {
      var token = authController.user.value?.data?.token;
      // print("Refresh" + id.toString());
      BookingResponse result = await _bookingService.getDetailBooking(
          id.toString(), token.toString());
      detailBooking.value = result.data;
    } catch (e) {
      print(e.toString() + " Error");
    }
  }
}
