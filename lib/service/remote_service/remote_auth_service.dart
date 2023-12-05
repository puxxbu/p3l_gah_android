import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:p3l_gah_android/model/registerData.dart';

import '../../main.dart';

class RemoteAuthService {
  var client = http.Client();

  Future<dynamic> signUp({
    required UserData userData,
  }) async {
    var body = {
      "akun": {
        "username": userData.username,
        "password": userData.password,
        "id_role": 2001
      },
      "customer": {
        "nama": userData.nama,
        "jenis_customer": "Personal",
        "nomor_identitas": userData.nomorIdentitas,
        "nomor_telepon": userData.nomorTelepon,
        "email": userData.email,
        "alamat": userData.alamat
      }
    };

    var response = await client.post(
      Uri.parse('http://10.0.2.2:3000/api/users'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    alice.onHttpResponse(response);
    return response;
  }

  // Future<dynamic> createProfile({
  //   required String fullName,
  //   required String token,
  // }) async {
  //   var body = {"fullName": fullName};
  //   var response = await client.post(
  //     Uri.parse('http://10.0.2.2:3000/api/profile/me'),
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token"
  //     },
  //     body: jsonEncode(body),
  //   );
  //   return response;
  // }

  Future<dynamic> signIn({
    required String username,
    required String password,
  }) async {
    var body = {"username": username, "password": password};
    var response = await client.post(
      Uri.parse('http://10.0.2.2:3000/api/users/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    alice.onHttpResponse(response);
    return response;
  }

  Future<dynamic> getProfile({
    required String token,
  }) async {
    var response = await client.get(
      Uri.parse('http://10.0.2.2:3000/api/users/current'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    alice.onHttpResponse(response);
    return response;
  }

  Future<dynamic> getCustomerData({
    required String token,
  }) async {
    var response = await client.get(
      Uri.parse('http://10.0.2.2:3000/api/customer/current'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return response;
  }
}
