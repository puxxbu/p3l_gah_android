import 'dart:convert';

import 'package:get/get.dart';
import 'package:p3l_gah_android/main.dart';
import 'package:p3l_gah_android/model/booking.dart';
import 'package:p3l_gah_android/model/booking_history.dart';
import 'package:p3l_gah_android/model/booking_history.dart';
import 'package:p3l_gah_android/model/customer.dart';
import 'package:http/http.dart' as http;
import 'package:p3l_gah_android/model/fasilitas.dart';

import '../../model/booking_kamar.dart';
import '../../model/kamar.dart';

const API_URL = "10.0.2.2:3000";

class BookingService extends GetConnect {
  var client = http.Client();

  Future<dynamic> fetchBookingHistory(
      String page, String id, String size, String token) async {
    final response = await client.get(
      Uri.parse(
          'http://$API_URL/api/customer/$id/booking-history?page=$page&size=$size'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    alice.onHttpResponse(response);
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body)['data'];
      print(responseData);
      return responseData
          .map<BookingHistory>((json) => BookingHistory.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load booking history');
    }
  }

  Future<BookingHistoryDetailResponse> getDetailBooking(
      String id, String token) async {
    final response = await get(
      'http://$API_URL/api/customer/booking/$id',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    print(response.statusCode.toString() + " Status Code $id");

    if (response.statusCode == 200) {
      return BookingHistoryDetailResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load booking history');
    }
  }

  Future<ListKamarResponse> getListKamar(String token, String searchParams,
      String startDate, String endDate) async {
    final baseUrl = 'http://$API_URL/api/booking/kamar';
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNtIiwiaWF0IjoxNjk4NzU0ODU5LCJleHAiOjE3MDEzNDY4NTl9.46MklXr0lciK4Y7bNaJIBrURDmZHDUrCaYB0oBZfyfs"
    };

    final url = Uri.parse(searchParams.isEmpty
        ? baseUrl +
            (startDate.isEmpty
                ? ""
                : "?tanggal_check_in=$startDate&tanggal_check_out=$endDate")
        : '$baseUrl?kamar_attribute=$searchParams${startDate.isEmpty ? "" : "&tanggal_check_in=$startDate&tanggal_check_out=$endDate"}');

    final response = await http.get(url, headers: headers);

    alice.onHttpResponse(response);

    print(response.statusCode.toString() + " Status Code");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ListKamarResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load List Kamar');
    }
  }

  Future<ListFasilitasResponse> getListFasilitas(String token) async {
    final baseUrl = 'http://$API_URL/api/fasilitas?size=100';
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final url = Uri.parse(baseUrl);

    final response = await http.get(url, headers: headers);

    print(response.statusCode.toString() + " Status Code");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ListFasilitasResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load List Fasilitas');
    }
  }

  Future<dynamic> updateCustomer(
      int idCustomer, String token, CustomerEdit data) async {
    final url = 'http://$API_URL/api/customer';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InNtIiwiaWF0IjoxNjk4NzU0ODU5LCJleHAiOjE3MDEzNDY4NTl9.46MklXr0lciK4Y7bNaJIBrURDmZHDUrCaYB0oBZfyfs",
    };

    final body = {
      'customer': {
        'nama': data.nama,
        'jenis_customer': data.jenisCustomer,
        'nomor_identitas': data.nomorIdentitas,
        'nomor_telepon': data.nomorTelepon,
        'email': data.email,
        'alamat': data.alamat,
      },
      'id_customer': idCustomer,
    };

    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  Future<dynamic> postBookingKamar(CreateBookingData data, String token,
      List<DetailBookingLayanan>? detailBookingLayanan) async {
    final url = 'http://$API_URL/api/booking';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    if (data.catatanTambahan!.isEmpty) data.catatanTambahan = " ";

    final body = {
      'booking': {
        "id_customer": data.idCustomer,
        "tanggal_booking": data.tanggalBooking,
        "tanggal_check_in": data.tanggalCheckIn,
        "tanggal_check_out": data.tanggalCheckOut,
        "tamu_dewasa": data.tamuDewasa,
        "tamu_anak": data.tamuAnak,
        "tanggal_pembayaran": data.tanggalPembayaran,
        "jenis_booking": data.jenisBooking,
        "status_booking": data.statusBooking,
        "catatan_tambahan": data.catatanTambahan,
      },
      'detail_booking': data.detailBookingKamar?.map((detail) {
        return {
          "id_jenis_kamar": detail.idJenisKamar,
          "jumlah": detail.jumlah,
          "sub_total": detail.subTotal,
        };
      }).toList(),
      // 'fasilitas': detailBookingLayanan?.map((detail) {
      //   return {
      //     "id_fasilitas": detail.idFasilitas,
      //     "jumlah": detail.jumlah,
      //     "sub_total": detail.subTotal,
      //   };
      // }).toList(),
    };

    // print("PANJANG ${detailBookingLayanan?.length}");
    if (detailBookingLayanan != null) {
      body['fasilitas'] = detailBookingLayanan.map((detail) {
        return {
          "id_fasilitas": detail.idFasilitas,
          "jumlah": detail.jumlah,
          "sub_total": detail.subTotal,
        };
      }).toList();
    }

    // print("Body ${jsonEncode(body)}");

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    print(response.statusCode.toString() + " Status Code");
    return response;
  }

  Future<dynamic> updatePassword(
      String token, String newPassword, String oldPassword) async {
    final url = 'http://$API_URL/api/users/password';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
    };

    final body = {"oldPassword": oldPassword, "newPassword": newPassword};

    final response = await put(url, body, headers: headers);

    return response;
  }
}
