import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LaporanDuaScreen extends StatefulWidget {
  LaporanDuaScreen({super.key});
  @override
  State<StatefulWidget> createState() => LaporanDuaScreenState();
}

class LaporanDuaScreenState extends State<LaporanDuaScreen> {
  List<int> years = List.generate(5, (index) => DateTime.now().year - index);

  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year;
    bookingController.getLaporanDua(2023);
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                'Laporan Top 5 Customer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<int>(
                value: selectedYear,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                    bookingController.getLaporanSatu(selectedYear);
                  });
                },
                items: years.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
              Obx(
                () => Table(
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(3),
                  },
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('No'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Nama Customer'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Jumlah Reservasi'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text('Total Pembayaran'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (bookingController
                            .laporanDua.value?.data?.topCustomers !=
                        null)
                      for (int index = 0;
                          index <
                              bookingController
                                  .laporanDua.value!.data!.topCustomers!.length;
                          index++)
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text((index + 1).toString()),
                                ), // Menampilkan nomor urutan index
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(bookingController
                                          .laporanDua
                                          .value!
                                          .data!
                                          .topCustomers![index]
                                          .namaCustomer ??
                                      ''),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(bookingController
                                          .laporanDua
                                          .value!
                                          .data!
                                          .topCustomers![index]
                                          .jumlahReservasi
                                          .toString() ??
                                      ''),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: Text(currencyFormat.format(
                                          bookingController
                                              .laporanDua
                                              .value!
                                              .data!
                                              .topCustomers![index]
                                              .totalPembayaran) ??
                                      ''),
                                ),
                              ),
                            ),
                          ],
                        ),
                    // Tambahkan TableRow dan TableCell sesuai dengan jumlah data yang Anda miliki
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Dicetak pada tanggal ${DateFormat('dd MMMM yyyy').format(DateTime.now())}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  _createPdf(selectedYear);
                },
                child: Text('Cetak PDF'),
              ),
            ],
          )),
    );
  }
}

void _createPdf(int selectedYear) async {
  final doc = pw.Document();

  /// for using an image from assets
  final imageBytes = (await rootBundle.load('assets/hotel/logo-hotel.png'))
      .buffer
      .asUint8List();

  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

  final table = pw.Table(
    columnWidths: {
      0: pw.FlexColumnWidth(1),
      1: pw.FlexColumnWidth(2),
      2: pw.FlexColumnWidth(2),
      3: pw.FlexColumnWidth(3),
    },
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            child: pw.Center(
                child: pw.Text(
              'No',
            )),
          ),
          pw.Container(
            child: pw.Center(
                child: pw.Text(
              'Nama Customer',
            )),
          ),
          pw.Container(
            child: pw.Center(
                child: pw.Text(
              'Jumlah Reservasi',
            )),
          ),
          pw.Container(
            child: pw.Center(
                child: pw.Text(
              'Total Pembayaran',
            )),
          ),
        ],
      ),
      if (bookingController.laporanDua.value?.data?.topCustomers != null)
        for (int index = 0;
            index <
                bookingController.laporanDua.value!.data!.topCustomers!.length;
            index++)
          pw.TableRow(
            children: [
              pw.Container(
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text((index + 1).toString()),
                  ), // Menampilkan nomor urutan index
                ),
              ),
              pw.Container(
                child: pw.Center(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(bookingController.laporanDua.value!.data!
                            .topCustomers![index].namaCustomer ??
                        ''),
                  ),
                ),
              ),
              pw.Container(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Center(
                    child: pw.Text(bookingController.laporanDua.value!.data!
                            .topCustomers![index].jumlahReservasi
                            .toString() ??
                        ''),
                  ),
                ),
              ),
              pw.Container(
                child: pw.Center(
                  child: pw.Padding(
                    padding: pw.EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: pw.Text(currencyFormat.format(bookingController
                            .laporanDua
                            .value!
                            .data!
                            .topCustomers![index]
                            .totalPembayaran) ??
                        ''),
                  ),
                ),
              ),
            ],
          ),
    ],
  );

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
            child: pw.Column(
          children: [
            pw.Image(
              pw.MemoryImage(imageBytes),
              width: 200,
              height: 200,
            ),
            pw.SizedBox(
              height: 16,
            ),
            pw.Text(
              'Laporan Customer Baru',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(
              height: 16,
            ),
            pw.Text(
              selectedYear.toString(),
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(
              height: 16,
            ),
            table,
            pw.SizedBox(
              height: 16,
            ),
            pw.Text(
              'Dicetak pada tanggal ${DateFormat('dd MMMM yyyy').format(DateTime.now())}',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.normal,
              ),
            ),
          ],
        )); // Center
      },
    ),
  ); // Page

  /// print the document using the iOS or Android print service:
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save());

  /// share the document to other applications:
  // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

  /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
  /// save PDF with Flutter library "path_provider":
  final output = await getTemporaryDirectory();
  final file = File('${output.path}/example.pdf');
  await file.writeAsBytes(await doc.save());
}
