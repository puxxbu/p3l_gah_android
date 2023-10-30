import 'dart:convert';

import 'package:hive/hive.dart';

part 'customer.g.dart';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

@HiveType(typeId: 3)
class Customer {
  @HiveField(0)
  int idCustomer;
  @HiveField(1)
  int idAkun;
  @HiveField(2)
  String jenisCustomer;
  @HiveField(3)
  String nama;
  @HiveField(4)
  String nomorIdentitas;
  @HiveField(5)
  String nomorTelepon;
  @HiveField(6)
  String email;
  @HiveField(7)
  String alamat;
  @HiveField(8)
  DateTime tanggalDibuat;
  @HiveField(9)
  String? namaInstitusi;

  Customer({
    required this.idCustomer,
    required this.idAkun,
    required this.jenisCustomer,
    required this.nama,
    required this.nomorIdentitas,
    required this.nomorTelepon,
    required this.email,
    required this.alamat,
    required this.tanggalDibuat,
    this.namaInstitusi,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      idCustomer: json['data']['id_customer'],
      idAkun: json['data']['id_akun'],
      jenisCustomer: json['data']['jenis_customer'],
      nama: json['data']['nama'],
      nomorIdentitas: json['data']['nomor_identitas'],
      nomorTelepon: json['data']['nomor_telepon'],
      email: json['data']['email'],
      alamat: json['data']['alamat'],
      tanggalDibuat: DateTime.parse(json['data']['tanggal_dibuat']),
      namaInstitusi: json['data']['nama_institusi'],
    );
  }
}
