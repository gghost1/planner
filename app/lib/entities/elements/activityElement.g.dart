// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activityElement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityElementAdapter extends TypeAdapter<ActivityElement> {
  @override
  final int typeId = 3;

  @override
  ActivityElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityElement(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityElement obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.information);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}