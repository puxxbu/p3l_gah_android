import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:core';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/model/booking_kamar.dart';
import 'package:p3l_gah_android/util/string_extention.dart';
import 'package:p3l_gah_android/view/booking/booking_fasilitas_screen.dart';
import 'package:p3l_gah_android/view/booking/component/list_item_kamar.dart';
import 'package:p3l_gah_android/view/booking/detail_pemesanan_screen.dart';
import 'package:p3l_gah_android/view/home/home_screen.dart';

import '../../component/input_text_field.dart';
import '../../theme/hotel_app_theme.dart';
import '../dashboard/dashboard_screen.dart';
import 'add_kamar_screen.dart';
import 'component/konfirmasi_booking_dialog.dart';

class OrderKamarScreen extends StatefulWidget {
  @override
  State<OrderKamarScreen> createState() => _OrderKamarScreenState();
}

class _OrderKamarScreenState extends State<OrderKamarScreen> {
  int selectedRoomCount = 0;

  int maksimalCount = 5;

  final _formKey = GlobalKey<FormState>();

  bool validate() {
    return _formKey.currentState?.validate() ?? false;
  }

  TextEditingController noRekeningController = TextEditingController();

  void incrementAnakCount() {
    setState(() {
      if (bookingController.jumlahAnakCount.value! < maksimalCount) {
        bookingController.jumlahAnakCount.value =
            bookingController.jumlahAnakCount.value! + 1;
      }
    });
  }

  void decrementAnakCount() {
    if (bookingController.jumlahAnakCount.value! > 0) {
      setState(() {
        bookingController.jumlahAnakCount.value =
            bookingController.jumlahAnakCount.value! - 1;
      });
    }
  }

  void incrementDewasaCount() {
    setState(() {
      if (bookingController.jumlahDewasaCount.value! < maksimalCount) {
        bookingController.jumlahDewasaCount.value =
            bookingController.jumlahDewasaCount.value! + 1;
      }
    });
  }

  void decrementDewasaCount() {
    if (bookingController.jumlahDewasaCount.value! > 0) {
      setState(() {
        bookingController.jumlahDewasaCount.value =
            bookingController.jumlahDewasaCount.value! - 1;
      });
    }
  }

  void incrementRoomCount() {
    setState(() {
      selectedRoomCount++;
    });
  }

  void decrementRoomCount() {
    if (selectedRoomCount > 0) {
      setState(() {
        selectedRoomCount--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(bookingController.selectedKamar.length);
    print(bookingController.bookCheckIn.value);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Konfirmasi",
                  style: TextStyle(color: Colors.black)),
              content: const Text(
                  "Apakah Anda yakin ingin kembali? (Semua input pada pemesanan kamar akan hilang)",
                  style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                  child: const Text("Tidak",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                ),
                TextButton(
                  child: const Text("Ya", style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    bookingController.selectedKamarCount.clear();
                    bookingController.selectedKamar.clear();
                    bookingController.selectedList.clear();
                    bookingController.jumlahDewasaCount.value = 0;
                    bookingController.jumlahAnakCount.value = 0;
                    bookingController.bookCheckIn.value = DateTime.now();
                    bookingController.bookCheckOut.value = DateTime.now();
                    bookingController.createBookingData.value = null;

                    Navigator.of(context).pop(); // Tutup dialog
                    Get.offAllNamed('/');
                  },
                ),
              ],
            );
          },
        );

