class BookingHIstoryDetailResponse {
  Data? data;

  BookingHIstoryDetailResponse({this.data});

  BookingHIstoryDetailResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? idBooking;
  Customer? customer;
  Pegawai2? pegawai1;
  Pegawai2? pegawai2;
  String? noRekening;
  String? statusBooking;
  String? tanggalCheckIn;
  String? tanggalCheckOut;
  int? tamuDewasa;
  int? tamuAnak;
  String? tanggalPembayaran;
  List<DetailBookingKamar>? detailBookingKamar;
  List<DetailBookingLayanan>? detailBookingLayanan;

  Data({
    this.idBooking,
    this.customer,
    this.pegawai1,
    this.pegawai2,
    this.noRekening,
    this.statusBooking,
    this.tanggalCheckIn,
    this.tanggalCheckOut,
    this.tamuDewasa,
    this.tamuAnak,
    this.tanggalPembayaran,
    this.detailBookingKamar,
    this.detailBookingLayanan,
  });

  Data.fromJson(Map<String, dynamic> json) {
    idBooking = json['id_booking'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    pegawai1 = json['pegawai_1'];
    pegawai2 = json['pegawai_2'] != null
        ? new Pegawai2.fromJson(json['pegawai_2'])
        : null;
    noRekening = json['no_rekening'];
    statusBooking = json['status_booking'];
    tanggalCheckIn = json['tanggal_check_in'];
    tanggalCheckOut = json['tanggal_check_out'];
    tamuDewasa = json['tamu_dewasa'];
    tamuAnak = json['tamu_anak'];
    tanggalPembayaran = json['tanggal_pembayaran'];
    if (json['detail_booking_kamar'] != null) {
      detailBookingKamar = <DetailBookingKamar>[];
      json['detail_booking_kamar'].forEach((v) {
        detailBookingKamar!.add(new DetailBookingKamar.fromJson(v));
      });
    }
    if (json['detail_booking_layanan'] != null) {
      detailBookingLayanan = <DetailBookingLayanan>[];
      json['detail_booking_layanan'].forEach((v) {
        detailBookingLayanan!.add(new DetailBookingLayanan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_booking'] = this.idBooking;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['pegawai_1'] = this.pegawai1;
    if (this.pegawai2 != null) {
      data['pegawai_2'] = this.pegawai2!.toJson();
    }
    data['no_rekening'] = this.noRekening;
    data['status_booking'] = this.statusBooking;
    data['tanggal_check_in'] = this.tanggalCheckIn;
    data['tanggal_check_out'] = this.tanggalCheckOut;
    data['tamu_dewasa'] = this.tamuDewasa;
    data['tamu_anak'] = this.tamuAnak;
    data['tanggal_pembayaran'] = this.tanggalPembayaran;
    if (this.detailBookingKamar != null) {
      data['detail_booking_kamar'] =
          this.detailBookingKamar!.map((v) => v.toJson()).toList();
    }
    if (this.detailBookingLayanan != null) {
      data['detail_booking_layanan'] =
          this.detailBookingLayanan!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Customer {
  int? idCustomer;
  int? idAkun;
  String? jenisCustomer;
  String? nama;
  String? nomorIdentitas;
  String? nomorTelepon;
  String? email;
  String? alamat;
  String? tanggalDibuat;
  Null? namaInstitusi;

  Customer(
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

  Customer.fromJson(Map<String, dynamic> json) {
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

class Pegawai2 {
  int? idPegawai;
  int? idAkun;
  String? namaPegawai;

  Pegawai2({this.idPegawai, this.idAkun, this.namaPegawai});

  Pegawai2.fromJson(Map<String, dynamic> json) {
    idPegawai = json['id_pegawai'];
    idAkun = json['id_akun'];
    namaPegawai = json['nama_pegawai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pegawai'] = this.idPegawai;
    data['id_akun'] = this.idAkun;
    data['nama_pegawai'] = this.namaPegawai;
    return data;
  }
}

class DetailBookingKamar {
  int? idDetailBookingKamar;
  String? idBooking;
  JenisKamar? jenisKamar;
  int? jumlah;
  int? subTotal;
  List<DetailKetersediaanKamar>? detailKetersediaanKamar;

  DetailBookingKamar(
      {this.idDetailBookingKamar,
      this.idBooking,
      this.jenisKamar,
      this.jumlah,
      this.subTotal,
      this.detailKetersediaanKamar});

  DetailBookingKamar.fromJson(Map<String, dynamic> json) {
    idDetailBookingKamar = json['id_detail_booking_kamar'];
    idBooking = json['id_booking'];
    jenisKamar = json['jenis_kamar'] != null
        ? new JenisKamar.fromJson(json['jenis_kamar'])
        : null;
    jumlah = json['jumlah'];
    subTotal = json['sub_total'];
    if (json['detail_ketersediaan_kamar'] != null) {
      detailKetersediaanKamar = <DetailKetersediaanKamar>[];
      json['detail_ketersediaan_kamar'].forEach((v) {
        detailKetersediaanKamar!.add(new DetailKetersediaanKamar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_detail_booking_kamar'] = this.idDetailBookingKamar;
    data['id_booking'] = this.idBooking;
    if (this.jenisKamar != null) {
      data['jenis_kamar'] = this.jenisKamar!.toJson();
    }
    data['jumlah'] = this.jumlah;
    data['sub_total'] = this.subTotal;
    if (this.detailKetersediaanKamar != null) {
      data['detail_ketersediaan_kamar'] =
          this.detailKetersediaanKamar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JenisKamar {
  int? idJenisKamar;
  String? jenisKamar;
  String? jenisBed;
  int? kapasitas;
  int? jumlahKasur;
  int? baseHarga;

  JenisKamar(
      {this.idJenisKamar,
      this.jenisKamar,
      this.jenisBed,
      this.kapasitas,
      this.jumlahKasur,
      this.baseHarga});

  JenisKamar.fromJson(Map<String, dynamic> json) {
    idJenisKamar = json['id_jenis_kamar'];
    jenisKamar = json['jenis_kamar'];
    jenisBed = json['jenis_bed'];
    kapasitas = json['kapasitas'];
    jumlahKasur = json['jumlah_kasur'];
    baseHarga = json['base_harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_jenis_kamar'] = this.idJenisKamar;
    data['jenis_kamar'] = this.jenisKamar;
    data['jenis_bed'] = this.jenisBed;
    data['kapasitas'] = this.kapasitas;
    data['jumlah_kasur'] = this.jumlahKasur;
    data['base_harga'] = this.baseHarga;
    return data;
  }
}

class DetailKetersediaanKamar {
  Kamar? kamar;

  DetailKetersediaanKamar({this.kamar});

  DetailKetersediaanKamar.fromJson(Map<String, dynamic> json) {
    kamar = json['kamar'] != null ? new Kamar.fromJson(json['kamar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kamar != null) {
      data['kamar'] = this.kamar!.toJson();
    }
    return data;
  }
}

class Kamar {
  JenisKamar? jenisKamar;
  int? nomorKamar;

  Kamar({this.jenisKamar, this.nomorKamar});

  Kamar.fromJson(Map<String, dynamic> json) {
    jenisKamar = json['jenis_kamar'] != null
        ? new JenisKamar.fromJson(json['jenis_kamar'])
        : null;
    nomorKamar = json['nomor_kamar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jenisKamar != null) {
      data['jenis_kamar'] = this.jenisKamar!.toJson();
    }
    data['nomor_kamar'] = this.nomorKamar;
    return data;
  }
}

class DetailBookingLayanan {
  Layanan? layanan;
  int? jumlah;
  int? subTotal;
  String? tanggal;

  DetailBookingLayanan(
      {this.layanan, this.jumlah, this.subTotal, this.tanggal});

  DetailBookingLayanan.fromJson(Map<String, dynamic> json) {
    layanan =
        json['layanan'] != null ? new Layanan.fromJson(json['layanan']) : null;
    jumlah = json['jumlah'];
    subTotal = json['sub_total'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.layanan != null) {
      data['layanan'] = this.layanan!.toJson();
    }
    data['jumlah'] = this.jumlah;
    data['sub_total'] = this.subTotal;
    data['tanggal'] = this.tanggal;
    return data;
  }
}

class Layanan {
  int? idFasilitas;
  String? namaLayanan;
  int? harga;

  Layanan({this.idFasilitas, this.namaLayanan, this.harga});

  Layanan.fromJson(Map<String, dynamic> json) {
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
