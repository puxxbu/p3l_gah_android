import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/view/account/auth/sign_in_screen.dart';
import 'package:p3l_gah_android/view/admin/admin_dashboard_screen.dart';
import 'package:p3l_gah_android/view/dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      print(authController.user.value?.data?.token);

      if (authController.user.value?.data?.token == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      } else {
        if (authController.user.value?.data?.role?.namaRole != 'Customer') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Ganti dengan warna latar belakang yang diinginkan
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Tambahkan gambar atau logo splash screen di sini
            Image.asset(
              'assets/logoGAH1.png', // Ganti dengan path ke gambar atau logo Anda
              width: 150,
              height: 150,
            ),
            SizedBox(height: 24),
            CircularProgressIndicator(
              color: Colors.amber,
            ), // Tambahkan indikator loading jika diperlukan
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Berikutnya'),
      ),
      body: Center(
        child: Text('Selamat datang di halaman berikutnya!'),
      ),
    );
  }
}
