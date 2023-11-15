import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/model/booking_history.dart';
import 'package:p3l_gah_android/model/booking_kamar.dart';
import 'package:p3l_gah_android/model/kamar.dart';
import 'package:p3l_gah_android/service/remote_service/remote_booking_service.dart';
import 'package:p3l_gah_android/view/booking/tanda_terima_screen.dart';

import '../model/booking.dart';
import '../model/customer.dart';
import '../model/fasilitas.dart';

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
  RxList<Data> selectedKamar = List<Data>.empty(growable: true).obs;
  RxBool isKamarLoading = false.obs;

  final LocalAuthService _localAuthService = LocalAuthService();
  RxList<String> selectedList = List<String>.empty(growable: true).obs;
  RxMap<int, int> selectedMap = Map<int, int>().obs;
  RxMap<int, int> selectedKamarCount = Map<int, int>().obs;

  RxList<Fasilitas> selectedFasilitas =
      List<Fasilitas>.empty(growable: true).obs;
  RxMap<int, int> selectedFasilitasCount = Map<int, int>().obs;

  Rxn<DateTime> startDate = Rxn<DateTime>();
  Rxn<DateTime> endDate = Rxn<DateTime>();
  Rxn<DateTime> bookCheckIn = Rxn<DateTime>(DateTime.now());
  Rxn<DateTime> bookCheckOut = Rxn<DateTime>(DateTime.now());
  Rxn<int> jumlahAnakCount = Rxn<int>(0);
  Rxn<int> jumlahDewasaCount = Rxn<int>(0);
  Rxn<int> noRekening = Rxn<int>(0);
  Rxn<CreateBookingData> createBookingData = Rxn<CreateBookingData>();
  RxList<DetailBookingLayanan> detailLayananList =
      List<DetailBookingLayanan>.empty(growable: true).obs;

  RxList<FasilitasData> fasilitasList =
      List<FasilitasData>.empty(growable: true).obs;

  Rxn<BookingCreatedResponse> latestBooking = Rxn<BookingCreatedResponse>();

  var hasMore = true.obs;
  var bookingHistory = <BookingHistory>[].obs;
  Rxn<DataDetailBooking> detailBooking = Rxn<DataDetailBooking>();

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

  void getKamarList({String keyword = '', String date = ''}) async {
    try {
      isKamarLoading(true);
      var token = authController.user.value?.data?.token;
      var result =
          await _bookingService.getListKamar(token.toString(), keyword, date);
      if (result != null) {
        kamarList.assignAll(result.data!);
      }
    } finally {
      isKamarLoading(false);
      print(kamarList.length);
    }
  }

  void getFasilitasList() async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var token = authController.user.value?.data?.token;
      var result = await _bookingService.getListFasilitas(token.toString());
      fasilitasList.assignAll(result.data!);
    } catch (e) {
      debugPrint(e.toString() + 'ini error');
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void createBookKamar(
      {required CreateBookingData data,
      List<DetailBookingLayanan>? detailBookingLayanan}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var token = authController.user.value?.data?.token;
      var result = await _bookingService.postBookingKamar(
          data, token!, detailBookingLayanan);
      if (result.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(result.body);
        BookingCreatedResponse response =
            BookingCreatedResponse.fromJson(responseBody);
        latestBooking.value = response;
        EasyLoading.showSuccess("Booking Berhasil ${response.data?.idBooking}");

        // Navigator.push(
        //   Get.context!,
        //   MaterialPageRoute(builder: (context) => TandaTerimaScreen()),
        // );

        Navigator.pushReplacement(
          Get.context!,
          MaterialPageRoute(builder: (context) => TandaTerimaScreen()),
        );

        selectedFasilitasCount.clear();
        selectedFasilitas.clear();
        selectedKamarCount.clear();
        selectedKamar.clear();
        selectedList.clear();
        jumlahDewasaCount.value = 0;
        jumlahAnakCount.value = 0;
        bookCheckIn.value = DateTime.now();
        bookCheckOut.value = DateTime.now();
        createBookingData.value = null;
        detailLayananList.clear();
      } else {
        String error = json.decode(result.body)['errors'];
        EasyLoading.showError('Ada kesalahan : $error');
        print('Ada kesalahan : $error');
      }
    } catch (e) {
      debugPrint(e.toString() + 'ini error');
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future getDetailBooking(String id) async {
    try {
      var token = authController.user.value?.data?.token;
      // print("Refresh" + id.toString());
      BookingHistoryDetailResponse result = await _bookingService.getDetailBooking(
          id.toString(), token.toString());
      detailBooking.value = result.data;
    } catch (e) {
      print(e.toString() + " Error");
    }
  }
}
