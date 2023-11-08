import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/controller/booking_controller.dart';
import 'package:p3l_gah_android/controller/controllers.dart';

import '../../theme/hotel_app_theme.dart';

class BookingFasilitasScreen extends StatefulWidget {
  @override
  State<BookingFasilitasScreen> createState() => _BookingFasilitasScreenState();
}

class _BookingFasilitasScreenState extends State<BookingFasilitasScreen> {
  List<String> selectedList = [];

  int selectedRoomCount = 0;
  int jumlahAnakCount = 0;
  int jumlahDewasaCount = 0;

  void incrementAnakCount() {
    setState(() {
      jumlahAnakCount++;
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
      jumlahDewasaCount++;
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

  List<Map<String, String>> dummyData = [
    {
      'jenisKamar': 'Nama Jenis Kamar 1',
      'kapasitas': '4',
      'jumlahKamar': '3',
      'tipeKamar': 'Kamar A',
      'harga': 'Rp 3.000.000 / malam',
    },
    {
      'jenisKamar': 'Nama Jenis Kamar 2',
      'kapasitas': '2',
      'jumlahKamar': '2',
      'tipeKamar': 'Kamar B',
      'harga': 'Rp 2.000.000 / malam',
    },
    {
      'jenisKamar': 'Nama Jenis Kamar 3',
      'kapasitas': '2',
      'jumlahKamar': '2',
      'tipeKamar': 'Kamar B',
      'harga': 'Rp 2.000.000 / malam',
    },
    {
      'jenisKamar': 'Nama Jenis Kamar 4',
      'kapasitas': '2',
      'jumlahKamar': '2',
      'tipeKamar': 'Kamar B',
      'harga': 'Rp 2.000.000 / malam',
    },
    {
      'jenisKamar': 'Nama Jenis Kamar 5',
      'kapasitas': '2',
      'jumlahKamar': '2',
      'tipeKamar': 'Kamar B',
      'harga': 'Rp 2.000.000 / malam',
    },
    // Tambahkan data dummy lainnya di sini
  ];

  @override
  void initState() {
    super.initState();
    bookingController.getFasilitasList();
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
                            text: "Penambahan Fasilitas\n",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 28),
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
                        children: [
                          Text(
                            "Permintaan Khusus",
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Color.fromRGBO(74, 77, 84, 1),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Non-Smoking',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            value: bookingController.selectedList.contains(
                                'Non-Smoking'), // Menampilkan status pilihan yang dipilih
                            onChanged: (value) {
                              // Aksi yang ingin Anda lakukan ketika checkbox diubah
                              setState(() {
                                if (bookingController.selectedList
                                    .contains('Non-Smoking')) {
                                  bookingController.selectedList.remove(
                                      'Non-Smoking'); // Menghapus pilihan yang dipilih
                                } else {
                                  bookingController.selectedList.add(
                                      'Non-Smoking'); // Menambahkan pilihan yang dipilih ke dalam list
                                }
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, // Membuat checkbox berada di sebelah kiri teks
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Kamar Atas',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            value: bookingController.selectedList.contains(
                                'Kamar Atas'), // Menampilkan status pilihan yang dipilih
                            onChanged: (value) {
                              // Aksi yang ingin Anda lakukan ketika checkbox diubah
                              setState(() {
                                if (bookingController.selectedList
                                    .contains('Kamar Atas')) {
                                  bookingController.selectedList.remove(
                                      'Kamar Atas'); // Menghapus pilihan yang dipilih
                                } else {
                                  bookingController.selectedList.add(
                                      'Kamar Atas'); // Menambahkan pilihan yang dipilih ke dalam list
                                }
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, // Membuat checkbox berada di sebelah kiri teks
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    // ListView.builder(
                    //   physics:
                    //       NeverScrollableScrollPhysics(), // Mencegah scrolling
                    //   shrinkWrap:
                    //       true, // Mengatur ukuran ListView sesuai dengan jumlah item yang ada
                    //   itemCount: bookingController.fasilitasList.length,
                    //   itemBuilder: (context, index) {
                    //     final item = bookingController.fasilitasList[index];
                    //     return CustomListItem(
                    //       idFasilitas: item.idFasilitas ?? 0,
                    //       namaLayanan: item.namaLayanan ?? '',
                    //       harga: item.harga ?? 0,
                    //     );
                    //   },
                    // ),
                    SizedBox(
                      height: 20.0,
                    ),
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

class CustomListItem extends StatefulWidget {
  final int idFasilitas;
  final String namaLayanan;
  final int harga;

  const CustomListItem({
    required this.idFasilitas,
    required this.namaLayanan,
    required this.harga,
  });

  @override
  State<CustomListItem> createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  void decrementRoomCount() {
    final currentCount = bookingController.selectedMap[widget.idFasilitas] ?? 0;
    if (currentCount > 0) {
      bookingController.selectedMap[widget.idFasilitas] = currentCount - 1;
    }
  }

  void incrementRoomCount() {
    bookingController.selectedMap[widget.idFasilitas] =
        (bookingController.selectedMap[widget.idFasilitas] ?? 0) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: double.infinity,
        height: 200.0,
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
              widget.namaLayanan,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Color.fromRGBO(74, 77, 84, 1),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            SizedBox(
              height: 6.0,
            ),
            getItemRow(
                (bookingController.selectedMap[widget.idFasilitas] ?? 0)
                    .toString(),
                widget.namaLayanan,
                widget.harga.toString()),
            SizedBox(
              height: 10.0,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      decrementRoomCount();
                    },
                  ),
                  Text(
                    (bookingController.selectedMap[widget.idFasilitas] ?? 0)
                        .toString(), // Jumlah kamar yang ingin dipesan
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      incrementRoomCount();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
          count ?? '0',
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
          "Rp $price",
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
