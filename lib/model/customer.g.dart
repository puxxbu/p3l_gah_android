// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 3;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      idCustomer: fields[0] as int,
      idAkun: fields[1] as int,
      jenisCustomer: fields[2] as String,
      nama: fields[3] as String,
      nomorIdentitas: fields[4] as String,
      nomorTelepon: fields[5] as String,
      email: fields[6] as String,
      alamat: fields[7] as String,
      tanggalDibuat: fields[8] as DateTime,
      namaInstitusi: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.idCustomer)
      ..writeByte(1)
      ..write(obj.idAkun)
      ..writeByte(2)
      ..write(obj.jenisCustomer)
      ..writeByte(3)
      ..write(obj.nama)
      ..writeByte(4)
      ..write(obj.nomorIdentitas)
      ..writeByte(5)
      ..write(obj.nomorTelepon)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.alamat)
      ..writeByte(8)
      ..write(obj.tanggalDibuat)
      ..writeByte(9)
      ..write(obj.namaInstitusi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
