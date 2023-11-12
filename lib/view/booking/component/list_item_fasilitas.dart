import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:p3l_gah_android/controller/booking_controller.dart';
import 'package:p3l_gah_android/controller/controllers.dart';

import '../../../theme/hotel_app_theme.dart';

class CustomListFasilitas extends StatefulWidget {
  final int idJenisFasilitas;
  final String namaFasilitas;
  final int harga;

  const CustomListFasilitas({
    required this.idJenisFasilitas,
    required this.namaFasilitas,
    required this.harga,
  });

  @override
  State<CustomListFasilitas> createState() => _CustomListFasilitasState();
}

class _CustomListFasilitasState extends State<CustomListFasilitas> {
  void decrementRoomCount() {
    final currentCount =
        bookingController.selectedFasilitasCount[widget.idJenisFasilitas] ?? 0;
    if (currentCount > 0) {
      bookingController.selectedFasilitasCount[widget.idJenisFasilitas] =
          currentCount - 1;
    }
  }

  void incrementRoomCount() {
    bookingController.selectedFasilitasCount[widget.idJenisFasilitas] =
        (bookingController.selectedFasilitasCount[widget.idJenisFasilitas] ??
                0) +
            1;
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
            Row(
              children: [
                Text(
                  "${widget.namaFasilitas}",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Color.fromRGBO(74, 77, 84, 1),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Obx(() => getItemRow(
                (bookingController
                            .selectedFasilitasCount[widget.idJenisFasilitas] ??
                        0)
                    .toString(),
                widget.namaFasilitas,
                widget.harga.toString())),
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
                    (bookingController.selectedFasilitasCount[
                                widget.idJenisFasilitas] ??
                            0)
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
            " x Kamar",
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
