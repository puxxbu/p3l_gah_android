import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:p3l_gah_android/model/booking_kamar.dart';
import 'package:p3l_gah_android/util/string_extention.dart';
import 'package:p3l_gah_android/view/dashboard/dashboard_screen.dart';

import '../../controller/controllers.dart';
import '../../theme/hotel_app_theme.dart';

class TandaTerimaScreen extends StatefulWidget {
  @override
  State<TandaTerimaScreen> createState() => _TandaTerimaScreenState();
}

class _TandaTerimaScreenState extends State<TandaTerimaScreen> {
  @override
  void initState() {
    bookingController.initLatestKamar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HotelAppTheme.buildLightTheme().primaryColor,
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -30,
              top: 30.0,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "assets/hotel-bg.png",
                  width: 200.0, // Mengatur lebar gambar
                  height: 200, // Mengatur tinggi gambar
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: kToolbarHeight,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const DashboardScreen();
                          },
                        ));
                      },
                      child: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Tanda Terima Reservasi",
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
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
                            "Tanda Terima Reservasi",
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
                            "ID Booking : ${bookingController.latestBooking.value?.data?.idBooking}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(74, 77, 84, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Nama : ${bookingController.customer.value?.nama}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(74, 77, 84, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Alamat : ${bookingController.customer.value?.alamat}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(74, 77, 84, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Check-in : ${bookingController.latestBooking.value?.data?.tanggalCheckIn.toString().formatDate()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(74, 77, 84, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Check-out : ${bookingController.latestBooking.value?.data?.tanggalCheckOut.toString().formatDate()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(74, 77, 84, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Tanggal Booking: ${bookingController.latestBooking.value?.data?.tanggalBooking.toString().formatDate()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(74, 77, 84, 1),
                            ),
                          ),

                          const SizedBox(
                            height: 20.0,
                          ),
                          Obx(() => ListView.builder(
                                physics:
                                    const NeverScrollableScrollPhysics(), // Mencegah scrolling
                                shrinkWrap:
                                    true, // Mengatur ukuran ListView sesuai dengan jumlah item yang ada
                                itemCount: bookingController.latestBooking.value
                                    ?.data?.detailBookingKamar?.length,
                                itemBuilder: (context, index) {
                                  final item = bookingController.latestBooking
                                      .value?.data!.detailBookingKamar?[index];
                                  if (bookingController
                                          .latestBooking
                                          .value
                                          ?.data
                                          ?.detailBookingKamar!
                                          .isNotEmpty ??
                                      false) {
                                    return getItemRow(
                                      item!.jumlah.toString(),
                                      "${item.detailKetersediaanKamar?[0].kamar?.jenisKamar?.jenisKamar} (${item.detailKetersediaanKamar?[0].kamar?.jenisKamar?.jenisBed})",
                                      "Rp ${item.subTotal ?? 0}",
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              )),
                          const SizedBox(
                            height: 30.0,
                          ),

                          Obx(() => ListView.builder(
                                physics:
                                    const NeverScrollableScrollPhysics(), // Mencegah scrolling
                                shrinkWrap:
                                    true, // Mengatur ukuran ListView sesuai dengan jumlah item yang ada
                                itemCount: bookingController.latestKamar.length,
                                itemBuilder: (context, index) {
                                  final item =
                                      bookingController.latestKamar[index];
                                  return getKamarRow(
                                    item.jenisKamar?.jenisKamar ?? "",
                                    item.jenisKamar?.jenisBed ?? "",
                                    item.nomorKamar.toString() ?? "",
                                  );
                                },
                              )),
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
                            if (bookingController.latestBooking.value!.data!
                                .detailBookingLayanan!.isNotEmpty) {
                              List<Widget> widgetList = bookingController
                                  .latestBooking
                                  .value!
                                  .data!
                                  .detailBookingLayanan!
                                  .map((element) {
                                return getItemRow(
                                  element.jumlah.toString(),
                                  element.idFasilitas.toString(),
                                  "Rp ${element.subTotal ?? 0}",
                                );
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
                            if (bookingController.latestBooking.value?.data
                                    ?.catatanTambahan ==
                                null) {
                              return const SizedBox();
                            } else {
                              return Text(
                                "${bookingController.latestBooking.value?.data?.catatanTambahan}",
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
                          // const Divider(),
                          // Obx(() {
                          //   double subtotal = 0.0;
                          //
                          //
                          //
                          //   return getSubtotalRow(
                          //       "Subtotal per malam", "Rp $subtotal");
                          // }),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Obx(() {
                            double total = 0.0;
                            for (var item in bookingController.latestBooking
                                    .value?.data!.detailBookingKamar ??
                                []) {
                              total += item.subTotal ?? 0;
                            }

                            return getTotalRow("Total", "Rp ${total}");
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const SizedBox(height: 10.0),
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
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color.fromRGBO(19, 22, 33, 1),
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
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
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Text(
          price,
          style: const TextStyle(
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
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            " x $item",
            style: const TextStyle(
              color: Color.fromRGBO(143, 148, 162, 1),
              fontSize: 15.0,
            ),
          ),
        ),
        Text(
          price,
          style: const TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}

Widget getKamarRow(String jenisKamar, String jenisBed, String noKamar) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Text(
          jenisKamar,
          style: const TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            " ($jenisBed)",
            style: const TextStyle(
              color: Color.fromRGBO(143, 148, 162, 1),
              fontSize: 15.0,
            ),
          ),
        ),
        Text(
          "Kamar $noKamar",
          style: const TextStyle(
            color: Color.fromRGBO(74, 77, 84, 1),
            fontSize: 15.0,
          ),
        )
      ],
    ),
  );
}
