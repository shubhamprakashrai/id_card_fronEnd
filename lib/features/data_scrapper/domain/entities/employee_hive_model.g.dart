// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeHiveModelAdapter extends TypeAdapter<EmployeeHiveModel> {
  @override
  final int typeId = 0;

  @override
  EmployeeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeHiveModel(
      fullName: fields[0] as String,
      designation: fields[1] as String,
      department: fields[2] as String,
      idNumber: fields[3] as String,
      issueDate: fields[4] as String,
      expiryDate: fields[5] as String,
      photoFileName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.designation)
      ..writeByte(2)
      ..write(obj.department)
      ..writeByte(3)
      ..write(obj.idNumber)
      ..writeByte(4)
      ..write(obj.issueDate)
      ..writeByte(5)
      ..write(obj.expiryDate)
      ..writeByte(6)
      ..write(obj.photoFileName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
