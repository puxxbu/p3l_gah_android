import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/view/account/auth/customer_edit_screen.dart';
import 'package:p3l_gah_android/view/account/book/book_history_screen.dart';

import '../../service/local_service/local_auth_service.dart';
import 'auth/edit_password_screen.dart';
import 'auth/sign_in_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          Obx(
            () => Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 36,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/user_image.png"),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    if (authController.customer.value?.nama != null)
                      Text(
                        authController.customer.value?.nama ??
                            "Sign in your account",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    if (authController.user.value?.data?.role?.namaRole != null)
                      Text(
                        authController.customer.value?.nama == null
                            ? "Role : ${authController.user.value?.data?.role?.namaRole}"
                            : "(${authController.user.value?.data?.role?.namaRole})",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
          Obx(() {
            if (authController.user.value?.data?.role?.namaRole == "Customer") {
              return Column(
                children: [
                  buildAccountCard(
                    title: "Profile Info",
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CustomerEditScreen()),
                      );
                    },
                  ),
                  buildAccountCard(
                    title: "Riwayat transaksi",
                    onClick: () {
                      Get.toNamed('/history-booking');
                    },
                  ),
                ],
              );
            } else if (authController.user.value?.data?.role?.namaRole !=
                    "Customer" &&
                authController.user.value?.data?.role?.namaRole != null) {
              return buildAccountCard(
                title: "Admin Info",
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditPasswordScreen()),
                  );
                },
              );
            } else {
              return SizedBox(
                height: 0,
              );
            }
          }),
          Obx(() => buildAccountCard(
              title: authController.user.value == null ? "Sign In" : "Sign Out",
              onClick: () {
                if (authController.user.value != null) {
                  authController.signOut();
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                }
              }))
        ],
      ),
    );
  }

  Widget buildAccountCard(
      {required String title, required Function() onClick}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0.1,
                  blurRadius: 7,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              const Icon(Icons.keyboard_arrow_right_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
