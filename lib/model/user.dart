import 'dart:convert';

import 'package:hive/hive.dart';

part 'user.g.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

@HiveType(typeId: 4)
class User {
  @HiveField(0)
  Data? data;

  User({this.data});

  User.fromJson(Map<String, dynamic> json) {
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

@HiveType(typeId: 5)
class Data {
  @HiveField(0)
  String? token;
  @HiveField(1)
  Role? role;

  Data({this.token, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 6)
class Role {
  @HiveField(0)
  int? idRole;
  @HiveField(1)
  String? namaRole;

  Role({this.idRole, this.namaRole});

  Role.fromJson(Map<String, dynamic> json) {
    idRole = json['id_role'];
    namaRole = json['nama_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_role'] = this.idRole;
    data['nama_role'] = this.namaRole;
    return data;
  }
}
