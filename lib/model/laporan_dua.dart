class LaporanDuaResponse {
  Data? data;

  LaporanDuaResponse({this.data});

  LaporanDuaResponse.fromJson(Map<String, dynamic> json) {
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
  List<TopCustomers>? topCustomers;

  Data({this.topCustomers});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['topCustomers'] != null) {
      topCustomers = <TopCustomers>[];
      json['topCustomers'].forEach((v) {
        topCustomers!.add(new TopCustomers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topCustomers != null) {
      data['topCustomers'] = this.topCustomers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopCustomers {
  String? namaCustomer;
  int? jumlahReservasi;
  int? totalPembayaran;

  TopCustomers({this.namaCustomer, this.jumlahReservasi, this.totalPembayaran});

  TopCustomers.fromJson(Map<String, dynamic> json) {
    namaCustomer = json['nama_customer'];
    jumlahReservasi = json['jumlah_reservasi'];
    totalPembayaran = json['total_pembayaran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_customer'] = this.namaCustomer;
    data['jumlah_reservasi'] = this.jumlahReservasi;
    data['total_pembayaran'] = this.totalPembayaran;
    return data;
  }
}
