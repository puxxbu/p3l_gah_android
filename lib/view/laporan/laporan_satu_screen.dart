import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p3l_gah_android/controller/controllers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LaporanSatuScreen extends StatefulWidget {
  LaporanSatuScreen({super.key});
  @override
  State<StatefulWidget> createState() => LaporanSatuScreenState();
}

class LaporanSatuScreenState extends State<LaporanSatuScreen> {
  List<int> years = List.generate(5, (index) => DateTime.now().year - index);

  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = DateTime.now().year;
    bookingController.getLaporanSatu(2023);
  }

  @override
  Widget build(BuildContext context) {
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
                'Laporan Customer Baru',
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
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text('No'),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Bulan'),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('Jumlah'),
                          ),
                        ),
                      ],
                    ),
                    if (bookingController.laporanSatu.value?.data?.laporan !=
                        null)
                      for (int index = 0;
                          index <
                              bookingController
                                  .laporanSatu.value!.data!.laporan!.length;
                          index++)
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(
                                child: Text((index + 1)
                                    .toString()), // Menampilkan nomor urutan index
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Text(bookingController.laporanSatu.value!
                                        .data!.laporan![index].namaBulan ??
                                    ''),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Text(bookingController.laporanSatu.value!
                                        .data!.laporan![index].customerBaru
                                        .toString() ??
                                    ''),
                              ),
                            ),
                          ],
                        ),
                    // Tambahkan TableRow dan TableCell sesuai dengan jumlah data yang Anda miliki
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(''),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(''),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(bookingController
                                    .laporanSatu.value?.data?.total
                                    .toString() ??
                                ''),
                          ),
                        ),
                      ],
                    ),
                  ],
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

  final table = pw.Table(
    border: pw.TableBorder.all(),
    children: [
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('No'),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('Bulan'),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text('Jumlah'),
          ),
        ],
      ),
      if (bookingController.laporanSatu.value?.data?.laporan != null)
        for (int index = 0;
            index < bookingController.laporanSatu.value!.data!.laporan!.length;
            index++)
          pw.TableRow(
            children: [
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  (index + 1).toString(),
                ),
              ),
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  bookingController
                          .laporanSatu.value!.data!.laporan![index].namaBulan ??
                      '',
                ),
              ),
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  bookingController
                          .laporanSatu.value!.data!.laporan![index].customerBaru
                          .toString() ??
                      '',
                ),
              ),
            ],
          ),
      pw.TableRow(
        children: [
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text(''),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text(''),
          ),
          pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Text(
              bookingController.laporanSatu.value?.data?.total.toString() ?? '',
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
