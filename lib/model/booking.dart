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
  late CustomerBooking customer;
  late DateTime tanggalCheckIn;
  late DateTime tanggalCheckOut;
  late int tamuDewasa;
  late int tamuAnak;
  late DateTime tanggalPembayaran;
  late List<DetailBookingKamar> detailBookingKamar;
  late List<Layanan> detailBookingLayanan;
  late List<Invoice> invoice;

  BookingData.fromJson(Map<String, dynamic> json) {
    idBooking = json['id_booking'];
    customer = CustomerBooking.fromJson(json['customer']);
    tanggalCheckIn = DateTime.parse(json['tanggal_check_in']);
    tanggalCheckOut = DateTime.parse(json['tanggal_check_out']);
    tamuDewasa = json['tamu_dewasa'];
    tamuAnak = json['tamu_anak'];
    tanggalPembayaran = DateTime.parse(json['tanggal_pembayaran']);
    detailBookingKamar = List<DetailBookingKamar>.from(
        json['detail_booking_kamar']
            .map((x) => DetailBookingKamar.fromJson(x)));
    detailBookingLayanan = List<Layanan>.from(
        json['detail_booking_layanan'].map((x) => Layanan.fromJson(x)));
    invoice =
        List<Invoice>.from(json['invoice'].map((x) => Invoice.fromJson(x)));
  }
}

class DetailBookingKamar {
  late JenisKamar jenisKamar;
  late int jumlah;
  late int subTotal;

  DetailBookingKamar.fromJson(Map<String, dynamic> json) {
    jenisKamar = JenisKamar.fromJson(json['jenis_kamar']);
    jumlah = json['jumlah'];
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
  late String idInvoice;
  late String idBooking;
  late DateTime tanggalPelunasan;
  late int totalPajak;
  late int jumlahJaminan;
  late int totalPembayaran;
  late String namaPicFO;

  Invoice.fromJson(Map<String, dynamic> json) {
    idInvoice = json['id_invoice'];
    idBooking = json['id_booking'];
    tanggalPelunasan = DateTime.parse(json['tanggal_pelunasan']);
    totalPajak = json['total_pajak'];
    jumlahJaminan = json['jumlah_jaminan'];
    totalPembayaran = json['total_pembayaran'];
    namaPicFO = json['nama_pic_fo'];
  }
}

class Layanan {
  late Fasilitas fasilitas;
  late int jumlah;
  late int subTotal;
  late DateTime tanggal;

  Layanan.fromJson(Map<String, dynamic> json) {
    fasilitas = Fasilitas.fromJson(json['layanan']);
    jumlah = json['jumlah'];
    subTotal = json['sub_total'];
    tanggal = DateTime.parse(json['tanggal']);
  }
}

class Fasilitas {
  int? idFasilitas;
  String? namaLayanan;
  int? harga;

  Fasilitas({this.idFasilitas, this.namaLayanan, this.harga});

  Fasilitas.fromJson(Map<String, dynamic> json) {
    idFasilitas = json['id_fasilitas'];
    namaLayanan = json['nama_layanan'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_fasilitas'] = this.idFasilitas;
    data['nama_layanan'] = this.namaLayanan;
    data['harga'] = this.harga;
    return data;
  }
}

class CustomerBooking {
  int? idCustomer;
  int? idAkun;
  String? jenisCustomer;
  String? nama;
  String? nomorIdentitas;
  String? nomorTelepon;
  String? email;
  String? alamat;
  String? tanggalDibuat;
  String? namaInstitusi;

  CustomerBooking(
      {this.idCustomer,
      this.idAkun,
      this.jenisCustomer,
      this.nama,
      this.nomorIdentitas,
      this.nomorTelepon,
      this.email,
      this.alamat,
      this.tanggalDibuat,
      this.namaInstitusi});

  CustomerBooking.fromJson(Map<String, dynamic> json) {
    idCustomer = json['id_customer'];
    idAkun = json['id_akun'];
    jenisCustomer = json['jenis_customer'];
    nama = json['nama'];
    nomorIdentitas = json['nomor_identitas'];
    nomorTelepon = json['nomor_telepon'];
    email = json['email'];
    alamat = json['alamat'];
    tanggalDibuat = json['tanggal_dibuat'];
    namaInstitusi = json['nama_institusi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_customer'] = this.idCustomer;
    data['id_akun'] = this.idAkun;
    data['jenis_customer'] = this.jenisCustomer;
    data['nama'] = this.nama;
    data['nomor_identitas'] = this.nomorIdentitas;
    data['nomor_telepon'] = this.nomorTelepon;
    data['email'] = this.email;
    data['alamat'] = this.alamat;
    data['tanggal_dibuat'] = this.tanggalDibuat;
    data['nama_institusi'] = this.namaInstitusi;
    return data;
  }
}
