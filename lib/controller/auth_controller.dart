import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
// import 'package:commerce_app/service/local_service/local_auth_service.dart';
import 'package:p3l_gah_android/service/remote_service/remote_auth_service.dart';

import '../model/user.dart';
import '../service/local_service/local_auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rxn<User> user = Rxn<User>();
  final LocalAuthService _localAuthService = LocalAuthService();

  @override
  void onInit() async {
    await _localAuthService.init();
    if (await _localAuthService.getUser() != null) {
      user.value = await _localAuthService.getUser();
    }
    super.onInit();
  }

  // void signUp(
  //     {required String fullName,
  //     required String email,
  //     required String password}) async {
  //   try {
  //     EasyLoading.show(
  //       status: 'Loading...',
  //       dismissOnTap: false,
  //     );
  //     var result = await RemoteAuthService().signUp(
  //       email: email,
  //       password: password,
  //     );
  //     if (result.statusCode == 200) {
  //       String token = json.decode(result.body)['jwt'];
  //       var userResult = await RemoteAuthService()
  //           .createProfile(fullName: fullName, token: token);
  //       if (userResult.statusCode == 200) {
  //         user.value = userFromJson(userResult.body);
  //         await _localAuthService.addToken(token: token);
  //         await _localAuthService.addUser(user: user.value!);
  //         EasyLoading.showSuccess("Welcome to MyGrocery!");
  //         Navigator.of(Get.overlayContext!).pop();
  //       } else {
  //         EasyLoading.showError('Something wrong. Try again!');
  //       }
  //     } else {
  //       EasyLoading.showError('Something wrong. Try again!');
  //     }
  //   } catch (e) {
  //     EasyLoading.showError('Something wrong. Try again!');
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }

  void signIn({required String username, required String password}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().signIn(
        username: username,
        password: password,
      );
      if (result.statusCode == 200) {
        String token = json.decode(result.body)['data']['token'];
        print(token);
        var userResult = await RemoteAuthService().getProfile(token: token);
        print(userResult.statusCode);
        print(userFromJson(userResult.body).data?.role?.namaRole);
        print("user code  aman 200");
        if (userResult.statusCode == 200) {
          print(userFromJson(userResult.body));
          user.value = userFromJson(userResult.body);
          print(userFromJson(userResult.body));
          await _localAuthService.addToken(token: token);
          print('token aman');
          await _localAuthService.addUser(user: user.value!);
          print('user aman');

          EasyLoading.showSuccess("Welcome to MyGrocery!");
          String? namaRole =
              await _localAuthService.getUser()?.data?.role?.namaRole;
          print(namaRole);
          Navigator.of(Get.overlayContext!).pop();
        } else {
          EasyLoading.showError('Something wrong. Try again!');
        }
      } else {
        EasyLoading.showError('Username/password wrong');
      }
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signOut() async {
    user.value = null;
    await _localAuthService.clear();
  }
}
