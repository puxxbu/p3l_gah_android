import 'dart:convert';

import 'package:http/http.dart' as http;

class RemoteAuthService {
  var client = http.Client();

  // Future<dynamic> signUp({
  //   required String email,
  //   required String password,
  // }) async {
  //   var body = {"username": email, "email": email, "password": password};
  //   var response = await client.post(
  //     Uri.parse('http://10.0.2.2:3000/api/users'),
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode(body),
  //   );
  //   return response;
  // }
  //
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
    return response;
  }
}
