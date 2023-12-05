import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomModal extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Nomor Rekening',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Aksi yang dijalankan saat tombol ditekan
                String inputText = textController.text;
                if (inputText.isNotEmpty &&
                    RegExp(r'^[0-9]+$').hasMatch(inputText) &&
                    inputText.length == 8) {
                  // Jika input tidak kosong
                  Fluttertoast.showToast(msg: "Pembayaran Berhasil");
                } else {
                  Fluttertoast.showToast(msg: "Input harus 8 digit angka");
                }
                Navigator.pop(context);
              },
              child: Text('Bayar'),
            ),
          ],
        ),
      ),
    );
  }
}
