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
