import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/hotel_app_theme.dart';

class OrderKamarScreen extends StatefulWidget {
  @override
  State<OrderKamarScreen> createState() => _OrderKamarScreenState();
}

class _OrderKamarScreenState extends State<OrderKamarScreen> {
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
                            text: "Pemesanan Kamar\n",
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ],
                      ),
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
                            "Nama Jenis Kamar",
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Color.fromRGBO(74, 77, 84, 1),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Kapasitas ... orang",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(143, 148, 162, 1),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          getItemRow("3", "Kamar", "Rp 3.000.000 / malam"),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  decrementRoomCount();
                                },
                              ),
                              Text(
                                selectedRoomCount
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
                            "Order Details",
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: Color.fromRGBO(74, 77, 84, 1),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "WASHING AND FOLDING",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(143, 148, 162, 1),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          getItemRow("3", "T-shirts (man)", "\$30.00"),
                          getItemRow("2", "T-shirts (man)", "\$40.00"),
                          getItemRow("4", "Pants (man)", "\$80.00"),
                          getItemRow("1", "Jeans (man)", "\$20.00"),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            "IRONING",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(143, 148, 162, 1),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          getItemRow("3", "T-shirt (woman)", "\$30.00"),
                          Divider(),
                          getSubtotalRow("Subtotal", "\$200.00"),
                          getSubtotalRow("Delivery", "\$225.00"),
                          SizedBox(
                            height: 10.0,
                          ),
                          getTotalRow("Total", "\$225.00"),
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
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
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
                                        color: Color.fromRGBO(143, 148, 162, 1),
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
