class UserData {
  final String username;
  final String email;
  final String password;
  final String confirm;
  final String nama;
  final String nomorIdentitas;
  final String nomorTelepon;
  final String alamat;

  UserData({
    required this.username,
    required this.email,
    required this.password,
    required this.confirm,
    required this.nama,
    required this.nomorIdentitas,
    required this.nomorTelepon,
    required this.alamat,
  });
}

class RegisterData {
  List<Data> data;

  RegisterData({required this.data});

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    List<dynamic> dataList = json['data'];
    List<Data> data = dataList.map((item) => Data.fromJson(item)).toList();

    return RegisterData(data: data);
  }
}

class Data {
  String? username;
  int? roleId;
  String? nama;
  String? jenisCustomer;

  Data({this.username, this.roleId, this.nama, this.jenisCustomer});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      username: json['username'],
      roleId: json['id_role'],
      nama: json['nama'],
      jenisCustomer: json['jenis_customer'],
    );
  }
}
