class ListFasilitasResponse {
  List<FasilitasData>? data;
  Paging? paging;

  ListFasilitasResponse({this.data, this.paging});

  ListFasilitasResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FasilitasData>[];
      json['data'].forEach((v) {
        data!.add(new FasilitasData.fromJson(v));
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
    if (this.paging != null) {
      data['paging'] = this.paging!.toJson();
    }
    return data;
  }
}

class FasilitasData {
  int? idFasilitas;
  String? namaLayanan;
  int? harga;

  FasilitasData({this.idFasilitas, this.namaLayanan, this.harga});

  FasilitasData.fromJson(Map<String, dynamic> json) {
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