        return false;
      },
      child: Scaffold(
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
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: Icon(
                      //     CupertinoIcons.back,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Pemesanan Kamar\n",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Obx(() => Container(
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
                                  "Tanggal Pemesanan",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color:
                                            const Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "Tanggal Check-in: ${bookingController.bookCheckIn.value.toString().formatDate()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color:
                                            const Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "Tanggal Check-out: ${bookingController.bookCheckOut.value.toString().formatDate()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color:
                                            const Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "Jumlah malam: ${bookingController.bookCheckOut.value != null && bookingController.bookCheckIn.value != null ? bookingController.bookCheckOut.value!.difference(bookingController.bookCheckIn.value!).inDays : 'N/A'} malam",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color:
                                            const Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          )),
                      Obx(() => ListView.builder(
                            physics:
                                const NeverScrollableScrollPhysics(), // Mencegah scrolling
                            shrinkWrap:
                                true, // Mengatur ukuran ListView sesuai dengan jumlah item yang ada
                            itemCount: bookingController.selectedKamar.length,
                            itemBuilder: (context, index) {
                              final item =
                                  bookingController.selectedKamar[index];
                              if (bookingController.selectedKamar.length > 0) {
                                int? harga = 0;
                                if (item.tarif?.length == 0) {
                                  harga = item.baseHarga;
                                } else {
                                  harga = item.tarif?[0].harga;
                                }

                                return CustomListKamar(
                                  idJenisKamar: item.idJenisKamar ?? 0,
                                  harga: harga ?? 0,
                                  jenisBed: item.jenisBed ?? "",
                                  jenisKamar: item.jenisKamar ?? "",
                                  kapasitas: item.kapasitas ?? 0,
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          )),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddKamarScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor:
                              const Color.fromRGBO(245, 247, 249, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ), // Warna latar belakang tombol
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddKamarScreen()),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: Color.fromRGBO(74, 77, 84, 1),
                              ), // Ikonya di sini, ganti dengan ikon yang Anda inginkan
                              SizedBox(
                                  width: 8.0), // Jarak antara ikon dan teks
                              Text(
                                'Tambah Kamar',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromRGBO(74, 77, 84, 1)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      // Form(
                      //   key: _formKey,
                      //   child: Container(
                      //     color: Colors.white,
                      //     padding: const EdgeInsets.only(top: 4),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 4),
                      //           child: Text(
                      //             "Nomor Rekening",
                      //             textAlign: TextAlign.left,
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .headline6
                      //                 ?.copyWith(
                      //                   color:
                      //                       const Color.fromRGBO(74, 77, 84, 1),
                      //                   fontSize: 16.0,
                      //                   fontWeight: FontWeight.w800,
                      //                 ),
                      //           ),
                      //         ),
                      //         InputTextField(
                      //           title: '',
                      //           textEditingController: noRekeningController,
                      //           validation: (String? value) {
                      //             if (value == null ||
                      //                 value.isEmpty ||
                      //                 value == " ") {
                      //               return "Nomor Rekening tidak boleh kosong";
                      //             } else if (value.isNumeric == false) {
                      //               return "Nomor Rekening harus angka";
                      //             } else if (value.length != 8) {
                      //               return "Nomor Rekening harus terdiri dari 8 digit";
                      //             }
                      //             return null;
                      //           },
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20.0,
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
                            Row(
                              children: [
                                Text(
                                  "Jumlah Tamu Menginap",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color:
                                            const Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                const Spacer(),
                                const Icon(Icons.group,
                                    color: Color.fromRGBO(143, 148, 162, 1)),
                              ],
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Obx(() => RoomSelectionWidget(
                                  namaTamu: "Tamu Anak",
                                  onDecrement: () {
                                    decrementAnakCount();
                                  },
                                  onIncrement: () {
                                    incrementAnakCount();
                                  },
                                  selectedRoomCount:
                                      bookingController.jumlahAnakCount.value ??
                                          0,
                                )),
                            Obx(
                              () => RoomSelectionWidget(
                                namaTamu: "Tamu Dewasa",
                                onDecrement: () {
                                  decrementDewasaCount();
                                },
                                onIncrement: () {
                                  incrementDewasaCount();
                                },
                                selectedRoomCount:
                                    bookingController.jumlahDewasaCount.value ??
                                        0,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingFasilitasScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor:
                              const Color.fromRGBO(245, 247, 249, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ), // Warna latar belakang tombol
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Color.fromRGBO(74, 77, 84, 1),
                            ), // Ikonya di sini, ganti dengan ikon yang Anda inginkan
                            SizedBox(width: 8.0), // Jarak antara ikon dan teks
                            Text(
                              'Tambah Catatan Khusus',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromRGBO(74, 77, 84, 1)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
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
                                            (bookingController
                                                            .selectedKamarCount[
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
                            const SizedBox(
                              height: 30.0,
                            ),
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

                              for (var item
                                  in bookingController.selectedKamar) {
                                if (item.tarif != null &&
                                    item.tarif!.isNotEmpty) {
                                  subtotal += item.tarif![0].harga! *
                                      (bookingController.selectedKamarCount[
                                              item.idJenisKamar] ??
                                          0);
                                } else {
                                  subtotal += item.baseHarga! *
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
                                      bookingController.bookCheckIn.value !=
                                          null
                                  ? bookingController.bookCheckOut.value!
                                      .difference(
                                          bookingController.bookCheckIn.value!)
                                      .inDays
                                  : 0;
                              for (var item
                                  in bookingController.selectedKamar) {
                                if (item.tarif != null &&
                                    item.tarif!.isNotEmpty) {
                                  subtotal += item.tarif![0].harga! *
                                      (bookingController.selectedKamarCount[
                                              item.idJenisKamar] ??
                                          0);
                                } else {
                                  subtotal += item.baseHarga! *
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
                      const SizedBox(height: 20.0),

                      ElevatedButton(
                        onPressed: () {
                          bool isAnyValueZeroOrNull = bookingController
                              .selectedKamarCount.values
                              .any((value) => value == 0);
                          bookingController.selectedKamarCount
                              .forEach((key, value) {
                            print('Key: $key, Value: $value');
                          });
                          bool isFormValid =
                              _formKey.currentState?.validate() ?? false;
                          if ((bookingController.jumlahAnakCount.value == 0 &&
                                  bookingController.jumlahDewasaCount.value ==
                                      0) ||
                              bookingController.selectedKamar.isEmpty ||
                              bookingController.selectedKamarCount.isEmpty ||
                              isAnyValueZeroOrNull) {
                            Fluttertoast.showToast(
                                msg: "Masih ada kesalahan/kekosongan input");
                          } else {
                            CreateBookingData data = CreateBookingData(
                              idCustomer:
                                  authController.customer.value?.idCustomer,
                              tanggalBooking:
                                  DateTime.now().toString().formatDate2(),
                              tanggalCheckIn: bookingController
                                  .bookCheckIn.value
                                  .toString()
                                  .formatDate2(),
                              tanggalCheckOut: bookingController
                                  .bookCheckOut.value
                                  .toString()
                                  .formatDate2(),
                              tamuDewasa:
                                  bookingController.jumlahDewasaCount.value,
                              tamuAnak: bookingController.jumlahAnakCount.value,
                              tanggalPembayaran: DateTime.now().toString(),
                              jenisBooking: "Personal",
                              statusBooking: "Belum Dibayar",
                              catatanTambahan:
                                  bookingController.selectedList.join(", "),
                              detailBookingKamar:
                                  bookingController.selectedKamar.map((e) {
                                int? harga = 0;
                                if (e.tarif!.isEmpty) {
                                  harga = e.baseHarga;
                                } else {
                                  harga = e.tarif?[0].harga;
                                }
                                return DetailBookingKamar(
                                  idJenisKamar: e.idJenisKamar,
                                  jumlah: bookingController
                                      .selectedKamarCount[e.idJenisKamar],
                                  subTotal: harga! *
                                      (bookingController.selectedKamarCount[
                                              e.idJenisKamar] ??
                                          0),
                                );
                              }).toList(),
                            );

                            bookingController.createBookingData.value = data;

                            print(data.toJson());

                            // bookingController.createBookKamar(data: data);

                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return InvoiceDialog(
                            //       invoiceNumber: 'INV-001',
                            //       productName: 'Product A',
                            //       price: 9.99,
                            //       quantity: 5,
                            //     );
                            //   },
                            // );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPemesananScreen()),
                            );
                          }

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => BookingFasilitasScreen()),
                          // );
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
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

class RoomSelectionWidget extends StatelessWidget {
  final Function() onDecrement;
  final Function() onIncrement;
  final int selectedRoomCount;
  final String namaTamu;

  RoomSelectionWidget({
    required this.onDecrement,
    required this.onIncrement,
    required this.selectedRoomCount,
    required this.namaTamu,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            namaTamu,
            style: const TextStyle(
              color: Color.fromRGBO(74, 77, 84, 1),
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onDecrement,
              ),
              Container(
                width: 15.0,
                height: 20.0,
                child: Center(
                  child: Text(
                    selectedRoomCount.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onIncrement,
              ),
            ],
          )
        ],
      ),
    );
  }
}
