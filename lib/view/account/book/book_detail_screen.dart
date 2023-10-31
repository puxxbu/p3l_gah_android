import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:p3l_gah_android/model/booking.dart';
import 'package:p3l_gah_android/util/string_extention.dart';

import '../../../controller/controllers.dart';

class DetailBookingScreen extends StatefulWidget {
  const DetailBookingScreen({super.key});

  @override
  State<DetailBookingScreen> createState() => _DetailBookingScreenState();
}

class _DetailBookingScreenState extends State<DetailBookingScreen> {
  @override
  void initState() {
    super.initState();

    String idBooking = Get.arguments;
    bookingController.getDetailBooking(idBooking);
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Column(children: [
        Expanded(
            child: ListView(physics: const BouncingScrollPhysics(), children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID Booking : ${bookingController.detailBooking.value?.idBooking}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Tanggal Pembayaran : ${bookingController.detailBooking.value?.tanggalPembayaran.toString().formatDate()}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Nama Pemesan : ${bookingController.detailBooking.value?.customer.nama}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Alamat : ${bookingController.detailBooking.value?.customer.alamat}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Tanggal Check-in : ${bookingController.detailBooking.value?.tanggalCheckIn.toString().formatDate()}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Tanggal Check-out : ${bookingController.detailBooking.value?.tanggalCheckOut.toString().formatDate()}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Kamar :",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  if (bookingController
                          .detailBooking.value?.detailBookingKamar.length !=
                      0)
                    Container(
                      height: 300,
                      width: 380,
                      child: ListView.builder(
                          itemCount: bookingController
                              .detailBooking.value?.detailBookingKamar.length,
                          itemBuilder: (context, index) {
                            var hargaPerMalam = bookingController.detailBooking
                                    .value!.detailBookingKamar[index].subTotal /
                                bookingController.detailBooking.value!
                                    .detailBookingKamar[index].jumlah;
                            return Container(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${bookingController.detailBooking.value?.detailBookingKamar[index].jenisKamar.jenisKamar} (${bookingController.detailBooking.value?.detailBookingKamar[index].jenisKamar.jenisBed})",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Jumlah : ${bookingController.detailBooking.value?.detailBookingKamar[index].jumlah} @ Rp. $hargaPerMalam ",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Subtotal : ${bookingController.detailBooking.value?.detailBookingKamar[index].subTotal}  ",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  const Text(
                    "Layanan :",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  if (bookingController
                          .detailBooking.value?.detailBookingLayanan.length !=
                      0)
                    Container(
                      height: 300,
                      width: 380,
                      child: ListView.builder(
                          itemCount: bookingController
                              .detailBooking.value?.detailBookingLayanan.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${bookingController.detailBooking.value?.detailBookingLayanan[index].fasilitas.namaLayanan} (${bookingController.detailBooking.value?.detailBookingLayanan[index].tanggal.toString().formatDate()})",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Jumlah : ${bookingController.detailBooking.value?.detailBookingLayanan[index].jumlah} @ Rp. ${bookingController.detailBooking.value?.detailBookingLayanan[index].fasilitas.harga} ",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Sub Total : ${bookingController.detailBooking.value?.detailBookingLayanan[index].subTotal}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  if (bookingController.detailBooking.value?.invoice.length !=
                      0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total : Rp. ${bookingController.detailBooking.value?.invoice[0].totalPembayaran}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Pajak : Rp. ${bookingController.detailBooking.value?.invoice[0].totalPajak}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                ],
              )
            ],
          ),
          const SizedBox(height: 50),
        ])),
      ]),
    ));
  }
}

Widget buildAccountCard(
    {required BookingHistory dataBooking, required Function() onClick}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        height: 150,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "ID Booking : ${dataBooking.idBooking}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Tanggal Check-in dan Check-out :",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  "${dataBooking.tanggalCheckIn.toString().formatDate()} - ${dataBooking.tanggalCheckOut.toString().formatDate()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  "Status : ${dataBooking.statusBooking}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_right_outlined)
          ],
        ),
      ),
    ),
  );
}
