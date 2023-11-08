import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/util/string_extention.dart';
import 'package:p3l_gah_android/view/booking/booking_fasilitas_screen.dart';
import 'package:p3l_gah_android/view/booking/component/list_item_kamar.dart';
import 'package:p3l_gah_android/view/home/home_screen.dart';

import '../../theme/hotel_app_theme.dart';
import 'add_kamar_screen.dart';

class OrderKamarScreen extends StatefulWidget {
  @override
  State<OrderKamarScreen> createState() => _OrderKamarScreenState();
}

class _OrderKamarScreenState extends State<OrderKamarScreen> {
  int selectedRoomCount = 0;
  int jumlahAnakCount = 0;
  int jumlahDewasaCount = 0;
  int maksimalCount = 5;

  void incrementAnakCount() {
    setState(() {
      if (jumlahAnakCount < maksimalCount) {
        jumlahAnakCount++;
      }
    });
  }

  void decrementAnakCount() {
    if (jumlahAnakCount > 0) {
      setState(() {
        jumlahAnakCount--;
      });
    }
  }

  void incrementDewasaCount() {
    setState(() {
      if (jumlahDewasaCount < maksimalCount) {
        jumlahDewasaCount++;
      }
    });
  }

  void decrementDewasaCount() {
    if (jumlahDewasaCount > 0) {
      setState(() {
        jumlahDewasaCount--;
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
              title: Text("Konfirmasi", style: TextStyle(color: Colors.black)),
              content: Text(
                  "Apakah Anda yakin ingin kembali? (Semua input pada pemesanan kamar akan hilang)",
                  style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                  child: Text("Tidak", style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop(); // Tutup dialog
                  },
                ),
                TextButton(
                  child: Text("Ya", style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    bookingController.selectedKamarCount.clear();
                    bookingController.selectedKamar.clear();
                    bookingController.selectedList.clear();
                    bookingController.bookCheckIn.value = DateTime.now();
                    bookingController.bookCheckOut.value = DateTime.now();

                    Navigator.of(context).pop(); // Tutup dialog
                    Navigator.of(context)
                        .pop(); // Kembali ke halaman sebelumnya
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
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: Icon(
                      //     CupertinoIcons.back,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      SizedBox(
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Obx(() => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color.fromRGBO(245, 247, 249, 1),
                            ),
                            padding: EdgeInsets.symmetric(
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
                                        color: Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "Tanggal Check-in: ${bookingController.bookCheckIn.value.toString().formatDate()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color: Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "Tanggal Check-out: ${bookingController.bookCheckOut.value.toString().formatDate()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color: Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "Jumlah malam: ${bookingController.bookCheckOut.value != null && bookingController.bookCheckIn.value != null ? bookingController.bookCheckOut.value!.difference(bookingController.bookCheckIn.value!).inDays : 'N/A'} malam",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color: Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          )),
                      Obx(() => ListView.builder(
                            physics:
                                NeverScrollableScrollPhysics(), // Mencegah scrolling
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
                                return SizedBox();
                              }
                            },
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Aksi yang ingin Anda lakukan ketika tombol ditekan
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                          backgroundColor: Color.fromRGBO(245, 247, 249, 1),
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
                          child: Row(
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        padding: EdgeInsets.symmetric(
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
                                        color: Color.fromRGBO(74, 77, 84, 1),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                Spacer(),
                                Icon(Icons.group,
                                    color: Color.fromRGBO(143, 148, 162, 1)),
                              ],
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            RoomSelectionWidget(
                              namaTamu: "Tamu Anak",
                              onDecrement: () {
                                decrementAnakCount();
                              },
                              onIncrement: () {
                                incrementAnakCount();
                              },
                              selectedRoomCount: jumlahAnakCount,
                            ),
                            RoomSelectionWidget(
                              namaTamu: "Tamu Dewasa",
                              onDecrement: () {
                                decrementDewasaCount();
                              },
                              onIncrement: () {
                                incrementDewasaCount();
                              },
                              selectedRoomCount: jumlahDewasaCount,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
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
                          padding: EdgeInsets.all(16.0),
                          backgroundColor: Color.fromRGBO(245, 247, 249, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ), // Warna latar belakang tombol
                        ),
                        child: Row(
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        padding: EdgeInsets.symmetric(
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
                                    color: Color.fromRGBO(74, 77, 84, 1),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              "Check-in : ${bookingController.bookCheckIn.value.toString().formatDate()}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(74, 77, 84, 1),
                              ),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              "Check-out : ${bookingController.bookCheckOut.value.toString().formatDate()}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(74, 77, 84, 1),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Obx(() => ListView.builder(
                                  physics:
                                      NeverScrollableScrollPhysics(), // Mencegah scrolling
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
                                      return SizedBox();
                                    }
                                  },
                                )),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text(
                              "Catatan tambahan:",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(143, 148, 162, 1),
                              ),
                            ),
                            Obx(() {
                              if (bookingController.selectedList.isEmpty) {
                                return SizedBox();
                              } else {
                                return Text(
                                  "${bookingController.selectedList.join(", ")}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(74, 77, 84, 1),
                                  ),
                                );
                              }
                            }),
                            SizedBox(
                              height: 10.0,
                            ),
                            Divider(),
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
                                }
                              }

                              return getSubtotalRow(
                                  "Subtotal per malam", "Rp $subtotal");
                            }),
                            SizedBox(
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
                                }
                              }

                              double total = subtotal * totalMalam;
                              return getTotalRow("Total", "Rp $total");
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(16.0),
                        height: ScreenUtil().setHeight(127.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Your clothes are now washing.",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Color.fromRGBO(74, 77, 84, 1),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Estimated Delivery\n",
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(143, 148, 162, 1),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "24 January 2021",
                                        style: TextStyle(
                                          color: Color.fromRGBO(74, 77, 84, 1),
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  "assets/washlogo.png",
                                ),
                              ],
                            )
                          ],
                        ),
                      )
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
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            namaTamu,
            style: TextStyle(
              color: Color.fromRGBO(74, 77, 84, 1),
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: onDecrement,
              ),
              Container(
                width: 15.0,
                height: 20.0,
                child: Center(
                  child: Text(
                    selectedRoomCount.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: onIncrement,
              ),
            ],
          )
        ],
      ),
    );
  }
}
