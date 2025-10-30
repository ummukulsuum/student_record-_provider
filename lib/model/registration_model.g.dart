// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegistrationModelAdapter extends TypeAdapter<RegistrationModel> {
  @override
  final int typeId = 1;

  @override
  RegistrationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegistrationModel(
      imagePath: fields[0] as String,
      name: fields[1] as String,
      age: fields[2] as int,
      grade: fields[3] as int,
      section: fields[4] as String,
      admission: fields[5] as int,
      phone: fields[6] as int,
      email: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RegistrationModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.grade)
      ..writeByte(4)
      ..write(obj.section)
      ..writeByte(5)
      ..write(obj.admission)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegistrationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
