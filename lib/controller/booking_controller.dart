import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/model/booking_history.dart';
import 'package:p3l_gah_android/model/booking_kamar.dart' as BookingKamar;
import 'package:p3l_gah_android/model/kamar.dart';
import 'package:p3l_gah_android/model/laporan_dua.dart' as LaporanDua;
import 'package:p3l_gah_android/model/laporan_satu.dart' as LaporanSatu;
import 'package:p3l_gah_android/service/remote_service/remote_booking_service.dart';
import 'package:p3l_gah_android/service/remote_service/remote_laporan_service.dart';
import 'package:p3l_gah_android/view/booking/tanda_terima_screen.dart';

import '../model/booking.dart';
import '../model/customer.dart';
import '../model/fasilitas.dart';

import '../service/local_service/local_auth_service.dart';

class BookingController extends GetxController {
  static BookingController instance = Get.find();
  final BookingService _bookingService = BookingService();
  final LaporanService _laporanService = LaporanService();
  Rxn<Customer> customer = Rxn<Customer>();
  int _page = 1;
  int _size = 20;

  TextEditingController searchTextEditController = TextEditingController();
  RxString searchVal = ''.obs;
  RxList<Data> kamarList = List<Data>.empty(growable: true).obs;
  RxList<Data> selectedKamar = List<Data>.empty(growable: true).obs;
  RxBool isKamarLoading = false.obs;
  RxBool isLoading = false.obs;

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
  Rxn<BookingKamar.CreateBookingData> createBookingData =
      Rxn<BookingKamar.CreateBookingData>();
  RxList<BookingKamar.DetailBookingLayanan> detailLayananList =
      List<BookingKamar.DetailBookingLayanan>.empty(growable: true).obs;

  RxList<FasilitasData> fasilitasList =
      List<FasilitasData>.empty(growable: true).obs;

  Rxn<BookingKamar.BookingCreatedResponse> latestBooking =
      Rxn<BookingKamar.BookingCreatedResponse>();
  RxList<BookingKamar.Kamar> latestKamar = RxList<BookingKamar.Kamar>();
  RxInt jumlahMalam = 0.obs;

  Rxn<LaporanSatu.LaporanSatuResponse> laporanSatu =
      Rxn<LaporanSatu.LaporanSatuResponse>();
  Rxn<LaporanDua.LaporanDuaResponse> laporanDua =
      Rxn<LaporanDua.LaporanDuaResponse>();

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

  void getKamarList(
      {String keyword = '', String startDate = '', String endDate = ''}) async {
    try {
      isKamarLoading(true);
      var token = authController.user.value?.data?.token;
      var result = await _bookingService.getListKamar(
          token.toString(), keyword, startDate, endDate);
      if (result != null) {
        kamarList.assignAll(result.data!);
      }
    } finally {
      isKamarLoading(false);
      print(kamarList.length);
    }
  }

  void initLatestKamar() {
    if (bookingController.latestBooking.value?.data?.detailBookingKamar !=
        null) {
      bookingController.latestKamar.clear();
      bookingController.latestBooking.value?.data?.detailBookingKamar!
          .forEach((element) {
        element.detailKetersediaanKamar!.forEach((detail) {
          print(detail.kamar?.jenisKamar?.jenisKamar);

          bookingController.latestKamar.add(detail.kamar!);
        });
      });
    }
  }

  void initJumlahMalam() {
    final dataBooking = latestBooking.value?.data;
    final checkinDateString = dataBooking?.tanggalCheckIn;
    final checkoutDateString = dataBooking?.tanggalCheckOut;

    if (checkinDateString != null && checkoutDateString != null) {
      // Mengubah format tanggal check-in
      final checkinDate = DateTime.parse(checkinDateString).toLocal();
      final formattedCheckinDateString =
          DateFormat("yyyy-MM-dd").format(checkinDate);

      // Mengubah format tanggal check-out
      final checkoutDate = DateTime.parse(checkoutDateString).toLocal();
      final formattedCheckoutDateString =
          DateFormat("yyyy-MM-dd").format(checkoutDate);

      final difference = checkoutDate.difference(checkinDate);
      jumlahMalam.value = difference.inDays;

      // Gunakan formattedCheckinDateString dan formattedCheckoutDateString sesuai kebutuhan Anda
    } else {
      jumlahMalam.value = 0;
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
      {required BookingKamar.CreateBookingData data,
      List<BookingKamar.DetailBookingLayanan>? detailBookingLayanan}) async {
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
        BookingKamar.BookingCreatedResponse response =
            BookingKamar.BookingCreatedResponse.fromJson(responseBody);
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

  Future getDetailBookingById(String id) async {
    try {
      var token = authController.user.value?.data?.token;
      // print("Refresh" + id.toString());
      BookingKamar.BookingCreatedResponse result = await _bookingService
          .getDetailBooking(id.toString(), token.toString());
      latestBooking.value = result;
      initJumlahMalam();
    } catch (e) {
      print(e.toString() + " Error");
    }
  }

  Future getLaporanSatu(int tahun) async {
    try {
      isLoading(true);
      var token = authController.user.value?.data?.token;
      // print("Refresh" + id.toString());
      LaporanSatu.LaporanSatuResponse result =
          await _laporanService.getLaporanSatu(token.toString(), tahun);
      laporanSatu.value = result;
    } catch (e) {
      print(e.toString() + " Error");
    } finally {
      isLoading(false);
    }
  }

  Future getLaporanDua(int tahun) async {
    try {
      isLoading(true);
      var token = authController.user.value?.data?.token;
      // print("Refresh" + id.toString());
      LaporanDua.LaporanDuaResponse result =
          await _laporanService.getLaporanDua(token.toString(), tahun);
      laporanDua.value = result;
    } catch (e) {
      print(e.toString() + " Error");
    } finally {
      isLoading(false);
    }
  }
}
