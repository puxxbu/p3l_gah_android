import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/model/customer.dart';
import 'package:p3l_gah_android/util/string_extention.dart';
import 'package:p3l_gah_android/view/account/auth/edit_password_screen.dart';

import '../../../component/input_outline_button.dart';
import '../../../component/input_text_button.dart';
import '../../../component/input_text_field.dart';
import '../../../model/registerData.dart';
import 'sign_in_screen.dart';

class CustomerEditScreen extends StatefulWidget {
  const CustomerEditScreen({Key? key}) : super(key: key);

  @override
  State<CustomerEditScreen> createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends State<CustomerEditScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController();
  TextEditingController nomorIdentitasController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    nomorIdentitasController.dispose();
    nomorTeleponController.dispose();
    alamatController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    namaController.text = authController.customer.value?.nama ?? "";
    nomorIdentitasController.text =
        authController.customer.value?.nomorIdentitas ?? "";
    nomorTeleponController.text =
        authController.customer.value?.nomorTelepon ?? "";
    alamatController.text = authController.customer.value?.alamat ?? "";
    emailController.text = authController.customer.value?.email ?? "";
    authController.getProfile();
    super.initState();
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
                  const Text("Data Customer",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  const Spacer(
                    flex: 3,
                  ),
                  const SizedBox(height: 10),
                  InputTextField(
                    title: 'Nama',
                    textEditingController: namaController,
                    validation: (String? value) {
                      if (value == null || value.isEmpty || value == " ") {
                        return "Nama tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextField(
                    title: 'Nomor Identitas',
                    textEditingController: nomorIdentitasController,
                    validation: (String? value) {
                      if (value == null || value.isEmpty || value == " ") {
                        return "Nomor Identitas tidak boleh kosong";
                      } else if (value.isNumeric == false) {
                        return "Nomor identitas harus angka";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextField(
                    title: 'Nomor Telepon',
                    textEditingController: nomorTeleponController,
                    validation: (String? value) {
                      if (value == null || value.isEmpty || value == " ") {
                        return "Nomor Telepon tidak boleh kosong";
                      } else if (value.isNumeric == false) {
                        return "Nomor Telepon harus angka";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  InputTextField(
                    title: 'Alamat',
                    textEditingController: alamatController,
                    validation: (String? value) {
                      if (value == null || value.isEmpty || value == " ") {
                        return "Alamat tidak boleh kosong";
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
                  const Spacer(),
                  // InputTextButton(
                  //   title: "Sign Up",
                  //   onClick: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       // final userData = UserData(
                  //       //   username: widget.userData.username,
                  //       //   email: widget.userData.email,
                  //       //   password: widget.userData.password,
                  //       //   confirm: widget.userData.confirm,
                  //       //   nama: namaController.text,
                  //       //   nomorIdentitas: nomorIdentitasController.text,
                  //       //   nomorTelepon: nomorTeleponController.text,
                  //       //   alamat: alamatController.text,
                  //       // );
                  //       // authController.signUp(userData: userData);
                  //     } else {
                  //       EasyLoading.showError("Lengkapi data terlebih dahulu");
                  //     }
                  //   },
                  // ),
                  InputTextButton(
                    title: "Ubah Data",
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        final userData = CustomerEdit(
                          nama: namaController.text,
                          jenisCustomer: "Personal",
                          alamat: alamatController.text,
                          nomorIdentitas: nomorIdentitasController.text,
                          nomorTelepon: nomorTeleponController.text,
                          email: emailController.text,
                        );

                        authController.editCustomer(data: userData);
                      } else {
                        EasyLoading.showError("Inputan Data harus benar");
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  InputTextButton(
                    title: "Ubah Password",
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditPasswordScreen()),
                      );
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
                ],
              ),
            )),
      ),
    );
  }
}
