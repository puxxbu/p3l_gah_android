import 'dart:convert';

import 'package:get/get.dart';
import 'package:p3l_gah_android/main.dart';

import 'package:http/http.dart' as http;
import 'package:p3l_gah_android/model/laporan_dua.dart';
import 'package:p3l_gah_android/model/laporan_dua.dart';
import 'package:p3l_gah_android/model/laporan_satu.dart';

const API_URL = "10.0.2.2:3000";

class LaporanService extends GetConnect {
  var client = http.Client();

  Future<LaporanSatuResponse> getLaporanSatu(
    String token,
    int tahunParams,
  ) async {
    final baseUrl =
        'http://$API_URL/api/laporan/customer-baru?tahun=$tahunParams';
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final url = Uri.parse(baseUrl);

    final response = await http.get(url, headers: headers);

    alice.onHttpResponse(response);

    print(response.statusCode.toString() + " Status Code");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return LaporanSatuResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load List Kamar');
    }
  }

  Future<LaporanDuaResponse> getLaporanDua(
    String token,
    int tahunParams,
  ) async {
    final baseUrl =
        'http://$API_URL/api/laporan/top-customer?tahun=$tahunParams';
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final url = Uri.parse(baseUrl);

    final response = await http.get(url, headers: headers);

    alice.onHttpResponse(response);

    print(response.statusCode.toString() + " Status Code");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return LaporanDuaResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load List Kamar');
    }
  }
}
