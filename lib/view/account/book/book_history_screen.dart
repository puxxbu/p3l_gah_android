import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:p3l_gah_android/model/booking.dart';
import 'package:p3l_gah_android/util/string_extention.dart';

import '../../../component/input_outline_button.dart';
import '../../../controller/controllers.dart';
import '../../../theme/hotel_app_theme.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  @override
  void initState() {
    super.initState();
    bookingController.refreshData();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    Future onRefresh() async {
      bookingController.refreshData();
    }

    void onScroll() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      if (maxScroll == currentScroll && bookingController.hasMore.value) {
        bookingController.getHistoryBooking();
      }
    }

    scrollController.addListener(onScroll);
    return Scaffold(
      backgroundColor: HotelAppTheme.buildLightTheme().primaryColor,
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.only(top: 2.0, bottom: 2),
            child: ListView.builder(
                controller: scrollController,
                itemCount: bookingController.hasMore.value
                    ? bookingController.bookingHistory.length + 1
                    : bookingController.bookingHistory.length,
                itemBuilder: (context, index) {
                  if (index < bookingController.bookingHistory.length) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 12.0,
                          right:
                              12), // Memberikan margin bawah sebesar 16.0 pada setiap buildAccountCard
                      child: buildAccountCard(
                        dataBooking: bookingController.bookingHistory[index],
                        onClick: () {
                          Get.toNamed('/booking/detail',
                              arguments: bookingController
                                  .bookingHistory[index].idBooking);
                        },
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                }),
          ),
        ),
      ),
    );
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(dataBooking.statusBooking),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Status: ${dataBooking.statusBooking}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
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

Color _getStatusColor(String status) {
  switch (status) {
    case 'Check Out':
      return Colors.orange;
    case 'Check In':
      return Colors.blue;
    case 'Booked':
      return Colors.teal;
    case 'Jaminan Sudah Dibayar':
      return Colors.green;
    case 'Jaminan Sudah Dibayar':
      return Colors.green;
    case 'Dibatalkan (Uang Kembali)':
      return Colors.red;
    case 'Dibatalkan':
      return Colors.red;
    default:
      return Colors.transparent;
  }
}
