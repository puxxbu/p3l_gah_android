import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/util/string_extention.dart';
import 'package:p3l_gah_android/view/account/auth/customer_data_screen.dart';

import '../../../component/input_outline_button.dart';
import '../../../component/input_text_button.dart';
import '../../../component/input_text_field.dart';
import '../../../model/registerData.dart';
import 'sign_in_screen.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const Text("Ubah Password",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  const Spacer(
                    flex: 3,
                  ),
                  const SizedBox(height: 10),
                  InputTextField(
                    title: 'Password',
                    obsecureText: true,
                    textEditingController: passwordController,
                    validation: (String? value) {
                      List<String> _validation = [];
                      if (value == null || value.isEmpty) {
                        return "Field ini tidak boleh kosong";
                      }
                      String msg = '';
                      if (_validation.isNotEmpty) {
                        for (var i = 0; i < _validation.length; i++) {
                          msg = msg + _validation[i];
                          if ((i + 1) != _validation.length) {
                            msg = msg + "\n";
                          }
                        }
                      }
                      return msg.isNotEmpty ? msg : null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextField(
                    title: 'New Password',
                    obsecureText: true,
                    textEditingController: confirmController,
                    validation: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Field ini tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Spacer(),
                  InputTextButton(
                    title: "Ubah Password",
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        authController.changePassword(
                            newPassword: passwordController.text,
                            oldPassword: confirmController.text,
                            callback: (bool success, String message) {
                              if (success) {
                                passwordController.clear();
                                confirmController.clear();
                                Navigator.of(context).pop();
                              } else {
                                EasyLoading.showError("Password gagal diubah");
                              }
                            });
                      } else {
                        EasyLoading.showError("Lengkapi data terlebih dahulu");
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  InputOutlineButton(
                    title: "Back",
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            )),
      ),
    );
  }
}
