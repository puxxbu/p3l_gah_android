class LaporanSatuResponse {
  Data? data;

  LaporanSatuResponse({this.data});

  LaporanSatuResponse.fromJson(Map<String, dynamic> json) {
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
  List<Laporan>? laporan;
  int? tahun;
  int? total;

  Data({this.laporan, this.tahun, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['laporan'] != null) {
      laporan = <Laporan>[];
      json['laporan'].forEach((v) {
        laporan!.add(new Laporan.fromJson(v));
      });
    }
    tahun = json['tahun'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.laporan != null) {
      data['laporan'] = this.laporan!.map((v) => v.toJson()).toList();
    }
    data['tahun'] = this.tahun;
    data['total'] = this.total;
    return data;
  }
}

class Laporan {
  String? namaBulan;
  int? customerBaru;

  Laporan({this.namaBulan, this.customerBaru});

  Laporan.fromJson(Map<String, dynamic> json) {
    namaBulan = json['nama_bulan'];
    customerBaru = json['customer_baru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_bulan'] = this.namaBulan;
    data['customer_baru'] = this.customerBaru;
    return data;
  }
}
