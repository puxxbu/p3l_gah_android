import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:p3l_gah_android/model/booking_kamar.dart';
import 'package:p3l_gah_android/util/string_extention.dart';

import '../../controller/controllers.dart';
import '../../theme/hotel_app_theme.dart';

class DetailPemesananScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HotelAppTheme.buildLightTheme().primaryColor,
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 0.0,
              top: 10.0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "assets/washing_machine_illustration.png",
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Detail Pemesanan",
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color.fromRGBO(245, 247, 249, 1),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Detail Pemesanan",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                  color: const Color.fromRGBO(74, 77, 84, 1),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Check-in : ${bookingController.bookCheckIn.value.toString().formatDate()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(74, 77, 84, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Check-out : ${bookingController.bookCheckOut.value.toString().formatDate()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(74, 77, 84, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Nomor Rekening: ${bookingController.createBookingData.value?.noRekening}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(74, 77, 84, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Obx(() => ListView.builder(
                                physics:
                                    const NeverScrollableScrollPhysics(), // Mencegah scrolling
                                shrinkWrap:
                                    true, // Mengatur ukuran ListView sesuai dengan jumlah item yang ada
                                itemCount:
                                    bookingController.selectedKamar.length,
                                itemBuilder: (context, index) {
                                  final item =
                                      bookingController.selectedKamar[index];
                                  if (bookingController.selectedKamar.length >
                                      0) {
                                    return Obx(() {
                                      int? harga = 0;
                                      if (item.tarif?.length == 0) {
                                        harga = item.baseHarga;
                                      } else {
                                        harga = item.tarif?[0].harga;
                                      }
                                      return getItemRow(
                                          (bookingController.selectedKamarCount[
                                                      item.idJenisKamar] ??
                                                  0)
                                              .toString(),
                                          "${item.jenisKamar} (${item.jenisBed})",
                                          "Rp ${harga! * (bookingController.selectedKamarCount[item.idJenisKamar] ?? 0)}");
                                    });
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              )),
                          const SizedBox(
                            height: 30.0,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            "Fasilitas:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(143, 148, 162, 1),
                            ),
                          ),
                          Obx(() {
                            if (!bookingController
                                .selectedFasilitasCount.isEmpty) {
                              List<Widget> widgetList = bookingController
                                  .fasilitasList
                                  .map((element) {
                                if (bookingController.selectedFasilitasCount[
                                        element.idFasilitas] !=
                                    null) {
                                  DetailBookingLayanan dataLayanan =
                                      DetailBookingLayanan(
                                          idFasilitas: element.idFasilitas,
                                          jumlah: bookingController
                                                      .selectedFasilitasCount[
                                                  element.idFasilitas] ??
                                              0,
                                          subTotal: element.harga! *
                                              (bookingController
                                                          .selectedFasilitasCount[
                                                      element.idFasilitas] ??
                                                  0));

                                  print("Data Layanan ${dataLayanan.toJson()}");

                                  return getItemRow(
                                    bookingController.selectedFasilitasCount[
                                            element.idFasilitas]
                                        .toString(),
                                    element.namaLayanan.toString(),
                                    "Rp ${element.harga! * (bookingController.selectedFasilitasCount[element.idFasilitas] ?? 0)}",
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }).toList();

                              return widgetList.isNotEmpty
                                  ? Column(
                                      children: widgetList,
                                    )
                                  : const SizedBox();
                            } else {
                              return const SizedBox();
                            }
                          }),
                          const Text(
                            "Catatan tambahan:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(143, 148, 162, 1),
                            ),
                          ),
                          Obx(() {
                            if (bookingController.selectedList.isEmpty) {
                              return const SizedBox();
                            } else {
                              return Text(
                                "${bookingController.selectedList.join(", ")}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(74, 77, 84, 1),
                                ),
                              );
                            }
                          }),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Divider(),
                          Obx(() {
                            double subtotal = 0.0;

                            for (var item in bookingController.selectedKamar) {
                              if (item.tarif != null &&
                                  item.tarif!.isNotEmpty) {
                                subtotal += item.tarif![0].harga! *
                                    (bookingController.selectedKamarCount[
                                            item.idJenisKamar] ??
                                        0);
                              }
                            }

                            return getSubtotalRow(
                                "Subtotal per malam", "Rp $subtotal");
                          }),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Obx(() {
                            double subtotal = 0.0;
                            int totalMalam = bookingController
                                            .bookCheckOut.value !=
                                        null &&
                                    bookingController.bookCheckIn.value != null
                                ? bookingController.bookCheckOut.value!
                                    .difference(
                                        bookingController.bookCheckIn.value!)
                                    .inDays
                                : 0;
                            for (var item in bookingController.selectedKamar) {
                              if (item.tarif != null &&
                                  item.tarif!.isNotEmpty) {
                                subtotal += item.tarif![0].harga! *
                                    (bookingController.selectedKamarCount[
                                            item.idJenisKamar] ??
                                        0);
                              }
                            }

                            double total = subtotal * totalMalam;
                            return getTotalRow("Total", "Rp $total");
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        if (bookingController.createBookingData.value != null) {
                          bookingController.selectedFasilitasCount
                              .forEach((key, value) {
                            DetailBookingLayanan dataLayanan =
                                DetailBookingLayanan(
                                    idFasilitas: key,
                                    jumlah: value,
                                    subTotal: bookingController
                                            .fasilitasList
                                            .firstWhere((element) =>
                                                element.idFasilitas == key)
                                            .harga! *
                                        value);
                            bookingController.detailLayananList
                                .add(dataLayanan);
                          });

                          print(
                              "Data Layanan ${bookingController.detailLayananList.length}");
                          // bookingController.detailLayananList.clear();
                          bookingController.createBookKamar(
                              data: bookingController.createBookingData.value!,
                              detailBookingLayanan:
                                  bookingController.detailLayananList);
                        } else {
                          EasyLoading.showError("Data tidak boleh kosong");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ), // Warna latar belakang tombol
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book,
                            color: Colors.white,
                          ), // Ikonya di sini, ganti dengan ikon yang Anda inginkan
                          SizedBox(width: 8.0), // Jarak antara ikon dan teks
                          Text(
                            'Pesan Kamar',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getTotalRow(String title, String amount) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(19, 22, 33, 1),
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          amount,
          style: TextStyle(
            color: HotelAppTheme.buildLightTheme().primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 17.0,
          ),
        )
      ],
    ),
  );
}

Widget getSubtotalRow(String title, String price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        Text(
          price,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}

Widget getItemRow(String count, String item, String price) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          count,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            " x $item",
            style: TextStyle(
              color: Color.fromRGBO(143, 148, 162, 1),
              fontSize: 15.0,
            ),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}
