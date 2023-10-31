import 'dart:convert';

import 'package:get/get.dart';
import 'package:p3l_gah_android/model/booking.dart';
import 'package:p3l_gah_android/model/customer.dart';
import 'package:http/http.dart' as http;

class BookingService extends GetConnect {
  var client = http.Client();

  Future<List<BookingHistory>> fetchBookingHistory(
      String page, String id, String size, String token) async {
    final response = await get(
      'http://10.0.2.2:3000/api/customer/$id/booking-history?page=$page&size=$size',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    print(response.statusCode.toString() + " Status Code");
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.body['data'];
      print(responseData);
      return responseData
          .map<BookingHistory>((json) => BookingHistory.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load booking history');
    }
  }

  Future<BookingResponse> getDetailBooking(String id, String token) async {
    final response = await get(
      'http://10.0.2.2:3000/api/customer/booking/$id',
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    print(response.statusCode.toString() + " Status Code $id");

    if (response.statusCode == 200) {
      return BookingResponse.fromJson(response.body);
    } else {
      throw Exception('Failed to load booking history');
    }
  }

  // Future<dynamic> updateCustomer(
  //     int idCustomer, String token, CustomerEdit data) async {
  //   final url = 'http://localhost:3000/api/customer';
  //
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': "Bearer $token",
  //   };
  //
  //   final body = {
  //     'customer': {
  //       'nama': data.nama,
  //       'jenis_customer': data.jenisCustomer,
  //       'nomor_identitas': data.nomorIdentitas,
  //       'nomor_telepon': data.nomorTelepon,
  //       'email': data.email,
  //       'alamat': data.alamat,
  //     },
  //     'id_customer': idCustomer,
  //   };
  //
  //   final response = await put(url, body, headers: headers);
  //   // print(response.toString() + " Status Code");
  //   //
  //   // if (response.statusCode == 200) {
  //   //   // Berhasil melakukan permintaan PUT
  //   //   print('Customer berhasil diperbarui');
  //   //   return Customer.fromJson(response.body);
  //   // } else {
  //   //   throw Exception('Gagal memperbarui customer error response !');
  //   // }
  //
  //   print(response.body.toString());
  //
  //   return response;
  // }

  Future<dynamic> updateCustomer(
      int idCustomer, String token, CustomerEdit data) async {
    final url = 'http://10.0.2.2:3000/api/customer';

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token",
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

  Future<dynamic> updatePassword(
      String token, String newPassword, String oldPassword) async {
    final url = 'http://10.0.2.2:3000/api/users/password';

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
