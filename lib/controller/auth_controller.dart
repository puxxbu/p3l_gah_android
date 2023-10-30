import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/model/registerData.dart';
// import 'package:commerce_app/service/local_service/local_auth_service.dart';
import 'package:p3l_gah_android/service/remote_service/remote_auth_service.dart';
import 'package:p3l_gah_android/view/account/auth/sign_in_screen.dart';

import '../model/customer.dart';
import '../model/user.dart';
import '../service/local_service/local_auth_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rxn<User> user = Rxn<User>();
  Rxn<Customer> customer = Rxn<Customer>();
  final LocalAuthService _localAuthService = LocalAuthService();

  @override
  void onInit() async {
    await _localAuthService.init();
    if (await _localAuthService.getUser() != null) {
      user.value = await _localAuthService.getUser();
    }
    if (await _localAuthService.getCustomer() != null) {
      customer.value = await _localAuthService.getCustomer();
    }
    super.onInit();
  }

  void signUp({required UserData userData}) async {
    try {
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );
      var result = await RemoteAuthService().signUp(
        userData: userData,
      );
      if (result.statusCode == 200) {
        EasyLoading.showSuccess("Registrasi Berhasil");
        Get.offAllNamed('/login');
      } else {
        EasyLoading.showError(result.body);
      }
    } catch (e) {
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      EasyLoading.dismiss();
    }
  }

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
        if (userResult.statusCode == 200) {
          user.value = userFromJson(userResult.body);
          print(userFromJson(userResult.body).data?.role!.namaRole.toString() ??
              'kosong' + "ROLE YANG MASUK");
          if (userFromJson(userResult.body).data?.role?.namaRole ==
              "Customer") {
            print(token.toString() + "TOKEN YANG MASUK CUSTOMER");
            var customerResult =
                await RemoteAuthService().getCustomerData(token: token);

            if (customerResult.statusCode == 200) {
              customer.value = customerFromJson(customerResult.body);
              print(customer.value!.nama.toString() + 'ini nama customer');
              print(customer.value!.idCustomer.toString() + 'ini id customer');
              await _localAuthService.addCustomer(customer: customer.value!);
            }
          }
          await _localAuthService.addToken(token: token);
          print('token aman');
          await _localAuthService.addUser(user: user.value!);
          print('user aman');

          EasyLoading.showSuccess("Anda Berhasil Login!");
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
      debugPrint(e.toString() + 'ini error');
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void signOut() async {
    user.value = null;
    customer.value = null;
    await _localAuthService.clear();
  }
}
