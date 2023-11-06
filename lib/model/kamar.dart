class ListKamarResponse {
  List<Data>? data;
  List<Ketersediaan>? ketersediaan;
  List<JumlahKamar>? jumlahKamar;
  Paging? paging;

  ListKamarResponse(
      {this.data, this.ketersediaan, this.jumlahKamar, this.paging});

  ListKamarResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['ketersediaan'] != null) {
      ketersediaan = <Ketersediaan>[];
      json['ketersediaan'].forEach((v) {
        ketersediaan!.add(new Ketersediaan.fromJson(v));
      });
    }
    if (json['jumlahKamar'] != null) {
      jumlahKamar = <JumlahKamar>[];
      json['jumlahKamar'].forEach((v) {
        jumlahKamar!.add(new JumlahKamar.fromJson(v));
      });
    }
    paging =
        json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.ketersediaan != null) {
      data['ketersediaan'] = this.ketersediaan!.map((v) => v.toJson()).toList();
    }
    if (this.jumlahKamar != null) {
      data['jumlahKamar'] = this.jumlahKamar!.map((v) => v.toJson()).toList();
    }
    if (this.paging != null) {
      data['paging'] = this.paging!.toJson();
    }
    return data;
  }
}

class Data {
  int? idJenisKamar;
  String? jenisBed;
  String? jenisKamar;
  List<Tarif>? tarif;
  int? baseHarga;
  int? kapasitas;

  Data(
      {this.idJenisKamar,
      this.jenisBed,
      this.jenisKamar,
      this.tarif,
      this.baseHarga,
      this.kapasitas});

  Data.fromJson(Map<String, dynamic> json) {
    idJenisKamar = json['id_jenis_kamar'];
    jenisBed = json['jenis_bed'];
    jenisKamar = json['jenis_kamar'];
    if (json['tarif'] != null) {
      tarif = <Tarif>[];
      json['tarif'].forEach((v) {
        tarif!.add(new Tarif.fromJson(v));
      });
    }
    baseHarga = json['base_harga'];
    kapasitas = json['kapasitas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_jenis_kamar'] = this.idJenisKamar;
    data['jenis_bed'] = this.jenisBed;
    data['jenis_kamar'] = this.jenisKamar;
    if (this.tarif != null) {
      data['tarif'] = this.tarif!.map((v) => v.toJson()).toList();
    }
    data['base_harga'] = this.baseHarga;
    data['kapasitas'] = this.kapasitas;
    return data;
  }
}

class Tarif {
  int? idTarif;
  int? harga;
  Season? season;

  Tarif({this.idTarif, this.harga, this.season});

  Tarif.fromJson(Map<String, dynamic> json) {
    idTarif = json['id_tarif'];
    harga = json['harga'];
    season =
        json['season'] != null ? new Season.fromJson(json['season']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_tarif'] = this.idTarif;
    data['harga'] = this.harga;
    if (this.season != null) {
      data['season'] = this.season!.toJson();
    }
    return data;
  }
}

class Season {
  int? idSeason;
  String? namaSeason;
  String? tanggalMulai;
  String? tanggalSelesai;

  Season(
      {this.idSeason, this.namaSeason, this.tanggalMulai, this.tanggalSelesai});

  Season.fromJson(Map<String, dynamic> json) {
    idSeason = json['id_season'];
    namaSeason = json['nama_season'];
    tanggalMulai = json['tanggal_mulai'];
    tanggalSelesai = json['tanggal_selesai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_season'] = this.idSeason;
    data['nama_season'] = this.namaSeason;
    data['tanggal_mulai'] = this.tanggalMulai;
    data['tanggal_selesai'] = this.tanggalSelesai;
    return data;
  }
}

class Ketersediaan {
  int? idJenisKamar;
  Booking? booking;
  int? jumlah;

  Ketersediaan({this.idJenisKamar, this.booking, this.jumlah});

  Ketersediaan.fromJson(Map<String, dynamic> json) {
    idJenisKamar = json['id_jenis_kamar'];
    booking =
        json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_jenis_kamar'] = this.idJenisKamar;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    data['jumlah'] = this.jumlah;
    return data;
  }
}

class Booking {
  String? tanggalCheckIn;
  String? tanggalCheckOut;

  Booking({this.tanggalCheckIn, this.tanggalCheckOut});

  Booking.fromJson(Map<String, dynamic> json) {
    tanggalCheckIn = json['tanggal_check_in'];
    tanggalCheckOut = json['tanggal_check_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal_check_in'] = this.tanggalCheckIn;
    data['tanggal_check_out'] = this.tanggalCheckOut;
    return data;
  }
}

class JumlahKamar {
  Count? cCount;
  int? idJenisKamar;

  JumlahKamar({this.cCount, this.idJenisKamar});

  JumlahKamar.fromJson(Map<String, dynamic> json) {
    cCount = json['_count'] != null ? new Count.fromJson(json['_count']) : null;
    idJenisKamar = json['id_jenis_kamar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cCount != null) {
      data['_count'] = this.cCount!.toJson();
    }
    data['id_jenis_kamar'] = this.idJenisKamar;
    return data;
  }
}

class Count {
  int? idJenisKamar;

  Count({this.idJenisKamar});

  Count.fromJson(Map<String, dynamic> json) {
    idJenisKamar = json['id_jenis_kamar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_jenis_kamar'] = this.idJenisKamar;
    return data;
  }
}

class Paging {
  int? page;
  int? totalItem;
  int? totalPage;

  Paging({this.page, this.totalItem, this.totalPage});

  Paging.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalItem = json['total_item'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_item'] = this.totalItem;
    data['total_page'] = this.totalPage;
    return data;
  }
}
