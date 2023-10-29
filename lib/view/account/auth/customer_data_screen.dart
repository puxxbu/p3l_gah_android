import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/util/string_extention.dart';

import '../../../component/input_outline_button.dart';
import '../../../component/input_text_button.dart';
import '../../../component/input_text_field.dart';
import '../../../model/registerData.dart';
import 'sign_in_screen.dart';

class CustomerDataScreen extends StatefulWidget {
  final UserData userData;

  const CustomerDataScreen({required this.userData, Key? key})
      : super(key: key);

  @override
  State<CustomerDataScreen> createState() => _CustomerDataScreenState();
}

class _CustomerDataScreenState extends State<CustomerDataScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController();
  TextEditingController nomorIdentitasController = TextEditingController();
  TextEditingController nomorTeleponController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    nomorIdentitasController.dispose();
    nomorTeleponController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userData.email);
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
                  const Text("Isi Data Customer,",
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
                  const Spacer(),
                  InputTextButton(
                    title: "Sign Up",
                    onClick: () {
                      if (_formKey.currentState!.validate()) {
                        final userData = UserData(
                          username: widget.userData.username,
                          email: widget.userData.email,
                          password: widget.userData.password,
                          confirm: widget.userData.confirm,
                          nama: namaController.text,
                          nomorIdentitas: nomorIdentitasController.text,
                          nomorTelepon: nomorTeleponController.text,
                          alamat: alamatController.text,
                        );
                        authController.signUp(userData: userData);
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
