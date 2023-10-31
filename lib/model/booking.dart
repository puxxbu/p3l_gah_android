import 'customer.dart';

class BookingHistory {
  String idBooking;
  Pegawai? pegawai1;
  Pegawai? pegawai2;
  DateTime tanggalBooking;
  DateTime tanggalCheckIn;
  DateTime tanggalCheckOut;
  String statusBooking;

  BookingHistory({
    required this.idBooking,
    this.pegawai1,
    this.pegawai2,
    required this.tanggalBooking,
    required this.tanggalCheckIn,
    required this.tanggalCheckOut,
    required this.statusBooking,
  });

  factory BookingHistory.fromJson(Map<String, dynamic> json) {
    return BookingHistory(
      idBooking: json['id_booking'],
      pegawai1: json['pegawai_1'] != null
          ? Pegawai.fromJson(json['pegawai_1'])
          : null,
      pegawai2: json['pegawai_2'] != null
          ? Pegawai.fromJson(json['pegawai_2'])
          : null,
      tanggalBooking: DateTime.parse(json['tanggal_booking']),
      tanggalCheckIn: DateTime.parse(json['tanggal_check_in']),
      tanggalCheckOut: DateTime.parse(json['tanggal_check_out']),
      statusBooking: json['status_booking'],
    );
  }
}

class Pegawai {
  int idPegawai;
  int idAkun;
  String namaPegawai;

  Pegawai({
    required this.idPegawai,
    required this.idAkun,
    required this.namaPegawai,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      idPegawai: json['id_pegawai'],
      idAkun: json['id_akun'],
      namaPegawai: json['nama_pegawai'],
    );
  }
}

class BookingResponse {
  late BookingData data;

  BookingResponse.fromJson(Map<String, dynamic> json) {
    data = BookingData.fromJson(json['data']);
  }
}

class BookingData {
  late String idBooking;
  late Customer customer;
  late DateTime tanggalCheckIn;
  late DateTime tanggalCheckOut;
  late int tamuDewasa;
  late int tamuAnak;
  late DateTime tanggalPembayaran;
  late List<DetailBookingKamar> detailBookingKamar;
  late List<Invoice> invoice;

  BookingData.fromJson(Map<String, dynamic> json) {
    idBooking = json['id_booking'];
    customer = Customer.fromJson(json['customer']);
    tanggalCheckIn = DateTime.parse(json['tanggal_check_in']);
    tanggalCheckOut = DateTime.parse(json['tanggal_check_out']);
    tamuDewasa = json['tamu_dewasa'];
    tamuAnak = json['tamu_anak'];
    tanggalPembayaran = DateTime.parse(json['tanggal_pembayaran']);
    detailBookingKamar = List<DetailBookingKamar>.from(
        json['detail_booking_kamar']
            .map((x) => DetailBookingKamar.fromJson(x)));
    invoice =
        List<Invoice>.from(json['invoice'].map((x) => Invoice.fromJson(x)));
  }
}

class DetailBookingKamar {
  late JenisKamar jenisKamar;
  late int subTotal;

  DetailBookingKamar.fromJson(Map<String, dynamic> json) {
    jenisKamar = JenisKamar.fromJson(json['jenis_kamar']);
    subTotal = json['sub_total'];
  }
}

class JenisKamar {
  late int idJenisKamar;
  late String jenisKamar;
  late String jenisBed;
  late int kapasitas;
  late int jumlahKasur;

  JenisKamar.fromJson(Map<String, dynamic> json) {
    idJenisKamar = json['id_jenis_kamar'];
    jenisKamar = json['jenis_kamar'];
    jenisBed = json['jenis_bed'];
    kapasitas = json['kapasitas'];
    jumlahKasur = json['jumlah_kasur'];
  }
}

class Invoice {
  late int totalPembayaran;

  Invoice.fromJson(Map<String, dynamic> json) {
    totalPembayaran = json['total_pembayaran'];
  }
}
