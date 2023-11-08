import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:p3l_gah_android/model/kamar.dart';
import 'package:p3l_gah_android/util/string_extention.dart';

import '../../model/property_data.dart';
import '../booking/booking_screen.dart';

class Detail extends StatelessWidget {
  final Data property;

  Detail({required this.property});
  List<Property> properties = getPropertyList();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    int? harga = 0;
    if (property.tarif?.length == 0) {
      harga = property.baseHarga;
    } else {
      harga = property.tarif?[0].harga;
    }

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: property.jenisKamar ?? '',
            child: Container(
              height: size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/hotel/doubledeluxe-double.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: List.from([
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ])),
                ),
              ),
            ),
          ),
          Container(
            height: size.height * 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.yellow[700],
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(5),
                //       ),
                //     ),
                //     width: 80,
                //     padding: EdgeInsets.symmetric(
                //       vertical: 4,
                //     ),
                //     child: Center(
                //       child: Text(
                //         "FOR " + property.label,
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 14,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${property.jenisKamar} (${property.jenisBed.toString().capitalize()})",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 8,
                    bottom: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Rp $harga",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${property.kapasitas} Orang",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "12" + " Reviews",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 24, left: 24, top: 24),
                      child: Text(
                        "Fasilitas",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                        right: 24,
                        left: 16,
                      ),
                      child: Container(
                        height: 80, // Atur tinggi sesuai kebutuhan Anda
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            buildFeature(
                                Icons.hotel, "${property.kapasitas} Bedroom"),
                            buildFeature(Icons.wc, "2 Bathroom"),
                            buildFeature(Icons.kitchen, "Dapur"),
                            buildFeature(Icons.wifi, "Free Wifi"),
                            buildFeature(Icons.pool, "Kolam Renang"),
                            buildFeature(Icons.local_parking, "Parkir"),
                          ],
                        ),
                      ),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     buildFeature(Icons.hotel, "3 Bedroom"),
                      //     buildFeature(Icons.wc, "2 Bathroom"),
                      //     buildFeature(Icons.kitchen, "1 Kitchen"),
                      //     buildFeature(Icons.local_parking, "2 Parking"),
                      //   ],
                      // ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 24,
                        left: 24,
                        bottom: 16,
                      ),
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 24,
                        left: 24,
                        bottom: 24,
                      ),
                      child: Text(
                        "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 24,
                        left: 24,
                        bottom: 16,
                      ),
                      child: Text(
                        "Photos",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: 24,
                        ),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: buildPhotos(properties[0].images ?? []),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (bookingController.selectedKamar
              .any((data) => data.idJenisKamar == property.idJenisKamar)) {
            Fluttertoast.showToast(
                msg: "Jenis kamar ini sudah ada di pesanan anda");
          } else {
            // Property belum ada di selectedKamar, tambahkan property ke selectedKamar
            bookingController.selectedKamar.add(property);
            bookingController.bookCheckIn.value =
                bookingController.startDate.value;
            bookingController.bookCheckOut.value =
                bookingController.endDate.value;

            // Navigasi ke halaman OrderKamarScreen
            Navigator.push<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => OrderKamarScreen(),
                fullscreenDialog: true,
              ),
            );
          }
        },
        label: const Text('Booking',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
        icon: const Icon(Icons.book, color: Colors.white),
        backgroundColor: Colors.amber,
      ),
    );
  }

  Widget buildFeature(IconData iconData, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          Icon(
            iconData,
            color: Colors.yellow[700],
            size: 28,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildPhotos(List<String> images) {
    List<Widget> list = [];
    list.add(SizedBox(
      width: 24,
    ));
    for (var i = 0; i < images.length; i++) {
      list.add(buildPhoto(images[i]));
    }
    return list;
  }

  Widget buildPhoto(String url) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        margin: EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          image: DecorationImage(
            image: AssetImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
