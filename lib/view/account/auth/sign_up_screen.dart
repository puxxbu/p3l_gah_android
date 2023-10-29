import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p3l_gah_android/util/string_extention.dart';
import 'package:p3l_gah_android/view/account/auth/customer_data_screen.dart';

import '../../../component/input_outline_button.dart';
import '../../../component/input_text_button.dart';
import '../../../component/input_text_field.dart';
import '../../../model/registerData.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
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
                  const Text("Registrasi Akun,",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  const Text(
                    "Bergabunglah ke Grand Atma Hotel !",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  InputTextField(
                    title: 'Username',
                    textEditingController: usernameController,
                    validation: (String? value) {
                      if (value == null || value.isEmpty || value == " ") {
                        return "Username tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextField(
                    title: 'Email',
                    textEditingController: emailController,
                    validation: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Field ini tidak boleh kosong";
                      } else if (!value.isValidEmail) {
                        return "Masukkan email yang valid";
                      }
                      return null;
                    },
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
                    title: 'Confirm Password',
                    obsecureText: true,
                    textEditingController: confirmController,
                    validation: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Field ini tidak boleh kosong";
                      } else if (passwordController.text != value) {
                        return "Password tidak cocok";
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(height: 10),
                  // InputTextField(
                  //   title: 'Username',
                  //   textEditingController: usernameController,
                  //   validation: (String? value) {
                  //     if (value == null || value.isEmpty || value == " ") {
                  //       return "Username tidak boleh kosong";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // const SizedBox(height: 10),
                  // InputTextField(
                  //   title: 'Username',
                  //   textEditingController: usernameController,
                  //   validation: (String? value) {
                  //     if (value == null || value.isEmpty || value == " ") {
                  //       return "Username tidak boleh kosong";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // const SizedBox(height: 10),
                  // InputTextField(
                  //   title: 'Username',
                  //   textEditingController: usernameController,
                  //   validation: (String? value) {
                  //     if (value == null || value.isEmpty || value == " ") {
                  //       return "Username tidak boleh kosong";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // const SizedBox(height: 10),
                  // InputTextField(
                  //   title: 'Username',
                  //   textEditingController: usernameController,
                  //   validation: (String? value) {
                  //     if (value == null || value.isEmpty || value == " ") {
                  //       return "Username tidak boleh kosong";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(height: 10),
                  const Spacer(),
                  InputTextButton(
                    title: "Next",
                    onClick: () {
                      final userData = UserData(
                        username: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        confirm: confirmController.text,
                        nama: '',
                        nomorIdentitas: '',
                        nomorTelepon: '',
                        alamat: '',
                      );
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CustomerDataScreen(userData: userData),
                          ),
                        );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Sudah memiliki akun?, "),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            )),
      ),
    );
  }
}
